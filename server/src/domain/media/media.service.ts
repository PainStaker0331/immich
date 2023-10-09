import { AssetEntity, AssetType, Colorspace, TranscodeHWAccel, TranscodePolicy, VideoCodec } from '@app/infra/entities';
import { Inject, Injectable, Logger, UnsupportedMediaTypeException } from '@nestjs/common';
import { IAssetRepository, WithoutProperty } from '../asset';
import { usePagination } from '../domain.util';
import { IBaseJob, IEntityJob, IJobRepository, JOBS_ASSET_PAGINATION_SIZE, JobName, QueueName } from '../job';
import { IPersonRepository } from '../person';
import { IStorageRepository, StorageCore, StorageFolder } from '../storage';
import { ISystemConfigRepository, SystemConfigFFmpegDto } from '../system-config';
import { SystemConfigCore } from '../system-config/system-config.core';
import { AudioStreamInfo, IMediaRepository, VideoCodecHWConfig, VideoStreamInfo } from './media.repository';
import { H264Config, HEVCConfig, NVENCConfig, QSVConfig, ThumbnailConfig, VAAPIConfig, VP9Config } from './media.util';

@Injectable()
export class MediaService {
  private logger = new Logger(MediaService.name);
  private configCore: SystemConfigCore;
  private storageCore: StorageCore;

  constructor(
    @Inject(IAssetRepository) private assetRepository: IAssetRepository,
    @Inject(IPersonRepository) private personRepository: IPersonRepository,
    @Inject(IJobRepository) private jobRepository: IJobRepository,
    @Inject(IMediaRepository) private mediaRepository: IMediaRepository,
    @Inject(IStorageRepository) private storageRepository: IStorageRepository,
    @Inject(ISystemConfigRepository) configRepository: ISystemConfigRepository,
  ) {
    this.configCore = SystemConfigCore.create(configRepository);
    this.storageCore = new StorageCore(this.storageRepository);
  }

  async handleQueueGenerateThumbnails({ force }: IBaseJob) {
    const assetPagination = usePagination(JOBS_ASSET_PAGINATION_SIZE, (pagination) => {
      return force
        ? this.assetRepository.getAll(pagination)
        : this.assetRepository.getWithout(pagination, WithoutProperty.THUMBNAIL);
    });

    for await (const assets of assetPagination) {
      for (const asset of assets) {
        if (!asset.resizePath || force) {
          await this.jobRepository.queue({ name: JobName.GENERATE_JPEG_THUMBNAIL, data: { id: asset.id } });
          continue;
        }
        if (!asset.webpPath) {
          await this.jobRepository.queue({ name: JobName.GENERATE_WEBP_THUMBNAIL, data: { id: asset.id } });
        }
        if (!asset.thumbhash) {
          await this.jobRepository.queue({ name: JobName.GENERATE_THUMBHASH_THUMBNAIL, data: { id: asset.id } });
        }
      }
    }

    const people = force ? await this.personRepository.getAll() : await this.personRepository.getAllWithoutThumbnail();

    for (const person of people) {
      if (!person.faceAssetId) {
        const face = await this.personRepository.getRandomFace(person.id);
        if (!face) {
          continue;
        }

        await this.personRepository.update({ id: person.id, faceAssetId: face.assetId });
      }

      await this.jobRepository.queue({ name: JobName.GENERATE_PERSON_THUMBNAIL, data: { id: person.id } });
    }

    return true;
  }

  async handleQueueMigration() {
    const assetPagination = usePagination(JOBS_ASSET_PAGINATION_SIZE, (pagination) =>
      this.assetRepository.getAll(pagination),
    );

    const { active, waiting } = await this.jobRepository.getJobCounts(QueueName.MIGRATION);
    if (active === 1 && waiting === 0) {
      await this.storageCore.removeEmptyDirs(StorageFolder.THUMBNAILS);
      await this.storageCore.removeEmptyDirs(StorageFolder.ENCODED_VIDEO);
    }

    for await (const assets of assetPagination) {
      for (const asset of assets) {
        await this.jobRepository.queue({ name: JobName.MIGRATE_ASSET, data: { id: asset.id } });
      }
    }

    const people = await this.personRepository.getAll();
    for (const person of people) {
      await this.jobRepository.queue({ name: JobName.MIGRATE_PERSON, data: { id: person.id } });
    }

    return true;
  }

