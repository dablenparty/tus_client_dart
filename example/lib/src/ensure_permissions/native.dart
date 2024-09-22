import "dart:io";

import "package:device_info_plus/device_info_plus.dart";
import "package:permission_handler/permission_handler.dart";

Future<bool> ensurePermissions() async {
  var enableStorage = true;

  if (Platform.isAndroid) {
    final devicePlugin = DeviceInfoPlugin();
    final androidDeviceInfo = await devicePlugin.androidInfo;
    final androidSdkVersion = androidDeviceInfo.version.sdkInt;
    enableStorage = androidSdkVersion < 33;
  }

  final storage = enableStorage
      ? await Permission.storage.status
      : PermissionStatus.granted;
  final photos = Platform.isIOS
      ? await Permission.photos.status
      : PermissionStatus.granted;

  return storage.isGranted && photos.isGranted;
}
