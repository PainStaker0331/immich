import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/backup/providers/error_backup_list.provider.dart';
import 'package:immich_mobile/modules/login/models/authentication_state.model.dart';
import 'package:immich_mobile/modules/backup/models/backup_state.model.dart';
import 'package:immich_mobile/modules/login/providers/authentication.provider.dart';
import 'package:immich_mobile/modules/backup/providers/backup.provider.dart';
import 'package:immich_mobile/routing/router.dart';
import 'package:immich_mobile/shared/providers/websocket.provider.dart';
import 'package:immich_mobile/modules/backup/ui/backup_info_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BackupControllerPage extends HookConsumerWidget {
  const BackupControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BackUpState backupState = ref.watch(backupProvider);
    AuthenticationState authenticationState = ref.watch(authenticationProvider);
    bool shouldBackup = backupState.allUniqueAssets.length -
                backupState.selectedAlbumsBackupAssetsIds.length ==
            0
        ? false
        : true;

    useEffect(
      () {
        if (backupState.backupProgress != BackUpProgressEnum.inProgress) {
          ref.watch(backupProvider.notifier).getBackupInfo();
        }

        ref
            .watch(websocketProvider.notifier)
            .stopListenToEvent('on_upload_success');
        return null;
      },
      [],
    );

    Widget _buildStorageInformation() {
      return ListTile(
        leading: Icon(
          Icons.storage_rounded,
          color: Theme.of(context).primaryColor,
        ),
        title: const Text(
          "backup_controller_page_server_storage",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ).tr(),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LinearPercentIndicator(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  barRadius: const Radius.circular(2),
                  lineHeight: 10.0,
                  percent: backupState.serverInfo.diskUsagePercentage / 100.0,
                  backgroundColor: Colors.grey,
                  progressColor: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: const Text('backup_controller_page_storage_format').tr(
                  args: [
                    backupState.serverInfo.diskUse,
                    backupState.serverInfo.diskSize
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    ListTile _buildAutoBackupController() {
      var backUpOption = authenticationState.deviceInfo.isAutoBackup
          ? "backup_controller_page_status_on".tr()
          : "backup_controller_page_status_off".tr();
      var isAutoBackup = authenticationState.deviceInfo.isAutoBackup;
      var backupBtnText = authenticationState.deviceInfo.isAutoBackup
          ? "backup_controller_page_turn_off".tr()
          : "backup_controller_page_turn_on".tr();
      return ListTile(
        isThreeLine: true,
        leading: isAutoBackup
            ? Icon(
                Icons.cloud_done_rounded,
                color: Theme.of(context).primaryColor,
              )
            : const Icon(Icons.cloud_off_rounded),
        title: Text(
          backUpOption,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isAutoBackup)
                const Text(
                  "backup_controller_page_desc_backup",
                  style: TextStyle(fontSize: 14),
                ).tr(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (isAutoBackup) {
                      ref
                          .read(authenticationProvider.notifier)
                          .setAutoBackup(false);
                    } else {
                      ref
                          .read(authenticationProvider.notifier)
                          .setAutoBackup(true);
                    }
                  },
                  child: Text(
                    backupBtnText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildSelectedAlbumName() {
      var text = "backup_controller_page_backup_selected".tr();
      var albums = ref.watch(backupProvider).selectedBackupAlbums;

      if (albums.isNotEmpty) {
        for (var album in albums) {
          if (album.name == "Recent" || album.name == "Recents") {
            text += "${album.name} (${'backup_all'.tr()}), ";
          } else {
            text += "${album.name}, ";
          }
        }

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text.trim().substring(0, text.length - 2),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "backup_controller_page_none_selected".tr(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    Widget _buildExcludedAlbumName() {
      var text = "backup_controller_page_excluded".tr();
      var albums = ref.watch(backupProvider).excludedBackupAlbums;

      if (albums.isNotEmpty) {
        for (var album in albums) {
          text += "${album.name}, ";
        }

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text.trim().substring(0, text.length - 2),
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    _buildFolderSelectionTile() {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // if you need this
          side: const BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
        elevation: 0,
        borderOnForeground: false,
        child: ListTile(
          minVerticalPadding: 15,
          title: const Text(
            "backup_controller_page_albums",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ).tr(),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "backup_controller_page_to_backup",
                  style: TextStyle(fontSize: 12),
                ).tr(),
                _buildSelectedAlbumName(),
                _buildExcludedAlbumName()
              ],
            ),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).push(const BackupAlbumSelectionRoute());
            },
            child: const Text(
              "backup_controller_page_select",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ).tr(),
          ),
        ),
      );
    }

    _buildCurrentBackupAssetInfoCard() {
      return ListTile(
        leading: Icon(
          Icons.info_outline_rounded,
          color: Theme.of(context).primaryColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "backup_controller_page_uploading_file_info",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ).tr(),
            if (ref.watch(errorBackupListProvider).isNotEmpty)
              ActionChip(
                avatar: Icon(
                  Icons.info,
                  size: 24,
                  color: Colors.red[400],
                ),
                elevation: 1,
                visualDensity: VisualDensity.compact,
                label: Text(
                  "backup_controller_page_failed",
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ).tr(
                  args: [ref.watch(errorBackupListProvider).length.toString()],
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  AutoRouter.of(context).push(const FailedBackupStatusRoute());
                },
              ),
          ],
        ),
        subtitle: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: LinearPercentIndicator(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                barRadius: const Radius.circular(2),
                lineHeight: 10.0,
                trailing: Text(
                  " ${backupState.progressInPercentage.toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 12),
                ),
                percent: backupState.progressInPercentage / 100.0,
                backgroundColor: Colors.grey,
                progressColor: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Table(
                border: TableBorder.all(
                  color: Theme.of(context).primaryColorLight,
                  width: 1,
                ),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                        // color: Colors.grey[100],
                        ),
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: const Text(
                            'backup_controller_page_filename',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ).tr(
                            args: [
                              backupState.currentUploadAsset.fileName,
                              backupState.currentUploadAsset.fileType
                                  .toLowerCase()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                        // color: Colors.grey[200],
                        ),
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: const Text(
                            "backup_controller_page_created",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ).tr(
                            args: [
                              DateFormat.yMMMMd('en_US').format(
                                DateTime.parse(
                                  backupState.currentUploadAsset.createdAt
                                      .toString(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                        // color: Colors.grey[100],
                        ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: const Text(
                            "backup_controller_page_id",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ).tr(args: [backupState.currentUploadAsset.id]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    void startBackup() {
      ref.watch(errorBackupListProvider.notifier).empty();
      ref.watch(backupProvider.notifier).startBackupProcess();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "backup_controller_page_backup",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ).tr(),
        leading: IconButton(
          onPressed: () {
            ref.watch(websocketProvider.notifier).listenUploadEvent();
            AutoRouter.of(context).pop(true);
          },
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "backup_controller_page_info",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ).tr(),
            ),
            _buildFolderSelectionTile(),
            BackupInfoCard(
              title: "backup_controller_page_total".tr(),
              subtitle: "backup_controller_page_total_sub".tr(),
              info: "${backupState.allUniqueAssets.length}",
            ),
            BackupInfoCard(
              title: "backup_controller_page_backup".tr(),
              subtitle: "backup_controller_page_backup_sub".tr(),
              info: "${backupState.selectedAlbumsBackupAssetsIds.length}",
            ),
            BackupInfoCard(
              title: "backup_controller_page_remainder".tr(),
              subtitle: "backup_controller_page_remainder_sub".tr(),
              info:
                  "${backupState.allUniqueAssets.length - backupState.selectedAlbumsBackupAssetsIds.length}",
            ),
            const Divider(),
            _buildAutoBackupController(),
            const Divider(),
            _buildStorageInformation(),
            const Divider(),
            _buildCurrentBackupAssetInfoCard(),
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: Container(
                child:
                    backupState.backupProgress == BackUpProgressEnum.inProgress
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[300],
                              onPrimary: Colors.grey[50],
                              // padding: const EdgeInsets.all(14),
                            ),
                            onPressed: () {
                              ref.read(backupProvider.notifier).cancelBackup();
                            },
                            child: const Text(
                              "backup_controller_page_cancel",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr(),
                          )
                        : ElevatedButton(
                            onPressed: shouldBackup ? startBackup : null,
                            child: const Text(
                              "backup_controller_page_start_backup",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr(),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