  async handleAssetMigration({ id }: IEntityJob) {
    const [asset] = await this.assetRepository.getByIds([id]);
    if (!asset) {
      return false;
    }

    if (asset.resizePath) {
      const resizePath = this.ensureThumbnailPath(asset, 'jpeg');
      if (asset.resizePath !== resizePath) {
        await this.storageRepository.moveFile(asset.resizePath, resizePath);
        await this.assetRepository.save({ id: asset.id, resizePath });
      }
    }

    if (asset.webpPath) {
      const webpPath = this.ensureThumbnailPath(asset, 'webp');
      if (asset.webpPath !== webpPath) {
        await this.storageRepository.moveFile(asset.webpPath, webpPath);
        await this.assetRepository.save({ id: asset.id, webpPath });
      }
    }

    if (asset.encodedVideoPath) {
      const encodedVideoPath = this.ensureEncodedVideoPath(asset, 'mp4');
      if (asset.encodedVideoPath !== encodedVideoPath) {
        await this.storageRepository.moveFile(asset.encodedVideoPath, encodedVideoPath);
        await this.assetRepository.save({ id: asset.id, encodedVideoPath });
      }
    }

    return true;
  }

  async handleGenerateJpegThumbnail({ id }: IEntityJob) {
    const [asset] = await this.assetRepository.getByIds([id]);
    if (!asset) {
      return false;
    }

    const resizePath = await this.generateThumbnail(asset, 'jpeg');
    await this.assetRepository.save({ id: asset.id, resizePath });
    return true;
  }

  async generateThumbnail(asset: AssetEntity, format: 'jpeg' | 'webp') {
    let path;
    switch (asset.type) {
      case AssetType.IMAGE:
        path = await this.generateImageThumbnail(asset, format);
        break;
      case AssetType.VIDEO:
        path = await this.generateVideoThumbnail(asset, format);
        break;
      default:
        throw new UnsupportedMediaTypeException(`Unsupported asset type for thumbnail generation: ${asset.type}`);
    }
    this.logger.log(
      `Successfully generated ${format.toUpperCase()} ${asset.type.toLowerCase()} thumbnail for asset ${asset.id}`,
    );
    return path;
  }

  async generateImageThumbnail(asset: AssetEntity, format: 'jpeg' | 'webp') {
    const { thumbnail } = await this.configCore.getConfig();
    const size = format === 'jpeg' ? thumbnail.jpegSize : thumbnail.webpSize;
    const path = this.ensureThumbnailPath(asset, format);
    const colorspace = this.isSRGB(asset) ? Colorspace.SRGB : thumbnail.colorspace;
    const thumbnailOptions = { format, size, colorspace, quality: thumbnail.quality };
    await this.mediaRepository.resize(asset.originalPath, path, thumbnailOptions);
    return path;
  }

  async generateVideoThumbnail(asset: AssetEntity, format: 'jpeg' | 'webp') {
    const { ffmpeg, thumbnail } = await this.configCore.getConfig();
    const size = format === 'jpeg' ? thumbnail.jpegSize : thumbnail.webpSize;
    const { audioStreams, videoStreams } = await this.mediaRepository.probe(asset.originalPath);
    const mainVideoStream = this.getMainStream(videoStreams);
    if (!mainVideoStream) {
      this.logger.warn(`Skipped thumbnail generation for asset ${asset.id}: no video streams found`);
      return;
    }
    const mainAudioStream = this.getMainStream(audioStreams);
    const path = this.ensureThumbnailPath(asset, format);
    const config = { ...ffmpeg, targetResolution: size.toString() };
    const options = new ThumbnailConfig(config).getOptions(mainVideoStream, mainAudioStream);
    await this.mediaRepository.transcode(asset.originalPath, path, options);
    return path;
  }

