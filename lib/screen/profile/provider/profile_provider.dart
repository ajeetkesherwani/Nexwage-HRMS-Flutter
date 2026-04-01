
import 'package:flutter/material.dart';

import '../model/emergency_contact_model.dart';
import '../model/get_profile_model.dart';
import '../repo/profile_repo.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();
  bool loading = false;
  GetProfileModel? getProfileModel;

  Future<void> getProfileData({bool isRefresh = false}) async {
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


  EmergencyContactModel? _postEmergencyContactModel;
  EmergencyContactModel? get postEmergencyContactModel => _postEmergencyContactModel;

  String? _error;
  String? get error => _error;
  bool loading1 = false;

  Future<void> PostEmergencyContact({
    required String relation,
    required String contact_name,
    required String personal_phone,
    required String personal_email,

  }) async {
    loading1 = true;
    _error = null;
    notifyListeners();
print("??????????????????");
    try {
      _postEmergencyContactModel = await _repo.emergencyContactApi(
        relation: relation,
        contact_name: contact_name,
        personal_phone: personal_phone,
        personal_email: personal_email,

      );
    } catch (e) {
      _error = e.toString();
    } finally {
      loading1 = false;
      notifyListeners();
    }
  }

}