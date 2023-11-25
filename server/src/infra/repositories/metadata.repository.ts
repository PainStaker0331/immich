import {
  GeoPoint,
  IMetadataRepository,
  ImmichTags,
  ISystemMetadataRepository,
  ReverseGeocodeResult,
} from '@app/domain';
import { GeodataAdmin1Entity, GeodataAdmin2Entity, GeodataPlacesEntity, SystemMetadataKey } from '@app/infra/entities';
import { DatabaseLock } from '@app/infra/utils/database-locks';
import { Inject, Logger } from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { DefaultReadTaskOptions, exiftool } from 'exiftool-vendored';
import { createReadStream, existsSync } from 'fs';
import { readFile } from 'fs/promises';
import * as geotz from 'geo-tz';
import { getName } from 'i18n-iso-countries';
import * as readLine from 'readline';
import { DataSource, DeepPartial, QueryRunner, Repository } from 'typeorm';

type GeoEntity = GeodataPlacesEntity | GeodataAdmin1Entity | GeodataAdmin2Entity;
type GeoEntityClass = typeof GeodataPlacesEntity | typeof GeodataAdmin1Entity | typeof GeodataAdmin2Entity;

const CITIES_FILE = 'cities500.txt';

export class MetadataRepository implements IMetadataRepository {
  constructor(
    @InjectRepository(GeodataPlacesEntity) private readonly geodataPlacesRepository: Repository<GeodataPlacesEntity>,
    @InjectRepository(GeodataAdmin1Entity) private readonly geodataAdmin1Repository: Repository<GeodataAdmin1Entity>,
    @InjectRepository(GeodataAdmin2Entity) private readonly geodataAdmin2Repository: Repository<GeodataAdmin2Entity>,
    @Inject(ISystemMetadataRepository) private readonly systemMetadataRepository: ISystemMetadataRepository,
    @InjectDataSource() private dataSource: DataSource,
  ) {}

  private logger = new Logger(MetadataRepository.name);

  async init(): Promise<void> {
    this.logger.log('Initializing metadata repository');
    const geodataDate = await readFile('/usr/src/resources/geodata-date.txt', 'utf8');

    await this.geodataPlacesRepository.query('SELECT pg_advisory_lock($1)', [DatabaseLock.GeodataImport]);

    const geocodingMetadata = await this.systemMetadataRepository.get(SystemMetadataKey.REVERSE_GEOCODING_STATE);

    if (geocodingMetadata?.lastUpdate === geodataDate) {
      await this.dataSource.query('SELECT pg_advisory_unlock($1)', [DatabaseLock.GeodataImport]);
      return;
    }

    this.logger.log('Importing geodata to database from file');

    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();

    try {
      await queryRunner.startTransaction();

      await this.loadCities500(queryRunner);
      await this.loadAdmin1(queryRunner);
      await this.loadAdmin2(queryRunner);

      await queryRunner.commitTransaction();
    } catch (e) {
      this.logger.fatal('Error importing geodata', e);
      await queryRunner.rollbackTransaction();
      throw e;
    } finally {
      await queryRunner.release();
    }

    await this.systemMetadataRepository.set(SystemMetadataKey.REVERSE_GEOCODING_STATE, {
      lastUpdate: geodataDate,
      lastImportFileName: CITIES_FILE,
    });

    await this.dataSource.query('SELECT pg_advisory_unlock($1)', [DatabaseLock.GeodataImport]);
    this.logger.log('Geodata import completed');
  }

  private async loadGeodataToTableFromFile<T extends GeoEntity>(
    queryRunner: QueryRunner,
    lineToEntityMapper: (lineSplit: string[]) => T,
    filePath: string,
    entity: GeoEntityClass,
  ) {
    if (!existsSync(filePath)) {
      this.logger.error(`Geodata file ${filePath} not found`);
      throw new Error(`Geodata file ${filePath} not found`);
    }
    await queryRunner.manager.clear(entity);

    const input = createReadStream(filePath);
    let buffer: DeepPartial<T>[] = [];
    const lineReader = readLine.createInterface({ input: input });

    for await (const line of lineReader) {
      const lineSplit = line.split('\t');
      buffer.push(lineToEntityMapper(lineSplit));
      if (buffer.length > 1000) {
        await queryRunner.manager.save(buffer);
        buffer = [];
      }
    }
    await queryRunner.manager.save(buffer);
  }

