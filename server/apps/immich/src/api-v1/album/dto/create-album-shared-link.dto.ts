import { ApiProperty } from '@nestjs/swagger';
import { ValidateUUID } from 'apps/immich/src/decorators/validate-uuid.decorator';
import { Type } from 'class-transformer';
import { IsBoolean, IsDate, IsOptional, IsString } from 'class-validator';

export class CreateAlbumShareLinkDto {
  @ValidateUUID()
  albumId!: string;

  @IsOptional()
  @IsDate()
  @Type(() => Date)
  @ApiProperty()
  expiresAt?: Date;

  @IsBoolean()
  @IsOptional()
  @ApiProperty()
  allowUpload?: boolean;

  @IsBoolean()
  @IsOptional()
  @ApiProperty()
  allowDownload?: boolean;

  @IsBoolean()
  @IsOptional()
  @ApiProperty()
  showExif?: boolean;

  @IsString()
  @IsOptional()
  @ApiProperty()
  description?: string;
}