  async handleGenerateWebpThumbnail({ id }: IEntityJob) {
    const [asset] = await this.assetRepository.getByIds([id]);
    if (!asset) {
      return false;
    }

    const webpPath = await this.generateThumbnail(asset, 'webp');
    await this.assetRepository.save({ id: asset.id, webpPath });
    return true;
  }

  async handleGenerateThumbhashThumbnail({ id }: IEntityJob): Promise<boolean> {
    const [asset] = await this.assetRepository.getByIds([id]);
    if (!asset?.resizePath) {
      return false;
    }

    const thumbhash = await this.mediaRepository.generateThumbhash(asset.resizePath);
    await this.assetRepository.save({ id: asset.id, thumbhash });

    return true;
  }

  async handleQueueVideoConversion(job: IBaseJob) {
    const { force } = job;

    const assetPagination = usePagination(JOBS_ASSET_PAGINATION_SIZE, (pagination) => {
      return force
        ? this.assetRepository.getAll(pagination, { type: AssetType.VIDEO })
        : this.assetRepository.getWithout(pagination, WithoutProperty.ENCODED_VIDEO);
    });

    for await (const assets of assetPagination) {
      for (const asset of assets) {
        await this.jobRepository.queue({ name: JobName.VIDEO_CONVERSION, data: { id: asset.id } });
      }
    }

    return true;
  }

  async handleVideoConversion({ id }: IEntityJob) {
    const [asset] = await this.assetRepository.getByIds([id]);
    if (!asset || asset.type !== AssetType.VIDEO) {
      return false;
    }

    const input = asset.originalPath;
    const output = this.ensureEncodedVideoPath(asset, 'mp4');

    const { videoStreams, audioStreams, format } = await this.mediaRepository.probe(input);
    const mainVideoStream = this.getMainStream(videoStreams);
    const mainAudioStream = this.getMainStream(audioStreams);
    const containerExtension = format.formatName;
    if (!mainVideoStream || !containerExtension) {
      return false;
    }

    const { ffmpeg: config } = await this.configCore.getConfig();

    const required = this.isTranscodeRequired(asset, mainVideoStream, mainAudioStream, containerExtension, config);
    if (!required) {
      return false;
    }

    let transcodeOptions;
    try {
      transcodeOptions = await this.getCodecConfig(config).then((c) => c.getOptions(mainVideoStream, mainAudioStream));
    } catch (err) {
      this.logger.error(`An error occurred while configuring transcoding options: ${err}`);
      return false;
    }

    this.logger.log(`Start encoding video ${asset.id} ${JSON.stringify(transcodeOptions)}`);
    try {
      await this.mediaRepository.transcode(input, output, transcodeOptions);
    } catch (err) {
      this.logger.error(err);
      if (config.accel !== TranscodeHWAccel.DISABLED) {
        this.logger.error(
          `Error occurred during transcoding. Retrying with ${config.accel.toUpperCase()} acceleration disabled.`,
        );
      }
      config.accel = TranscodeHWAccel.DISABLED;
      transcodeOptions = await this.getCodecConfig(config).then((c) => c.getOptions(mainVideoStream, mainAudioStream));
      await this.mediaRepository.transcode(input, output, transcodeOptions);
    }

    this.logger.log(`Encoding success ${asset.id}`);

    await this.assetRepository.save({ id: asset.id, encodedVideoPath: output });

    return true;
  }

  private getMainStream<T extends VideoStreamInfo | AudioStreamInfo>(streams: T[]): T {
    return streams.sort((stream1, stream2) => stream2.frameCount - stream1.frameCount)[0];
  }

