class LeaveTypeModel {
  bool? status;
  List<Data>? data;

  LeaveTypeModel({this.status, this.data});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? leaveType;
  int? allocatedDay;
  bool? allowHalfDay;

  Data({this.id, this.leaveType, this.allocatedDay, this.allowHalfDay});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
    allocatedDay = json['allocated_day'];
    allowHalfDay = json['allow_half_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_type'] = this.leaveType;
    data['allocated_day'] = this.allocatedDay;
    data['allow_half_day'] = this.allowHalfDay;
    return data;
  }
}
