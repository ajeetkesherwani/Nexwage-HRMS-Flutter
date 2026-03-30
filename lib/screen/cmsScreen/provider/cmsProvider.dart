import 'package:flutter/material.dart';

import '../model/cmsModel.dart';
import '../repo/cmsRepogistory.dart';


class CmsProvider with ChangeNotifier {
  final CmsRepository _repo = CmsRepository();
  bool loading = false;
  CmsModel? getCmsData;

  Future<void> fetchCmsData() async {
    loading = true;
    notifyListeners();
    try {
      getCmsData = await _repo.getCmsApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}