  private isTranscodeRequired(
    asset: AssetEntity,
    videoStream: VideoStreamInfo,
    audioStream: AudioStreamInfo | null,
    containerExtension: string,
    ffmpegConfig: SystemConfigFFmpegDto,
  ): boolean {
    if (!videoStream.height || !videoStream.width) {
      this.logger.error('Skipping transcode, height or width undefined for video stream');
      return false;
    }

    const isTargetVideoCodec = videoStream.codecName === ffmpegConfig.targetVideoCodec;
    const isTargetContainer = ['mov,mp4,m4a,3gp,3g2,mj2', 'mp4', 'mov'].includes(containerExtension);
    const isTargetAudioCodec = audioStream == null || audioStream.codecName === ffmpegConfig.targetAudioCodec;

    this.logger.verbose(
      `${asset.id}: AudioCodecName ${audioStream?.codecName ?? 'None'}, AudioStreamCodecType ${
        audioStream?.codecType ?? 'None'
      }, containerExtension ${containerExtension}`,
    );

    const allTargetsMatching = isTargetVideoCodec && isTargetAudioCodec && isTargetContainer;
    const scalingEnabled = ffmpegConfig.targetResolution !== 'original';
    const targetRes = Number.parseInt(ffmpegConfig.targetResolution);
    const isLargerThanTargetRes = scalingEnabled && Math.min(videoStream.height, videoStream.width) > targetRes;

    switch (ffmpegConfig.transcode) {
      case TranscodePolicy.DISABLED:
        return false;

      case TranscodePolicy.ALL:
        return true;

      case TranscodePolicy.REQUIRED:
        return !allTargetsMatching || videoStream.isHDR;

      case TranscodePolicy.OPTIMAL:
        return !allTargetsMatching || isLargerThanTargetRes || videoStream.isHDR;

      default:
        return false;
    }
  }

  async getCodecConfig(config: SystemConfigFFmpegDto) {
    if (config.accel === TranscodeHWAccel.DISABLED) {
      return this.getSWCodecConfig(config);
    }
    return this.getHWCodecConfig(config);
  }

  private getSWCodecConfig(config: SystemConfigFFmpegDto) {
    switch (config.targetVideoCodec) {
      case VideoCodec.H264:
        return new H264Config(config);
      case VideoCodec.HEVC:
        return new HEVCConfig(config);
      case VideoCodec.VP9:
        return new VP9Config(config);
      default:
        throw new UnsupportedMediaTypeException(`Codec '${config.targetVideoCodec}' is unsupported`);
    }
  }

  private async getHWCodecConfig(config: SystemConfigFFmpegDto) {
    let handler: VideoCodecHWConfig;
    let devices: string[];
    switch (config.accel) {
      case TranscodeHWAccel.NVENC:
        handler = new NVENCConfig(config);
        break;
      case TranscodeHWAccel.QSV:
        devices = await this.storageRepository.readdir('/dev/dri');
        handler = new QSVConfig(config, devices);
        break;
      case TranscodeHWAccel.VAAPI:
        devices = await this.storageRepository.readdir('/dev/dri');
        handler = new VAAPIConfig(config, devices);
        break;
      default:
        throw new UnsupportedMediaTypeException(`${config.accel.toUpperCase()} acceleration is unsupported`);
    }
    if (!handler.getSupportedCodecs().includes(config.targetVideoCodec)) {
      throw new UnsupportedMediaTypeException(
        `${config.accel.toUpperCase()} acceleration does not support codec '${config.targetVideoCodec.toUpperCase()}'. Supported codecs: ${handler.getSupportedCodecs()}`,
      );
    }

    return handler;
  }

  ensureThumbnailPath(asset: AssetEntity, extension: string): string {
    return this.storageCore.ensurePath(StorageFolder.THUMBNAILS, asset.ownerId, `${asset.id}.${extension}`);
  }

  ensureEncodedVideoPath(asset: AssetEntity, extension: string): string {
    return this.storageCore.ensurePath(StorageFolder.ENCODED_VIDEO, asset.ownerId, `${asset.id}.${extension}`);
  }

  isSRGB(asset: AssetEntity): boolean {
    const { colorspace, profileDescription, bitsPerSample } = asset.exifInfo ?? {};
    if (colorspace || profileDescription) {
      return [colorspace, profileDescription].some((s) => s?.toLowerCase().includes('srgb'));
    } else if (bitsPerSample) {
      // assume sRGB for 8-bit images with no color profile or colorspace metadata
      return bitsPerSample === 8;
    } else {
      // assume sRGB for images with no relevant metadata
      return true;
    }
  }
}
