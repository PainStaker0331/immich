import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immich_mobile/constants/hive_box.dart';
import 'package:immich_mobile/modules/home/providers/upload_profile_image.provider.dart';
import 'package:immich_mobile/modules/login/models/authentication_state.model.dart';
import 'package:immich_mobile/modules/login/providers/authentication.provider.dart';
import 'package:immich_mobile/shared/ui/immich_loading_indicator.dart';

class ProfileDrawerHeader extends HookConsumerWidget {
  const ProfileDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String endpoint = Hive.box(userInfoBox).get(serverEndpointKey);
    AuthenticationState authState = ref.watch(authenticationProvider);
    final uploadProfileImageStatus =
        ref.watch(uploadProfileImageProvider).status;
    var dummmy = Random().nextInt(1024);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    _buildUserProfileImage() {
      if (authState.profileImagePath.isEmpty) {
        return const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/immich-logo-no-outline.png'),
          backgroundColor: Colors.transparent,
        );
      }

      if (uploadProfileImageStatus == UploadProfileStatus.idle) {
        if (authState.profileImagePath.isNotEmpty) {
          return CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              '$endpoint/user/profile-image/${authState.userId}?d=${dummmy++}',
            ),
            backgroundColor: Colors.transparent,
          );
        } else {
          return const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/immich-logo-no-outline.png'),
            backgroundColor: Colors.transparent,
          );
        }
      }

      if (uploadProfileImageStatus == UploadProfileStatus.success) {
        return CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            '$endpoint/user/profile-image/${authState.userId}?d=${dummmy++}',
          ),
          backgroundColor: Colors.transparent,
        );
      }

      if (uploadProfileImageStatus == UploadProfileStatus.failure) {
        return const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/immich-logo-no-outline.png'),
          backgroundColor: Colors.transparent,
        );
      }

      if (uploadProfileImageStatus == UploadProfileStatus.loading) {
        return const ImmichLoadingIndicator();
      }

      return const SizedBox();
    }

    _pickUserProfileImage() async {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024,
      );

      if (image != null) {
        var success =
            await ref.watch(uploadProfileImageProvider.notifier).upload(image);

        if (success) {
          ref.watch(authenticationProvider.notifier).updateUserProfileImagePath(
                ref.read(uploadProfileImageProvider).profileImagePath,
              );
        }
      }
    }

    useEffect(
      () {
        _buildUserProfileImage();
        return null;
      },
      [],
    );

    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [
                  const Color.fromARGB(255, 22, 25, 48),
                  const Color.fromARGB(255, 13, 13, 13),
                  const Color.fromARGB(255, 0, 0, 0),
                ]
              : [
                  const Color.fromARGB(255, 216, 219, 238),
                  const Color.fromARGB(255, 242, 242, 242),
                  Colors.white,
                ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildUserProfileImage(),
              Positioned(
                bottom: 0,
                right: -5,
                child: GestureDetector(
                  onTap: _pickUserProfileImage,
                  child: Material(
                    color: Colors.grey[100],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${authState.firstName} ${authState.lastName}",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            authState.userEmail,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
