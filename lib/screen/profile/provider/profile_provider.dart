
import 'package:flutter/material.dart';

import '../model/get_profile_model.dart';
import '../repo/profile_repo.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();
  bool loading = false;
  GetProfileModel? getProfileModel;

  Future<void> getProfileData() async {
    loading = true;
    notifyListeners();
    try {
      getProfileModel = await _repo.getProfileApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}