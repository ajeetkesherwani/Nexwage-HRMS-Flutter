import 'package:flutter/material.dart';
class LeaveModel {
  int? employeeId;
  List<LeaveSummary>? leaveSummary;
  List<String>? leaveRequests;

  LeaveModel({this.employeeId, this.leaveSummary, this.leaveRequests});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    if (json['leave_summary'] != null) {
      leaveSummary = <LeaveSummary>[];
      json['leave_summary'].forEach((v) {
        leaveSummary!.add(new LeaveSummary.fromJson(v));
      });
    }
    leaveRequests = json['leave_requests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    if (this.leaveSummary != null) {
      data['leave_summary'] =
          this.leaveSummary!.map((v) => v.toJson()).toList();
    }
    data['leave_requests'] = this.leaveRequests;
    return data;
  }
}

class LeaveSummary {
  int? leaveTypeId;
  String? leaveTypeName;
  int? allocatedLeaves;
  int? usedLeaves;
  int? remainingLeaves;

  LeaveSummary(
      {this.leaveTypeId,
        this.leaveTypeName,
        this.allocatedLeaves,
        this.usedLeaves,
        this.remainingLeaves});

  LeaveSummary.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
    allocatedLeaves = json['allocated_leaves'];
    usedLeaves = json['used_leaves'];
    remainingLeaves = json['remaining_leaves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_type_name'] = this.leaveTypeName;
    data['allocated_leaves'] = this.allocatedLeaves;
    data['used_leaves'] = this.usedLeaves;
    data['remaining_leaves'] = this.remainingLeaves;
    return data;
  }
}

