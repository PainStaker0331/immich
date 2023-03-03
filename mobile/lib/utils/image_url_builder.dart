import 'package:hive/hive.dart';
import 'package:immich_mobile/shared/models/album.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:openapi/api.dart';

import '../constants/hive_box.dart';

String getThumbnailUrl(
  final Asset asset, {
  ThumbnailFormat type = ThumbnailFormat.WEBP,
}) {
  return _getThumbnailUrl(asset.remoteId!, type: type);
}

String getThumbnailCacheKey(
  final Asset asset, {
  ThumbnailFormat type = ThumbnailFormat.WEBP,
}) {
  return _getThumbnailCacheKey(asset.remoteId!, type);
}

String _getThumbnailCacheKey(final String id, final ThumbnailFormat type) {
  if (type == ThumbnailFormat.WEBP) {
    return 'thumbnail-image-$id';
  } else {
    return '${id}_previewStage';
  }
}

String getAlbumThumbnailUrl(
  final Album album, {
  ThumbnailFormat type = ThumbnailFormat.WEBP,
}) {
  if (album.thumbnail.value?.remoteId == null) {
    return '';
  }
  return _getThumbnailUrl(album.thumbnail.value!.remoteId!, type: type);
}

String getAlbumThumbNailCacheKey(
  final Album album, {
  ThumbnailFormat type = ThumbnailFormat.WEBP,
}) {
  if (album.thumbnail.value?.remoteId == null) {
    return '';
  }
  return _getThumbnailCacheKey(album.thumbnail.value!.remoteId!, type);
}

String getImageUrl(final Asset asset) {
  final box = Hive.box(userInfoBox);
  return '${box.get(serverEndpointKey)}/asset/file/${asset.remoteId}?isThumb=false';
}

String getImageCacheKey(final Asset asset) {
  return '${asset.id}_fullStage';
}

String _getThumbnailUrl(
  final String id, {
  ThumbnailFormat type = ThumbnailFormat.WEBP,
}) {
  final box = Hive.box(userInfoBox);

  return '${box.get(serverEndpointKey)}/asset/thumbnail/$id?format=${type.value}';
}
