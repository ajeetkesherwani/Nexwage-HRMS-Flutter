class PanchOutModel {
  bool? status;
  String? message;
  Data? data;

  PanchOutModel({this.status, this.message, this.data});

  PanchOutModel.fromJson(Map<String, dynamic> json) {
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
  String? punchOutTime;
  String? punchInTime;
  double? totalHours;
  String? totalWork;
  int? overtimeHours;
  String? overtimeStatus;
  String? earlyLeaving;
  bool? isOffDay;
  bool? workedOnLeave;
  bool? isOutsideLocation;
  AttendanceSummary? attendanceSummary;

  Data(
      {this.attendanceId,
        this.punchOutTime,
        this.punchInTime,
        this.totalHours,
        this.totalWork,
        this.overtimeHours,
        this.overtimeStatus,
        this.earlyLeaving,
        this.isOffDay,
        this.workedOnLeave,
        this.isOutsideLocation,
        this.attendanceSummary});

  Data.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendance_id'];
    punchOutTime = json['punch_out_time'];
    punchInTime = json['punch_in_time'];
    totalHours = json['total_hours'];
    totalWork = json['total_work'];
    overtimeHours = json['overtime_hours'];
    overtimeStatus = json['overtime_status'];
    earlyLeaving = json['early_leaving'];
    isOffDay = json['is_off_day'];
    workedOnLeave = json['worked_on_leave'];
    isOutsideLocation = json['is_outside_location'];
    attendanceSummary = json['attendance_summary'] != null
        ? new AttendanceSummary.fromJson(json['attendance_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance_id'] = this.attendanceId;
    data['punch_out_time'] = this.punchOutTime;
    data['punch_in_time'] = this.punchInTime;
    data['total_hours'] = this.totalHours;
    data['total_work'] = this.totalWork;
    data['overtime_hours'] = this.overtimeHours;
    data['overtime_status'] = this.overtimeStatus;
    data['early_leaving'] = this.earlyLeaving;
    data['is_off_day'] = this.isOffDay;
    data['worked_on_leave'] = this.workedOnLeave;
    data['is_outside_location'] = this.isOutsideLocation;
    if (this.attendanceSummary != null) {
      data['attendance_summary'] = this.attendanceSummary!.toJson();
    }
    return data;
  }
}

class AttendanceSummary {
  String? date;
  String? employeeName;
  String? shiftStart;
  String? shiftEnd;
  String? clockIn;
  String? clockOut;
  double? totalWorkHrs;
  int? overtimeHrs;
  String? overtimeStatus;

  AttendanceSummary(
      {this.date,
        this.employeeName,
        this.shiftStart,
        this.shiftEnd,
        this.clockIn,
        this.clockOut,
        this.totalWorkHrs,
        this.overtimeHrs,
        this.overtimeStatus});

  AttendanceSummary.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    employeeName = json['employee_name'];
    shiftStart = json['shift_start'];
    shiftEnd = json['shift_end'];
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
    totalWorkHrs = json['total_work_hrs'];
    overtimeHrs = json['overtime_hrs'];
    overtimeStatus = json['overtime_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['employee_name'] = this.employeeName;
    data['shift_start'] = this.shiftStart;
    data['shift_end'] = this.shiftEnd;
    data['clock_in'] = this.clockIn;
    data['clock_out'] = this.clockOut;
    data['total_work_hrs'] = this.totalWorkHrs;
    data['overtime_hrs'] = this.overtimeHrs;
    data['overtime_status'] = this.overtimeStatus;
    return data;
  }
}
