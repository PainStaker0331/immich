import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:immich_mobile/routing/router.dart';

class SharingSliverAppBar extends StatelessWidget {
  const SharingSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: false,
      pinned: true,
      snap: false,
      automaticallyImplyLeading: false,
      title: Text(
        'IMMICH',
        style: TextStyle(
          fontFamily: 'SnowburstOne',
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Theme.of(context).primaryColor,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AutoRouter.of(context)
                          .push(CreateAlbumRoute(isSharedAlbum: true));
                    },
                    icon: const Icon(
                      Icons.photo_album_outlined,
                      size: 20,
                    ),
                    label: const Text(
                      "sharing_silver_appbar_create_shared_album",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        // color: Theme.of(context).primaryColor,
                      ),
                    ).tr(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.swap_horizontal_circle_outlined,
                      size: 20,
                    ),
                    label: const Text(
                      "sharing_silver_appbar_share_partner",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                    ).tr(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