  private async loadCities500(queryRunner: QueryRunner) {
    await this.loadGeodataToTableFromFile<GeodataPlacesEntity>(
      queryRunner,
      (lineSplit: string[]) =>
        this.geodataPlacesRepository.create({
          id: parseInt(lineSplit[0]),
          name: lineSplit[1],
          latitude: parseFloat(lineSplit[4]),
          longitude: parseFloat(lineSplit[5]),
          countryCode: lineSplit[8],
          admin1Code: lineSplit[10],
          admin2Code: lineSplit[11],
          modificationDate: lineSplit[18],
        }),
      `/usr/src/resources/${CITIES_FILE}`,
      GeodataPlacesEntity,
    );
  }

  private async loadAdmin1(queryRunner: QueryRunner) {
    await this.loadGeodataToTableFromFile<GeodataAdmin1Entity>(
      queryRunner,
      (lineSplit: string[]) =>
        this.geodataAdmin1Repository.create({
          key: lineSplit[0],
          name: lineSplit[1],
        }),
      '/usr/src/resources/admin1CodesASCII.txt',
      GeodataAdmin1Entity,
    );
  }

  private async loadAdmin2(queryRunner: QueryRunner) {
    await this.loadGeodataToTableFromFile<GeodataAdmin2Entity>(
      queryRunner,
      (lineSplit: string[]) =>
        this.geodataAdmin2Repository.create({
          key: lineSplit[0],
          name: lineSplit[1],
        }),
      '/usr/src/resources/admin2Codes.txt',
      GeodataAdmin2Entity,
    );
  }

  async teardown() {
    await exiftool.end();
  }

  async reverseGeocode(point: GeoPoint): Promise<ReverseGeocodeResult | null> {
    this.logger.debug(`Request: ${point.latitude},${point.longitude}`);

    const response = await this.geodataPlacesRepository
      .createQueryBuilder('geoplaces')
      .leftJoinAndSelect('geoplaces.admin1', 'admin1')
      .leftJoinAndSelect('geoplaces.admin2', 'admin2')
      .where('earth_box(ll_to_earth(:latitude, :longitude), 25000) @> "earthCoord"', point)
      .orderBy('earth_distance(ll_to_earth(:latitude, :longitude), "earthCoord")')
      .limit(1)
      .getOne();

    if (!response) {
      this.logger.warn(
        `Response from database for reverse geocoding latitude: ${point.latitude}, longitude: ${point.longitude} was null`,
      );
      return null;
    }

    this.logger.verbose(`Raw: ${JSON.stringify(response, null, 2)}`);

    const { countryCode, name: city, admin1, admin2 } = response;
    const country = getName(countryCode, 'en') ?? null;
    const stateParts = [admin2?.name, admin1?.name].filter((name) => !!name);
    const state = stateParts.length > 0 ? stateParts.join(', ') : null;

    return { country, state, city };
  }

  getExifTags(path: string): Promise<ImmichTags | null> {
    return exiftool
      .read(path, undefined, {
        ...DefaultReadTaskOptions,

        defaultVideosToUTC: true,
        backfillTimezones: true,
        inferTimezoneFromDatestamps: true,
        useMWG: true,
        numericTags: DefaultReadTaskOptions.numericTags.concat(['FocalLength']),
        geoTz: (lat, lon) => geotz.find(lat, lon)[0],
      })
      .catch((error) => {
        this.logger.warn(`Error reading exif data (${path}): ${error}`, error?.stack);
        return null;
      }) as Promise<ImmichTags | null>;
  }
}
