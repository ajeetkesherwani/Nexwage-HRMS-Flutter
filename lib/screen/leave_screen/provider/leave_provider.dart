
import 'dart:io';

import 'package:flutter/material.dart';

import '../model/leaveModel.dart';
import '../model/leave_type_model.dart';
import '../model/withdrawnmodel.dart';
import '../repo/leave_repo.dart';


class LeaveProvider with ChangeNotifier {

  TextEditingController leaveController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController reastionController=TextEditingController();
  String? selectedLeaveTypeId;
  final LeaveRepository _repo = LeaveRepository();
  bool loading = false;
  bool isLoading = false;
  LeaveModel? getLeaveModel;

  Future<void> getLeaveData({bool isRefresh = false}) async {
    loading = true;
    notifyListeners();
    try {
      getLeaveModel = await _repo.getLeaveApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

  LeaveTypeModel? getLeaveTypeModel;

  Future<void> getLeaveTypeData() async {
    loading = true;
    notifyListeners();
    try {
      getLeaveTypeModel = await _repo.getLeaveTypeApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

  WithdrawnModel? getWithdrawnModel;
  Future<void> getwithdrawnData({required String id,bool isRefresh = false}) async {
    loading = true;
    notifyListeners();
    try {
      getWithdrawnModel = await _repo.getWithdrawnApi(id: id);
      await getLeaveData();
      await getLeaveTypeData();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

  Future<void> applyLeaveData({
    required String leave_type_id,
    required String start_date,
    required String end_date,
    required String reason,
    required bool is_half_day,
    File? attachment,
    // String? oldProfileImage,
}) async {


    try {
      isLoading = true;
      notifyListeners();

      final response = await _repo.applyLeave(
        leave_type_id: leave_type_id,
        start_date: start_date,
        end_date: end_date,
        reason: reason,
        is_half_day: is_half_day,
        attachment: attachment,
      );

      if (response.status == true) {
        // success = true;
        print("✅ Leave Applied Successfully");
      } else {
        // errorMessage = response.message;
      }
    } catch (e) {
      // errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}