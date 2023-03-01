import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/backup/models/available_album.model.dart';
import 'package:immich_mobile/modules/backup/providers/backup.provider.dart';
import 'package:immich_mobile/routing/router.dart';
import 'package:immich_mobile/shared/ui/immich_toast.dart';

class AlbumInfoCard extends HookConsumerWidget {
  final Uint8List? imageData;
  final AvailableAlbum albumInfo;

  const AlbumInfoCard({Key? key, this.imageData, required this.albumInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSelected =
        ref.watch(backupProvider).selectedBackupAlbums.contains(albumInfo);
    final bool isExcluded =
        ref.watch(backupProvider).excludedBackupAlbums.contains(albumInfo);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    ColorFilter selectedFilter = ColorFilter.mode(
      Theme.of(context).primaryColor.withAlpha(100),
      BlendMode.darken,
    );
    ColorFilter excludedFilter =
        ColorFilter.mode(Colors.red.withAlpha(75), BlendMode.darken);
    ColorFilter unselectedFilter =
        const ColorFilter.mode(Colors.black, BlendMode.color);

    buildSelectedTextBox() {
      if (isSelected) {
        return Chip(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          label: Text(
            "album_info_card_backup_album_included",
            style: TextStyle(
              fontSize: 10,
              color: isDarkTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          backgroundColor: Theme.of(context).primaryColor,
        );
      } else if (isExcluded) {
        return Chip(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          label: Text(
            "album_info_card_backup_album_excluded",
            style: TextStyle(
              fontSize: 10,
              color: isDarkTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          backgroundColor: Colors.red[300],
        );
      }

      return const SizedBox();
    }

    buildImageFilter() {
      if (isSelected) {
        return selectedFilter;
      } else if (isExcluded) {
        return excludedFilter;
      } else {
        return unselectedFilter;
      }
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();

        if (isSelected) {
          if (ref.watch(backupProvider).selectedBackupAlbums.length == 1) {
            ImmichToast.show(
              context: context,
              msg: "backup_err_only_album".tr(),
              toastType: ToastType.error,
              gravity: ToastGravity.BOTTOM,
            );
            return;
          }

          ref.watch(backupProvider.notifier).removeAlbumForBackup(albumInfo);
        } else {
          ref.watch(backupProvider.notifier).addAlbumForBackup(albumInfo);
        }
      },
      onDoubleTap: () {
        HapticFeedback.selectionClick();

        if (isExcluded) {
          // Remove from exclude album list
          ref
              .watch(backupProvider.notifier)
              .removeExcludedAlbumForBackup(albumInfo);
        } else {
          // Add to exclude album list
          if (ref.watch(backupProvider).selectedBackupAlbums.length == 1 &&
              ref
                  .watch(backupProvider)
                  .selectedBackupAlbums
                  .contains(albumInfo)) {
            ImmichToast.show(
              context: context,
              msg: "backup_err_only_album".tr(),
              toastType: ToastType.error,
              gravity: ToastGravity.BOTTOM,
            );
            return;
          }

          if (albumInfo.id == 'isAll' || albumInfo.name == 'Recents') {
            ImmichToast.show(
              context: context,
              msg: 'Cannot exclude album contains all assets',
              toastType: ToastType.error,
              gravity: ToastGravity.BOTTOM,
            );
            return;
          }

          ref
              .watch(backupProvider.notifier)
              .addExcludedAlbumForBackup(albumInfo);
        }
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // if you need this
          side: BorderSide(
            color: isDarkTheme
                ? const Color.fromARGB(255, 37, 35, 35)
                : const Color(0xFFC9C9C9),
            width: 1,
          ),
        ),
        elevation: 0,
        borderOnForeground: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  ColorFiltered(
                    colorFilter: buildImageFilter(),
                    child: Image(
                      width: double.infinity,
                      height: double.infinity,
                      image: imageData != null
                          ? MemoryImage(imageData!)
                          : const AssetImage(
                              'assets/immich-logo-no-outline.png',
                            ) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 25,
                    child: buildSelectedTextBox(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          albumInfo.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: FutureBuilder(
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString() +
                                      (albumInfo.isAll
                                          ? " (${'backup_all'.tr()})"
                                          : ""),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                );
                              }
                              return const Text("0");
                            }),
                            future: albumInfo.assetCount,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      AutoRouter.of(context).push(
                        AlbumPreviewRoute(album: albumInfo.albumEntity),
                      );
                    },
                    icon: Icon(
                      Icons.image_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    splashRadius: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
