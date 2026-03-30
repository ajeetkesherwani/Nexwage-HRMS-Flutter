
import 'package:flutter/material.dart';

import '../model/holiday_model.dart';
import '../repo/holiday_repo.dart';


class HoliDayProvider with ChangeNotifier {
  final HoliDayRepository _repo = HoliDayRepository();
  bool loading = false;
  HolidayModel? holidayModel;

  Future<void> getProfileData() async {
    loading = true;
    notifyListeners();
    try {
      holidayModel = await _repo.getHoliDayApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}