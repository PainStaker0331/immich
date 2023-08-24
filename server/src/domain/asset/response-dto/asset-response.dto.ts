import { AssetEntity, AssetType } from '@app/infra/entities';
import { ApiProperty } from '@nestjs/swagger';
import { mapFace, PersonResponseDto } from '../../person/person.dto';
import { mapTag, TagResponseDto } from '../../tag';
import { ExifResponseDto, mapExif } from './exif-response.dto';
import { mapSmartInfo, SmartInfoResponseDto } from './smart-info-response.dto';

export class AssetResponseDto {
  id!: string;
  deviceAssetId!: string;
  ownerId!: string;
  deviceId!: string;

  @ApiProperty({ enumName: 'AssetTypeEnum', enum: AssetType })
  type!: AssetType;
  originalPath!: string;
  originalFileName!: string;
  resized!: boolean;
  /**base64 encoded thumbhash */
  thumbhash!: string | null;
  fileCreatedAt!: Date;
  fileModifiedAt!: Date;
  updatedAt!: Date;
  isFavorite!: boolean;
  isArchived!: boolean;
  duration!: string;
  exifInfo?: ExifResponseDto;
  smartInfo?: SmartInfoResponseDto;
  livePhotoVideoId?: string | null;
  tags?: TagResponseDto[];
  people?: PersonResponseDto[];
  /**base64 encoded sha1 hash */
  checksum!: string;
}

export function mapAsset(entity: AssetEntity): AssetResponseDto {
  return {
    id: entity.id,
    deviceAssetId: entity.deviceAssetId,
    ownerId: entity.ownerId,
    deviceId: entity.deviceId,
    type: entity.type,
    originalPath: entity.originalPath,
    originalFileName: entity.originalFileName,
    resized: !!entity.resizePath,
    thumbhash: entity.thumbhash?.toString('base64') ?? null,
    fileCreatedAt: entity.fileCreatedAt,
    fileModifiedAt: entity.fileModifiedAt,
    updatedAt: entity.updatedAt,
    isFavorite: entity.isFavorite,
    isArchived: entity.isArchived,
    duration: entity.duration ?? '0:00:00.00000',
    exifInfo: entity.exifInfo ? mapExif(entity.exifInfo) : undefined,
    smartInfo: entity.smartInfo ? mapSmartInfo(entity.smartInfo) : undefined,
    livePhotoVideoId: entity.livePhotoVideoId,
    tags: entity.tags?.map(mapTag),
    people: entity.faces?.map(mapFace).filter((person) => !person.isHidden),
    checksum: entity.checksum.toString('base64'),
  };
}

export function mapAssetWithoutExif(entity: AssetEntity): AssetResponseDto {
  return {
    id: entity.id,
    deviceAssetId: entity.deviceAssetId,
    ownerId: entity.ownerId,
    deviceId: entity.deviceId,
    type: entity.type,
    originalPath: entity.originalPath,
    originalFileName: entity.originalFileName,
    resized: !!entity.resizePath,
    thumbhash: entity.thumbhash?.toString('base64') || null,
    fileCreatedAt: entity.fileCreatedAt,
    fileModifiedAt: entity.fileModifiedAt,
    updatedAt: entity.updatedAt,
    isFavorite: entity.isFavorite,
    isArchived: entity.isArchived,
    duration: entity.duration ?? '0:00:00.00000',
    exifInfo: undefined,
    smartInfo: entity.smartInfo ? mapSmartInfo(entity.smartInfo) : undefined,
    livePhotoVideoId: entity.livePhotoVideoId,
    tags: entity.tags?.map(mapTag),
    people: entity.faces?.map(mapFace),
    checksum: entity.checksum.toString('base64'),
  };
}

export class MemoryLaneResponseDto {
  title!: string;
  assets!: AssetResponseDto[];
}
