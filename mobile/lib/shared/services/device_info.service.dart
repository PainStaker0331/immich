import 'package:flutter_udid/flutter_udid.dart';
import 'dart:io' show Platform;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openapi/api.dart';

final deviceInfoServiceProvider = Provider((_) => DeviceInfoService());

class DeviceInfoService {
  Future<Map<String, dynamic>> getDeviceInfo() async {
    // Get device info
    var deviceId = await FlutterUdid.consistentUdid;
    var deviceType = DeviceTypeEnum.ANDROID;

    if (Platform.isAndroid) {
      deviceType = DeviceTypeEnum.ANDROID;
    } else if (Platform.isIOS) {
      deviceType = DeviceTypeEnum.IOS;
    }

    return {"deviceId": deviceId, "deviceType": deviceType};
  }
}
