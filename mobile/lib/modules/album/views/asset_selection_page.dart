import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/album/models/asset_selection_page_result.model.dart';
import 'package:immich_mobile/modules/album/providers/asset_selection.provider.dart';
import 'package:immich_mobile/modules/album/ui/asset_grid_by_month.dart';
import 'package:immich_mobile/modules/album/ui/month_group_title.dart';
import 'package:immich_mobile/shared/providers/asset.provider.dart';
import 'package:immich_mobile/modules/home/ui/draggable_scrollbar.dart';

class AssetSelectionPage extends HookConsumerWidget {
  const AssetSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scrollController = useScrollController();
    var assetGroupMonthYear = ref.watch(assetGroupByMonthYearProvider);
    final selectedAssets =
        ref.watch(assetSelectionProvider).selectedNewAssetsForAlbum;
    final newAssetsForAlbum =
        ref.watch(assetSelectionProvider).selectedAdditionalAssetsForAlbum;
    final isAlbumExist = ref.watch(assetSelectionProvider).isAlbumExist;

    List<Widget> imageGridGroup = [];

    String _buildAssetCountText() {
      if (isAlbumExist) {
        return (selectedAssets.length + newAssetsForAlbum.length).toString();
      } else {
        return selectedAssets.length.toString();
      }
    }

    Widget _buildBody() {
      assetGroupMonthYear.forEach((monthYear, assetGroup) {
        imageGridGroup
            .add(MonthGroupTitle(month: monthYear, assetGroup: assetGroup));
        imageGridGroup.add(AssetGridByMonth(assetGroup: assetGroup));
      });

      return Stack(
        children: [
          DraggableScrollbar.semicircle(
            backgroundColor: Theme.of(context).hintColor,
            controller: scrollController,
            heightScrollThumb: 48.0,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [...imageGridGroup],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            ref.watch(assetSelectionProvider.notifier).removeAll();
            AutoRouter.of(context).pop(null);
          },
        ),
        title: selectedAssets.isEmpty
            ? const Text(
                'share_add_photos',
                style: TextStyle(fontSize: 18),
              ).tr()
            : Text(
                _buildAssetCountText(),
                style: const TextStyle(fontSize: 18),
              ),
        centerTitle: false,
        actions: [
          if ((!isAlbumExist && selectedAssets.isNotEmpty) ||
              (isAlbumExist && newAssetsForAlbum.isNotEmpty))
            TextButton(
              onPressed: () {
                var payload = AssetSelectionPageResult(
                  isAlbumExist: isAlbumExist,
                  selectedAdditionalAsset: newAssetsForAlbum,
                  selectedNewAsset: selectedAssets,
                );
                AutoRouter.of(context).pop(payload);
              },
              child: const Text(
                "share_add",
                style: TextStyle(fontWeight: FontWeight.bold),
              ).tr(),
            ),
        ],
      ),
      body: _buildBody(),
    );
  }
}
