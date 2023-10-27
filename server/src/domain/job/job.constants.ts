export enum QueueName {
  THUMBNAIL_GENERATION = 'thumbnailGeneration',
  METADATA_EXTRACTION = 'metadataExtraction',
  VIDEO_CONVERSION = 'videoConversion',
  OBJECT_TAGGING = 'objectTagging',
  RECOGNIZE_FACES = 'recognizeFaces',
  CLIP_ENCODING = 'clipEncoding',
  BACKGROUND_TASK = 'backgroundTask',
  STORAGE_TEMPLATE_MIGRATION = 'storageTemplateMigration',
  MIGRATION = 'migration',
  SEARCH = 'search',
  SIDECAR = 'sidecar',
  LIBRARY = 'library',
}

export enum JobCommand {
  START = 'start',
  PAUSE = 'pause',
  RESUME = 'resume',
  EMPTY = 'empty',
}

export enum JobName {
  // conversion
  QUEUE_VIDEO_CONVERSION = 'queue-video-conversion',
  VIDEO_CONVERSION = 'video-conversion',

  // thumbnails
  QUEUE_GENERATE_THUMBNAILS = 'queue-generate-thumbnails',
  GENERATE_JPEG_THUMBNAIL = 'generate-jpeg-thumbnail',
  GENERATE_WEBP_THUMBNAIL = 'generate-webp-thumbnail',
  GENERATE_THUMBHASH_THUMBNAIL = 'generate-thumbhash-thumbnail',
  GENERATE_PERSON_THUMBNAIL = 'generate-person-thumbnail',

  // metadata
  QUEUE_METADATA_EXTRACTION = 'queue-metadata-extraction',
  METADATA_EXTRACTION = 'metadata-extraction',
  LINK_LIVE_PHOTOS = 'link-live-photos',

  // user deletion
  USER_DELETION = 'user-deletion',
  USER_DELETE_CHECK = 'user-delete-check',

  // asset
  ASSET_DELETION = 'asset-deletion',
  ASSET_DELETION_CHECK = 'asset-deletion-check',

  // storage template
  STORAGE_TEMPLATE_MIGRATION = 'storage-template-migration',
  STORAGE_TEMPLATE_MIGRATION_SINGLE = 'storage-template-migration-single',
  SYSTEM_CONFIG_CHANGE = 'system-config-change',

  // migration
  QUEUE_MIGRATION = 'queue-migration',
  MIGRATE_ASSET = 'migrate-asset',
  MIGRATE_PERSON = 'migrate-person',

  // object tagging
  QUEUE_OBJECT_TAGGING = 'queue-object-tagging',
  CLASSIFY_IMAGE = 'classify-image',

  // facial recognition
  PERSON_CLEANUP = 'person-cleanup',
  PERSON_DELETE = 'person-delete',
  QUEUE_RECOGNIZE_FACES = 'queue-recognize-faces',
  RECOGNIZE_FACES = 'recognize-faces',

  // library managment
  LIBRARY_SCAN = 'library-refresh',
  LIBRARY_SCAN_ASSET = 'library-refresh-asset',
  LIBRARY_REMOVE_OFFLINE = 'library-remove-offline',
  LIBRARY_DELETE = 'library-delete',
  LIBRARY_QUEUE_SCAN_ALL = 'library-queue-all-refresh',
  LIBRARY_QUEUE_CLEANUP = 'library-queue-cleanup',

  // cleanup
  DELETE_FILES = 'delete-files',
  CLEAN_OLD_AUDIT_LOGS = 'clean-old-audit-logs',

  // search
  SEARCH_INDEX_ASSETS = 'search-index-assets',
  SEARCH_INDEX_ASSET = 'search-index-asset',
  SEARCH_INDEX_FACE = 'search-index-face',
  SEARCH_INDEX_FACES = 'search-index-faces',
  SEARCH_INDEX_ALBUMS = 'search-index-albums',
  SEARCH_INDEX_ALBUM = 'search-index-album',
  SEARCH_REMOVE_ALBUM = 'search-remove-album',
  SEARCH_REMOVE_ASSET = 'search-remove-asset',
  SEARCH_REMOVE_FACE = 'search-remove-face',

  // clip
  QUEUE_ENCODE_CLIP = 'queue-clip-encode',
  ENCODE_CLIP = 'clip-encode',

  // XMP sidecars
  QUEUE_SIDECAR = 'queue-sidecar',
  SIDECAR_DISCOVERY = 'sidecar-discovery',
  SIDECAR_SYNC = 'sidecar-sync',
}

export const JOBS_ASSET_PAGINATION_SIZE = 1000;

