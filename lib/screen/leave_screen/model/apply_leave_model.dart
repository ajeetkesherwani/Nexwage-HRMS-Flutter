class ApplyLeaveModel {
  bool? status;
  String? message;
  Data? data;

  ApplyLeaveModel({this.status, this.message, this.data});

  ApplyLeaveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? leaveRequestId;
  int? totalDays;
  String? status;

  Data({this.leaveRequestId, this.totalDays, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    leaveRequestId = json['leave_request_id'];
    totalDays = json['total_days'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_request_id'] = this.leaveRequestId;
    data['total_days'] = this.totalDays;
    data['status'] = this.status;
    return data;
  }
}
