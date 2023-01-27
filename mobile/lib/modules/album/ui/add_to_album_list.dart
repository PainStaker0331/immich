import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/album/providers/album.provider.dart';
import 'package:immich_mobile/modules/album/providers/asset_selection.provider.dart';
import 'package:immich_mobile/modules/album/providers/shared_album.provider.dart';
import 'package:immich_mobile/modules/album/services/album.service.dart';
import 'package:immich_mobile/modules/album/ui/album_thumbnail_listtile.dart';
import 'package:immich_mobile/routing/router.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:immich_mobile/shared/ui/drag_sheet.dart';
import 'package:immich_mobile/shared/ui/immich_toast.dart';
import 'package:openapi/api.dart';

class AddToAlbumList extends HookConsumerWidget {

  /// The asset to add to an album
  final Asset asset;

  const AddToAlbumList({
    Key? key,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(albumProvider);
    final albumService = ref.watch(albumServiceProvider);
    final sharedAlbums = ref.watch(sharedAlbumProvider);

    useEffect(
      () {
        // Fetch album updates, e.g., cover image
        ref.read(albumProvider.notifier).getAllAlbums();
        ref.read(sharedAlbumProvider.notifier).getAllSharedAlbums();

        return null;
      },
      [], 
    );

    void addToAlbum(AlbumResponseDto album) async {
      final result = await albumService.addAdditionalAssetToAlbum(
        [asset],
        album.id,
      );
      
      if (result != null) {
        if (result.alreadyInAlbum.isNotEmpty) {
          ImmichToast.show(
            context: context,
            msg: 'Already in ${album.albumName}',
          );
        } else {
          ImmichToast.show(
            context: context,
            msg: 'Added to ${album.albumName}',
          );
        }
      } 

      ref.read(albumProvider.notifier).getAllAlbums();
      ref.read(sharedAlbumProvider.notifier).getAllSharedAlbums();

      Navigator.pop(context);
    }

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: CustomDraggingHandle(),
              ),
              const SizedBox(height: 12),
              Text('Add to album',
                style: Theme.of(context).textTheme.headline1,
              ),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New album'),
                onPressed: () {
                  ref.watch(assetSelectionProvider.notifier).removeAll();
                  ref.watch(assetSelectionProvider.notifier).addNewAssets([asset]);
                  AutoRouter.of(context).push(
                    CreateAlbumRoute(
                      isSharedAlbum: false,
                      initialAssets: [asset],
                    ),
                  );
                },
              ),
            ],
          ),
          if (sharedAlbums.isNotEmpty)
            ExpansionTile(
              title: const Text('Shared'),
              tilePadding: const EdgeInsets.symmetric(horizontal: 10.0),
              leading: const Icon(Icons.group),
              children: sharedAlbums.map((album) => 
                AlbumThumbnailListTile(
                  album: album,
                  onTap: () => addToAlbum(album),
                ),
              ).toList(),
            ),
            const SizedBox(height: 12),
            ... albums.map((album) =>
              AlbumThumbnailListTile(
                album: album,
                onTap: () => addToAlbum(album),
              ),
            ).toList(),
          ],
        ),
    );
  }
}