export const JOBS_TO_QUEUE: Record<JobName, QueueName> = {
  // misc
  [JobName.ASSET_DELETION]: QueueName.BACKGROUND_TASK,
  [JobName.ASSET_DELETION_CHECK]: QueueName.BACKGROUND_TASK,
  [JobName.USER_DELETE_CHECK]: QueueName.BACKGROUND_TASK,
  [JobName.USER_DELETION]: QueueName.BACKGROUND_TASK,
  [JobName.DELETE_FILES]: QueueName.BACKGROUND_TASK,
  [JobName.CLEAN_OLD_AUDIT_LOGS]: QueueName.BACKGROUND_TASK,
  [JobName.PERSON_CLEANUP]: QueueName.BACKGROUND_TASK,
  [JobName.PERSON_DELETE]: QueueName.BACKGROUND_TASK,
  [JobName.SYSTEM_CONFIG_CHANGE]: QueueName.BACKGROUND_TASK,

  // conversion
  [JobName.QUEUE_VIDEO_CONVERSION]: QueueName.VIDEO_CONVERSION,
  [JobName.VIDEO_CONVERSION]: QueueName.VIDEO_CONVERSION,

  // thumbnails
  [JobName.QUEUE_GENERATE_THUMBNAILS]: QueueName.THUMBNAIL_GENERATION,
  [JobName.GENERATE_JPEG_THUMBNAIL]: QueueName.THUMBNAIL_GENERATION,
  [JobName.GENERATE_WEBP_THUMBNAIL]: QueueName.THUMBNAIL_GENERATION,
  [JobName.GENERATE_THUMBHASH_THUMBNAIL]: QueueName.THUMBNAIL_GENERATION,
  [JobName.GENERATE_PERSON_THUMBNAIL]: QueueName.THUMBNAIL_GENERATION,

  // metadata
  [JobName.QUEUE_METADATA_EXTRACTION]: QueueName.METADATA_EXTRACTION,
  [JobName.METADATA_EXTRACTION]: QueueName.METADATA_EXTRACTION,
  [JobName.LINK_LIVE_PHOTOS]: QueueName.METADATA_EXTRACTION,

  // storage template
  [JobName.STORAGE_TEMPLATE_MIGRATION]: QueueName.STORAGE_TEMPLATE_MIGRATION,
  [JobName.STORAGE_TEMPLATE_MIGRATION_SINGLE]: QueueName.STORAGE_TEMPLATE_MIGRATION,

  // migration
  [JobName.QUEUE_MIGRATION]: QueueName.MIGRATION,
  [JobName.MIGRATE_ASSET]: QueueName.MIGRATION,
  [JobName.MIGRATE_PERSON]: QueueName.MIGRATION,

  // object tagging
  [JobName.QUEUE_OBJECT_TAGGING]: QueueName.OBJECT_TAGGING,
  [JobName.CLASSIFY_IMAGE]: QueueName.OBJECT_TAGGING,

  // facial recognition
  [JobName.QUEUE_RECOGNIZE_FACES]: QueueName.RECOGNIZE_FACES,
  [JobName.RECOGNIZE_FACES]: QueueName.RECOGNIZE_FACES,

  // clip
  [JobName.QUEUE_ENCODE_CLIP]: QueueName.CLIP_ENCODING,
  [JobName.ENCODE_CLIP]: QueueName.CLIP_ENCODING,

  // search - albums
  [JobName.SEARCH_INDEX_ALBUMS]: QueueName.SEARCH,
  [JobName.SEARCH_INDEX_ALBUM]: QueueName.SEARCH,
  [JobName.SEARCH_REMOVE_ALBUM]: QueueName.SEARCH,

  // search - assets
  [JobName.SEARCH_INDEX_ASSETS]: QueueName.SEARCH,
  [JobName.SEARCH_INDEX_ASSET]: QueueName.SEARCH,
  [JobName.SEARCH_REMOVE_ASSET]: QueueName.SEARCH,

  // search - faces
  [JobName.SEARCH_INDEX_FACES]: QueueName.SEARCH,
  [JobName.SEARCH_INDEX_FACE]: QueueName.SEARCH,
  [JobName.SEARCH_REMOVE_FACE]: QueueName.SEARCH,

  // XMP sidecars
  [JobName.QUEUE_SIDECAR]: QueueName.SIDECAR,
  [JobName.SIDECAR_DISCOVERY]: QueueName.SIDECAR,
  [JobName.SIDECAR_SYNC]: QueueName.SIDECAR,

  // Library management
  [JobName.LIBRARY_SCAN_ASSET]: QueueName.LIBRARY,
  [JobName.LIBRARY_SCAN]: QueueName.LIBRARY,
  [JobName.LIBRARY_DELETE]: QueueName.LIBRARY,
  [JobName.LIBRARY_REMOVE_OFFLINE]: QueueName.LIBRARY,
  [JobName.LIBRARY_QUEUE_SCAN_ALL]: QueueName.LIBRARY,
  [JobName.LIBRARY_QUEUE_CLEANUP]: QueueName.LIBRARY,
};
