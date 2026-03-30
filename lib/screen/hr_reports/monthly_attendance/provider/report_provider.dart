import 'package:flutter/material.dart';

import '../model/annual_attendance_model.dart';
import '../model/monthly_attendance_model.dart';
import '../repo/report_repository.dart';

class ReportProvider with ChangeNotifier {
  final ReportRepository _repo = ReportRepository();
  bool loading = false;
  AttendanceResponse? attendanceResponse;
  AnnualAttendanceResponse? annualAttendanceResponse;

  Future<void> getMonthlyAttendance() async {
    loading = true;
    notifyListeners();
    try {
      attendanceResponse = await _repo.getMonthlyAttendance();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

  Future<void> getAnnualAttendance(dynamic data) async {
    loading = true;
    notifyListeners();
    try {
      annualAttendanceResponse = await _repo.getAnnualAttendance(data);
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}
