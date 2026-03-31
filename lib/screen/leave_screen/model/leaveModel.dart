class LeaveModel {
  int? employeeId;
  List<LeaveSummary>? leaveSummary;
  List<LeaveRequests>? leaveRequests;

  LeaveModel({this.employeeId, this.leaveSummary, this.leaveRequests});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    if (json['leave_summary'] != null) {
      leaveSummary = <LeaveSummary>[];
      json['leave_summary'].forEach((v) {
        leaveSummary!.add(new LeaveSummary.fromJson(v));
      });
    }
    if (json['leave_requests'] != null) {
      leaveRequests = <LeaveRequests>[];
      json['leave_requests'].forEach((v) {
        leaveRequests!.add(new LeaveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    if (this.leaveSummary != null) {
      data['leave_summary'] =
          this.leaveSummary!.map((v) => v.toJson()).toList();
    }
    if (this.leaveRequests != null) {
      data['leave_requests'] =
          this.leaveRequests!.map((v) => v.toJson()).toList();
    }
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

class LeaveRequests {
  int? leaveRequestId;
  String? leaveTypeName;
  String? fromDate;
  String? toDate;
  String? appliedOn;
  String? status;
  String? reason;

  LeaveRequests(
      {this.leaveRequestId,
        this.leaveTypeName,
        this.fromDate,
        this.toDate,
        this.appliedOn,
        this.status,
        this.reason});

  LeaveRequests.fromJson(Map<String, dynamic> json) {
    leaveRequestId = json['leave_request_id'];
    leaveTypeName = json['leave_type_name'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    appliedOn = json['applied_on'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_request_id'] = this.leaveRequestId;
    data['leave_type_name'] = this.leaveTypeName;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['applied_on'] = this.appliedOn;
    data['status'] = this.status;
    data['reason'] = this.reason;
    return data;
  }
}
