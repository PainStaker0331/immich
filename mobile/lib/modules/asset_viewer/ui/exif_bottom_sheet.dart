import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:immich_mobile/shared/ui/drag_sheet.dart';
import 'package:openapi/api.dart';
import 'package:path/path.dart' as p;
import 'package:latlong2/latlong.dart';
import 'package:immich_mobile/utils/bytes_units.dart';

class ExifBottomSheet extends HookConsumerWidget {
  final Asset assetDetail;

  const ExifBottomSheet({Key? key, required this.assetDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    buildMap() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(
                assetDetail.latitude ?? 0,
                assetDetail.longitude ?? 0,
              ),
              zoom: 16.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return const Text(
                    "© OpenStreetMap",
                    style: TextStyle(fontSize: 10),
                  );
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(
                      assetDetail.latitude ?? 0,
                      assetDetail.longitude ?? 0,
                    ),
                    builder: (ctx) => const Image(
                      image: AssetImage('assets/location-pin.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final textColor = Theme.of(context).primaryColor;

    ExifResponseDto? exifInfo = assetDetail.remote?.exifInfo;

    buildLocationText() {
      return Text(
        "${exifInfo?.city}, ${exifInfo?.state}",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      );
    }

    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.center,
                child: CustomDraggingHandle(),
              ),
              const SizedBox(height: 12),
              if (exifInfo?.dateTimeOriginal != null)
                Text(
                  DateFormat('date_format'.tr()).format(
                    exifInfo!.dateTimeOriginal!.toLocal(),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

              // Location
              if (assetDetail.latitude != null)
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      Text(
                        "exif_bottom_sheet_location",
                        style: TextStyle(fontSize: 11, color: textColor),
                      ).tr(),
                      if (assetDetail.latitude != null &&
                          assetDetail.longitude != null)
                        buildMap(),
                      if (exifInfo != null &&
                          exifInfo.city != null &&
                          exifInfo.state != null)
                        buildLocationText(),
                      Text(
                        "${assetDetail.latitude?.toStringAsFixed(4)}, ${assetDetail.longitude?.toStringAsFixed(4)}",
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              // Detail
              if (exifInfo != null)
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "exif_bottom_sheet_details",
                          style: TextStyle(fontSize: 11, color: textColor),
                        ).tr(),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        leading: const Icon(Icons.image),
                        title: Text(
                          "${exifInfo.imageName!}${p.extension(assetDetail.remote!.originalPath)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        subtitle: exifInfo.exifImageHeight != null
                            ? Text(
                                "${exifInfo.exifImageHeight} x ${exifInfo.exifImageWidth}  ${formatBytes(exifInfo.fileSizeInByte ?? 0)} ",
                              )
                            : null,
                      ),
                      if (exifInfo.make != null)
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          leading: const Icon(Icons.camera),
                          title: Text(
                            "${exifInfo.make} ${exifInfo.model}",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "ƒ/${exifInfo.fNumber}   1/${(1 / (exifInfo.exposureTime ?? 1)).toStringAsFixed(0)}   ${exifInfo.focalLength} mm   ISO${exifInfo.iso} ",
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
