import { IsOptional } from 'class-validator';

export class EditSharedLinkDto {
  @IsOptional()
  description?: string;

  @IsOptional()
  expiresAt?: string | null;

  @IsOptional()
  allowUpload?: boolean;

  @IsOptional()
  allowDownload?: boolean;

  @IsOptional()
  showExif?: boolean;
}
