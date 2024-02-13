import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:photo_manager/photo_manager.dart';

/// The local image provider for an asset
/// Only viable
class ImmichLocalImageProvider extends ImageProvider<Asset> {
  final Asset asset;

  ImmichLocalImageProvider({
    required this.asset,
  }) : assert(asset.local != null, 'Only usable when asset.local is set');

  /// Converts an [ImageProvider]'s settings plus an [ImageConfiguration] to a key
  /// that describes the precise image to load.
  @override
  Future<Asset> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(asset);
  }

  @override
  ImageStreamCompleter loadImage(Asset key, ImageDecoderCallback decode) {
    final chunkEvents = StreamController<ImageChunkEvent>();
    return MultiImageStreamCompleter(
      codec: _codec(key, decode, chunkEvents),
      scale: 1.0,
      chunkEvents: chunkEvents.stream,
      informationCollector: () sync* {
        yield ErrorDescription(asset.fileName);
      },
    );
  }

  // Streams in each stage of the image as we ask for it
  Stream<ui.Codec> _codec(
    Asset key,
    ImageDecoderCallback decode,
    StreamController<ImageChunkEvent> chunkEvents,
  ) async* {
    // Load a small thumbnail
    final thumbBytes = await asset.local?.thumbnailDataWithSize(
      const ThumbnailSize.square(256),
      quality: 80,
    );
    if (thumbBytes != null) {
      final buffer = await ui.ImmutableBuffer.fromUint8List(thumbBytes);
      final codec = await decode(buffer);
      yield codec;
    } else {
      debugPrint("Loading thumb for ${asset.fileName} failed");
    }

    if (asset.isImage) {
      /// Using 2K thumbnail for local iOS image to avoid double swiping issue
      if (Platform.isIOS) {
        final largeImageBytes = await asset.local
            ?.thumbnailDataWithSize(const ThumbnailSize(3840, 2160));
        if (largeImageBytes == null) {
          throw StateError(
            "Loading thumb for local photo ${asset.fileName} failed",
          );
        }
        final buffer = await ui.ImmutableBuffer.fromUint8List(largeImageBytes);
        final codec = await decode(buffer);
        yield codec;
      } else {
        // Use the original file for Android
        final File? file = await asset.local?.originFile;
        if (file == null) {
          throw StateError("Opening file for asset ${asset.fileName} failed");
        }
        try {
          final buffer = await ui.ImmutableBuffer.fromFilePath(file.path);
          final codec = await decode(buffer);
          yield codec;
        } catch (error) {
          throw StateError("Loading asset ${asset.fileName} failed");
        } finally {
          if (Platform.isIOS) {
            // Clean up this file
            await file.delete();
          }
        }
      }
    }

    chunkEvents.close();
  }

  @override
  bool operator ==(Object other) {
    if (other is! ImmichLocalImageProvider) return false;
    if (identical(this, other)) return true;
    return asset == other.asset;
  }

  @override
  int get hashCode => asset.hashCode;
}
