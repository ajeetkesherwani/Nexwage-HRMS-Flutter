import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/version_model.dart';
import '../repo/version_repo.dart';



class AppVersionProvider with ChangeNotifier {
  final VersionRepository _repo = VersionRepository();
  bool loading = false;
  AppVersionModel? appVersionModel;
  Future<String> getCurrentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
  Future<void> fetchAppVersion() async {
    loading = true;
    notifyListeners();
    try {
      appVersionModel = await _repo.getAppVersionApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}