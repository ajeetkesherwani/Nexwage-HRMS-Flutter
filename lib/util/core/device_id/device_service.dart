import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'device_service.dart';
class DeviceService {
  static Future<String> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.id ?? 'Unavailable';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor ?? 'Unavailable';
      } else {
        return 'Unsupported platform';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}



class DeviceManager {
  static String? _deviceId;

  /// 🔥 Load once (App start)
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    // Try get from local
    _deviceId = prefs.getString('deviceId');

    // If not found → fetch & save
    if (_deviceId == null || _deviceId!.isEmpty) {
      _deviceId = await DeviceService.getDeviceId();
      await prefs.setString('deviceId', _deviceId!);
    }
  }

  /// ✅ Get instantly anywhere
  static String get deviceId => _deviceId ?? "Unavailable";
}