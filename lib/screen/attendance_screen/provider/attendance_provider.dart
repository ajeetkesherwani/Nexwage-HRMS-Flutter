import 'package:flutter/material.dart';

import '../model/attendance_model.dart';
import '../model/panchOut_model.dart';
import '../model/today_attendance_model.dart';
import '../repo/attendance_repo.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  bool _loading1 = false;

  AttendanceModel? _postWalletResponse;
  AttendanceModel? get postWalletResponse => _postWalletResponse;
  String? shiftStart;
  String? shiftEnd;
  Duration _duration = Duration.zero;
  Duration get duration => _duration;
  dynamic startTime;

  void setDuration(Duration duration) {
    _duration = duration;
    notifyListeners();
  }

  String? _error;
  String? get error => _error;

  Future<void> PostAttendanceData({
    required double latitude,
    required double longitude,
    required String device_id,
    required String timestamp,
  }) async {
    _loading1 = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _repo.PostAttendance(
        latitude: latitude,
        longitude: longitude,
        device_id: device_id,
        timestamp: timestamp,
      );

      print("FULL API RESPONSE: $response");

      _postWalletResponse = response;

      // ✅ MAIN FIX HERE
      if (response.status == true) {
        // SUCCESS
        _error = null;
      } else {
        _error = response.message ?? "Something went wrong";
        startTime = response.data?.punchInTime;
        print(startTime);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading1 = false;
      notifyListeners();
    }
  }

  PanchOutModel? _panchOutResponse;
  PanchOutModel? get panchOutResponse => _panchOutResponse;
  Future<void> PostAttendanceOutData({
    required double latitude,
    required double longitude,
    required String timestamp,
  }) async {
    _loading1 = true;
    _error = null;
    notifyListeners();

    try {
      _panchOutResponse = await _repo.PostAttendanceOut(
        latitude: latitude,
        longitude: longitude,
        timestamp: timestamp,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading1 = false;
      notifyListeners();
    }
  }

  bool loading = false;
  TodayAttendanceModel? todayAttendanceModel;

  Future<void> getTodayAttendanceDate() async {
    loading = true;
    notifyListeners();
    try {
      todayAttendanceModel = await _repo.getTodayAttendance();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

  Future<dynamic> getPublicTime() async {
    loading = true;
    notifyListeners();
    try {
      final time = await _repo.getPublicTime();
      return time;
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}
