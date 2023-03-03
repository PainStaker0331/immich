import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:immich_mobile/shared/models/album.dart';
import 'package:immich_mobile/shared/ui/immich_image.dart';

class AlbumThumbnailCard extends StatelessWidget {
  final Function()? onTap;

  const AlbumThumbnailCard({
    Key? key,
    required this.album,
    this.onTap,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        var cardSize = constraints.maxWidth;

        buildEmptyThumbnail() {
          return Container(
            height: cardSize,
            width: cardSize,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            ),
            child: Center(
              child: Icon(
                Icons.no_photography,
                size: cardSize * .15,
              ),
            ),
          );
        }

        buildAlbumThumbnail() => ImmichImage(
              album.thumbnail.value,
              width: cardSize,
              height: cardSize,
            );

        return GestureDetector(
          onTap: onTap,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: cardSize,
                      height: cardSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: album.thumbnail.value == null
                            ? buildEmptyThumbnail()
                            : buildAlbumThumbnail(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: cardSize,
                        child: Text(
                          album.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          album.assetCount == 1
                              ? 'album_thumbnail_card_item'
                              : 'album_thumbnail_card_items',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ).tr(args: ['${album.assetCount}']),
                        if (album.shared)
                          const Text(
                            'album_thumbnail_card_shared',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ).tr()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
