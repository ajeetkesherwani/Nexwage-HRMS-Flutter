class HomeModel {
  bool? status;
  String? message;
  Data? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? shiftStart;
  String? shiftEnd;
  String? timeCovered;
  Location? location;
  int? attendanceRadius;
  ReportingHead? reportingHead;

  Data(
      {this.name,
        this.shiftStart,
        this.shiftEnd,
        this.timeCovered,
        this.location,
        this.attendanceRadius,
        this.reportingHead});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shiftStart = json['shift_start'];
    shiftEnd = json['shift_end'];
    timeCovered = json['time_covered'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    attendanceRadius = json['attendance_radius'];
    reportingHead = json['reporting_head'] != null
        ? new ReportingHead.fromJson(json['reporting_head'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['shift_start'] = this.shiftStart;
    data['shift_end'] = this.shiftEnd;
    data['time_covered'] = this.timeCovered;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['attendance_radius'] = this.attendanceRadius;
    if (this.reportingHead != null) {
      data['reporting_head'] = this.reportingHead!.toJson();
    }
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class ReportingHead {
  String? name;
  String? email;
  String? phone;
  String? designation;

  ReportingHead({this.name, this.email, this.phone,this.designation});

  ReportingHead.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['designation'] = this.designation;
    return data;
  }
}
