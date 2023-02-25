import { JobName, QueueName } from './job.constants';
import { IAssetJob, IAssetUploadedJob, IDeleteFilesJob, IReverseGeocodingJob, IUserDeletionJob } from './job.interface';

export interface JobCounts {
  active: number;
  completed: number;
  failed: number;
  delayed: number;
  waiting: number;
}

export type JobItem =
  | { name: JobName.ASSET_UPLOADED; data: IAssetUploadedJob }
  | { name: JobName.VIDEO_CONVERSION; data: IAssetJob }
  | { name: JobName.GENERATE_JPEG_THUMBNAIL; data: IAssetJob }
  | { name: JobName.GENERATE_WEBP_THUMBNAIL; data: IAssetJob }
  | { name: JobName.EXIF_EXTRACTION; data: IAssetUploadedJob }
  | { name: JobName.REVERSE_GEOCODING; data: IReverseGeocodingJob }
  | { name: JobName.USER_DELETE_CHECK }
  | { name: JobName.USER_DELETION; data: IUserDeletionJob }
  | { name: JobName.STORAGE_TEMPLATE_MIGRATION }
  | { name: JobName.SYSTEM_CONFIG_CHANGE }
  | { name: JobName.EXTRACT_VIDEO_METADATA; data: IAssetUploadedJob }
  | { name: JobName.OBJECT_DETECTION; data: IAssetJob }
  | { name: JobName.IMAGE_TAGGING; data: IAssetJob }
  | { name: JobName.DELETE_FILES; data: IDeleteFilesJob };

export const IJobRepository = 'IJobRepository';

export interface IJobRepository {
  queue(item: JobItem): Promise<void>;
  empty(name: QueueName): Promise<void>;
  isActive(name: QueueName): Promise<boolean>;
  getJobCounts(name: QueueName): Promise<JobCounts>;
}
