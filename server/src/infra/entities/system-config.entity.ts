import { QueueName } from '@app/domain';
import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity('system_config')
export class SystemConfigEntity<T = SystemConfigValue> {
  @PrimaryColumn()
  key!: SystemConfigKey;

  @Column({ type: 'varchar', nullable: true, transformer: { to: JSON.stringify, from: JSON.parse } })
  value!: T;
}

export type SystemConfigValue = string | number | boolean;

// dot notation matches path in `SystemConfig`
export enum SystemConfigKey {
  FFMPEG_CRF = 'ffmpeg.crf',
  FFMPEG_THREADS = 'ffmpeg.threads',
  FFMPEG_PRESET = 'ffmpeg.preset',
  FFMPEG_TARGET_VIDEO_CODEC = 'ffmpeg.targetVideoCodec',
  FFMPEG_TARGET_AUDIO_CODEC = 'ffmpeg.targetAudioCodec',
  FFMPEG_TARGET_RESOLUTION = 'ffmpeg.targetResolution',
  FFMPEG_MAX_BITRATE = 'ffmpeg.maxBitrate',
  FFMPEG_BFRAMES = 'ffmpeg.bframes',
  FFMPEG_REFS = 'ffmpeg.refs',
  FFMPEG_GOP_SIZE = 'ffmpeg.gopSize',
  FFMPEG_NPL = 'ffmpeg.npl',
  FFMPEG_TEMPORAL_AQ = 'ffmpeg.temporalAQ',
  FFMPEG_CQ_MODE = 'ffmpeg.cqMode',
  FFMPEG_TWO_PASS = 'ffmpeg.twoPass',
  FFMPEG_TRANSCODE = 'ffmpeg.transcode',
  FFMPEG_ACCEL = 'ffmpeg.accel',
  FFMPEG_TONEMAP = 'ffmpeg.tonemap',

  JOB_THUMBNAIL_GENERATION_CONCURRENCY = 'job.thumbnailGeneration.concurrency',
  JOB_METADATA_EXTRACTION_CONCURRENCY = 'job.metadataExtraction.concurrency',
  JOB_VIDEO_CONVERSION_CONCURRENCY = 'job.videoConversion.concurrency',
  JOB_OBJECT_TAGGING_CONCURRENCY = 'job.objectTagging.concurrency',
  JOB_RECOGNIZE_FACES_CONCURRENCY = 'job.recognizeFaces.concurrency',
  JOB_CLIP_ENCODING_CONCURRENCY = 'job.clipEncoding.concurrency',
  JOB_BACKGROUND_TASK_CONCURRENCY = 'job.backgroundTask.concurrency',
  JOB_STORAGE_TEMPLATE_MIGRATION_CONCURRENCY = 'job.storageTemplateMigration.concurrency',
  JOB_SEARCH_CONCURRENCY = 'job.search.concurrency',
  JOB_SIDECAR_CONCURRENCY = 'job.sidecar.concurrency',

  MACHINE_LEARNING_ENABLED = 'machineLearning.enabled',
  MACHINE_LEARNING_URL = 'machineLearning.url',

  MACHINE_LEARNING_CLASSIFICATION_ENABLED = 'machineLearning.classification.enabled',
  MACHINE_LEARNING_CLASSIFICATION_MODEL_NAME = 'machineLearning.classification.modelName',
  MACHINE_LEARNING_CLASSIFICATION_MIN_SCORE = 'machineLearning.classification.minScore',

  MACHINE_LEARNING_CLIP_ENABLED = 'machineLearning.clip.enabled',
  MACHINE_LEARNING_CLIP_MODEL_NAME = 'machineLearning.clip.modelName',

  MACHINE_LEARNING_FACIAL_RECOGNITION_ENABLED = 'machineLearning.facialRecognition.enabled',
  MACHINE_LEARNING_FACIAL_RECOGNITION_MODEL_NAME = 'machineLearning.facialRecognition.modelName',
  MACHINE_LEARNING_FACIAL_RECOGNITION_MIN_SCORE = 'machineLearning.facialRecognition.minScore',
  MACHINE_LEARNING_FACIAL_RECOGNITION_MAX_DISTANCE = 'machineLearning.facialRecognition.maxDistance',

