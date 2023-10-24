import { SystemConfig } from '@app/infra/entities';
import { Type } from 'class-transformer';
import { IsObject, ValidateNested } from 'class-validator';
import { SystemConfigFFmpegDto } from './system-config-ffmpeg.dto';
import { SystemConfigJobDto } from './system-config-job.dto';
import { SystemConfigMachineLearningDto } from './system-config-machine-learning.dto';
import { SystemConfigMapDto } from './system-config-map.dto';
import { SystemConfigNewVersionCheckDto } from './system-config-new-version-check.dto';
import { SystemConfigOAuthDto } from './system-config-oauth.dto';
import { SystemConfigPasswordLoginDto } from './system-config-password-login.dto';
import { SystemConfigReverseGeocodingDto } from './system-config-reverse-geocoding.dto';
import { SystemConfigStorageTemplateDto } from './system-config-storage-template.dto';
import { SystemConfigThemeDto } from './system-config-theme.dto';
import { SystemConfigThumbnailDto } from './system-config-thumbnail.dto';
import { SystemConfigTrashDto } from './system-config-trash.dto';

export class SystemConfigDto implements SystemConfig {
  @Type(() => SystemConfigFFmpegDto)
  @ValidateNested()
  @IsObject()
  ffmpeg!: SystemConfigFFmpegDto;

  @Type(() => SystemConfigMachineLearningDto)
  @ValidateNested()
  @IsObject()
  machineLearning!: SystemConfigMachineLearningDto;

  @Type(() => SystemConfigMapDto)
  @ValidateNested()
  @IsObject()
  map!: SystemConfigMapDto;

  @Type(() => SystemConfigNewVersionCheckDto)
  @ValidateNested()
  @IsObject()
  newVersionCheck!: SystemConfigNewVersionCheckDto;

  @Type(() => SystemConfigOAuthDto)
  @ValidateNested()
  @IsObject()
  oauth!: SystemConfigOAuthDto;

  @Type(() => SystemConfigPasswordLoginDto)
  @ValidateNested()
  @IsObject()
  passwordLogin!: SystemConfigPasswordLoginDto;

  @Type(() => SystemConfigReverseGeocodingDto)
  @ValidateNested()
  @IsObject()
  reverseGeocoding!: SystemConfigReverseGeocodingDto;

  @Type(() => SystemConfigStorageTemplateDto)
  @ValidateNested()
  @IsObject()
  storageTemplate!: SystemConfigStorageTemplateDto;

  @Type(() => SystemConfigJobDto)
  @ValidateNested()
  @IsObject()
  job!: SystemConfigJobDto;

  @Type(() => SystemConfigThumbnailDto)
  @ValidateNested()
  @IsObject()
  thumbnail!: SystemConfigThumbnailDto;

  @Type(() => SystemConfigTrashDto)
  @ValidateNested()
  @IsObject()
  trash!: SystemConfigTrashDto;

  @Type(() => SystemConfigThemeDto)
  @ValidateNested()
  @IsObject()
  theme!: SystemConfigThemeDto;
}

export function mapConfig(config: SystemConfig): SystemConfigDto {
  return config;
}
