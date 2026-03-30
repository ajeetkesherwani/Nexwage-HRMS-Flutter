class TodayAttendanceModel {
  bool? status;
  String? message;
  Data? data;

  TodayAttendanceModel({this.status, this.message, this.data});

  TodayAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  bool? isPunchedIn;
  List<Sessions>? sessions;
  Sessions? latest;
  List<WeeklySummary>? weeklySummary;

  Data(
      {this.date,
        this.isPunchedIn,
        this.sessions,
        this.latest,
        this.weeklySummary});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isPunchedIn = json['is_punched_in'];
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
    latest =
    json['latest'] != null ? new Sessions.fromJson(json['latest']) : null;
    if (json['weekly_summary'] != null) {
      weeklySummary = <WeeklySummary>[];
      json['weekly_summary'].forEach((v) {
        weeklySummary!.add(new WeeklySummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['is_punched_in'] = this.isPunchedIn;
    if (this.sessions != null) {
      data['sessions'] = this.sessions!.map((v) => v.toJson()).toList();
    }
    if (this.latest != null) {
      data['latest'] = this.latest!.toJson();
    }
    if (this.weeklySummary != null) {
      data['weekly_summary'] =
          this.weeklySummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  int? id;
  String? clockIn;
  String? clockOut;
  int? clockInOut;
  String? timeLate;
  String? earlyLeaving;
  String? totalWork;
  String? overtimeHours;
  String? overtimeStatus;
  bool? isOffDay;
  bool? workedOnLeave;
  int? isOutsideLocation;
  String? attendanceStatus;

  Sessions(
      {this.id,
        this.clockIn,
        this.clockOut,
        this.clockInOut,
        this.timeLate,
        this.earlyLeaving,
        this.totalWork,
        this.overtimeHours,
        this.overtimeStatus,
        this.isOffDay,
        this.workedOnLeave,
        this.isOutsideLocation,
        this.attendanceStatus});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
    clockInOut = json['clock_in_out'];
    timeLate = json['time_late'];
    earlyLeaving = json['early_leaving'];
    totalWork = json['total_work'];
    overtimeHours = json['overtime_hours'];
    overtimeStatus = json['overtime_status'];
    isOffDay = json['is_off_day'];
    workedOnLeave = json['worked_on_leave'];
    isOutsideLocation = json['is_outside_location'];
    attendanceStatus = json['attendance_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clock_in'] = this.clockIn;
    data['clock_out'] = this.clockOut;
    data['clock_in_out'] = this.clockInOut;
    data['time_late'] = this.timeLate;
    data['early_leaving'] = this.earlyLeaving;
    data['total_work'] = this.totalWork;
    data['overtime_hours'] = this.overtimeHours;
    data['overtime_status'] = this.overtimeStatus;
    data['is_off_day'] = this.isOffDay;
    data['worked_on_leave'] = this.workedOnLeave;
    data['is_outside_location'] = this.isOutsideLocation;
    data['attendance_status'] = this.attendanceStatus;
    return data;
  }
}

class WeeklySummary {
  String? date;
  String? day;
  bool? isPresent;
  bool? isAbsent;
  bool? isLeave;
  bool? isOfficeOff;

  WeeklySummary(
      {this.date,
        this.day,
        this.isPresent,
        this.isAbsent,
        this.isLeave,
        this.isOfficeOff});

  WeeklySummary.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    isPresent = json['is_present'];
    isAbsent = json['is_absent'];
    isLeave = json['is_leave'];
    isOfficeOff = json['is_office_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['is_present'] = this.isPresent;
    data['is_absent'] = this.isAbsent;
    data['is_leave'] = this.isLeave;
    data['is_office_off'] = this.isOfficeOff;
    return data;
  }
}