  OAUTH_ENABLED = 'oauth.enabled',
  OAUTH_ISSUER_URL = 'oauth.issuerUrl',
  OAUTH_CLIENT_ID = 'oauth.clientId',
  OAUTH_CLIENT_SECRET = 'oauth.clientSecret',
  OAUTH_SCOPE = 'oauth.scope',
  OAUTH_STORAGE_LABEL_CLAIM = 'oauth.storageLabelClaim',
  OAUTH_AUTO_LAUNCH = 'oauth.autoLaunch',
  OAUTH_BUTTON_TEXT = 'oauth.buttonText',
  OAUTH_AUTO_REGISTER = 'oauth.autoRegister',
  OAUTH_MOBILE_OVERRIDE_ENABLED = 'oauth.mobileOverrideEnabled',
  OAUTH_MOBILE_REDIRECT_URI = 'oauth.mobileRedirectUri',

  PASSWORD_LOGIN_ENABLED = 'passwordLogin.enabled',

  STORAGE_TEMPLATE = 'storageTemplate.template',

  THUMBNAIL_WEBP_SIZE = 'thumbnail.webpSize',
  THUMBNAIL_JPEG_SIZE = 'thumbnail.jpegSize',
  THUMBNAIL_QUALITY = 'thumbnail.quality',
  THUMBNAIL_COLORSPACE = 'thumbnail.colorspace',
}

export enum TranscodePolicy {
  ALL = 'all',
  OPTIMAL = 'optimal',
  REQUIRED = 'required',
  DISABLED = 'disabled',
}

export enum VideoCodec {
  H264 = 'h264',
  HEVC = 'hevc',
  VP9 = 'vp9',
}

export enum AudioCodec {
  MP3 = 'mp3',
  AAC = 'aac',
  OPUS = 'opus',
}

export enum TranscodeHWAccel {
  NVENC = 'nvenc',
  QSV = 'qsv',
  VAAPI = 'vaapi',
  DISABLED = 'disabled',
}

export enum ToneMapping {
  HABLE = 'hable',
  MOBIUS = 'mobius',
  REINHARD = 'reinhard',
  DISABLED = 'disabled',
}

export enum CQMode {
  AUTO = 'auto',
  CQP = 'cqp',
  ICQ = 'icq',
}

export enum Colorspace {
  SRGB = 'srgb',
  P3 = 'p3',
}

export interface SystemConfig {
  ffmpeg: {
    crf: number;
    threads: number;
    preset: string;
    targetVideoCodec: VideoCodec;
    targetAudioCodec: AudioCodec;
    targetResolution: string;
    maxBitrate: string;
    bframes: number;
    refs: number;
    gopSize: number;
    npl: number;
    temporalAQ: boolean;
    cqMode: CQMode;
    twoPass: boolean;
    transcode: TranscodePolicy;
    accel: TranscodeHWAccel;
    tonemap: ToneMapping;
  };
  job: Record<QueueName, { concurrency: number }>;
  machineLearning: {
    enabled: boolean;
    url: string;
    classification: {
      enabled: boolean;
      modelName: string;
      minScore: number;
    };
    clip: {
      enabled: boolean;
      modelName: string;
    };
    facialRecognition: {
      enabled: boolean;
      modelName: string;
      minScore: number;
      maxDistance: number;
    };
  };
  oauth: {
    enabled: boolean;
    issuerUrl: string;
    clientId: string;
    clientSecret: string;
    scope: string;
    storageLabelClaim: string;
    buttonText: string;
    autoRegister: boolean;
    autoLaunch: boolean;
    mobileOverrideEnabled: boolean;
    mobileRedirectUri: string;
  };
  passwordLogin: {
    enabled: boolean;
  };
  storageTemplate: {
    template: string;
  };
  thumbnail: {
    webpSize: number;
    jpegSize: number;
    quality: number;
    colorspace: Colorspace;
  };
}
