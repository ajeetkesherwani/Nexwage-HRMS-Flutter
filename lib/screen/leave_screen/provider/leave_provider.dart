
import 'package:flutter/material.dart';

import '../model/leaveModel.dart';
import '../repo/leave_repo.dart';


class LeaveProvider with ChangeNotifier {
  final LeaveRepository _repo = LeaveRepository();
  bool loading = false;
  LeaveModel? getLeaveModel;

  Future<void> getLeaveData() async {
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
}