class AttendanceModel {
  bool? status;
  String? message;
  Data? data;

  AttendanceModel({this.status, this.message, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
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
  int? attendanceId;
  String? status;
  String? punchInTime;
  String? attendanceDate;
  Shift? shift;
  Flags? flags;
  int? distanceFromOffice; // ✅ FIXED

  Data({
    this.attendanceId,
    this.status,
    this.punchInTime,
    this.attendanceDate,
    this.shift,
    this.flags,
    this.distanceFromOffice,
  });

  Data.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendance_id'];
    status = json['status'];
    punchInTime = json['punch_in_time'];
    attendanceDate = json['attendance_date'];
    shift = json['shift'] != null ? Shift.fromJson(json['shift']) : null;
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;

    // ✅ Safe parsing (best practice)
    distanceFromOffice = json['distance_from_office'] is int
        ? json['distance_from_office']
        : int.tryParse(json['distance_from_office'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['attendance_id'] = attendanceId;
    data['status'] = status;
    data['punch_in_time'] = punchInTime;
    data['attendance_date'] = attendanceDate;

    if (shift != null) {
      data['shift'] = shift!.toJson();
    }

    if (flags != null) {
      data['flags'] = flags!.toJson();
    }

    data['distance_from_office'] = distanceFromOffice;

    return data;
  }
}


class Shift {
  String? start;
  String? end;

  Shift({this.start, this.end});

  Shift.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class Flags {
  bool? isLate;
  bool? isOutsideLocation;
  bool? isOffDay;
  bool? workedOnLeave;
  bool? isHalfDayLeave;
  bool? spoofSuspected;

  Flags(
      {this.isLate,
        this.isOutsideLocation,
        this.isOffDay,
        this.workedOnLeave,
        this.isHalfDayLeave,
        this.spoofSuspected});

  Flags.fromJson(Map<String, dynamic> json) {
    isLate = json['is_late'];
    isOutsideLocation = json['is_outside_location'];
    isOffDay = json['is_off_day'];
    workedOnLeave = json['worked_on_leave'];
    isHalfDayLeave = json['is_half_day_leave'];
    spoofSuspected = json['spoof_suspected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_late'] = this.isLate;
    data['is_outside_location'] = this.isOutsideLocation;
    data['is_off_day'] = this.isOffDay;
    data['worked_on_leave'] = this.workedOnLeave;
    data['is_half_day_leave'] = this.isHalfDayLeave;
    data['spoof_suspected'] = this.spoofSuspected;
    return data;
  }
}
