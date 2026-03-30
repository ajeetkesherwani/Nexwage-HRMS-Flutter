// model/annual_attendance_model.dart
class AnnualAttendanceResponse {
  final bool status;
  final String message;
  final List<AttendanceDay> data;

  AnnualAttendanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AnnualAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AnnualAttendanceResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => AttendanceDay.fromJson(e))
          .toList(),
    );
  }
}

class AttendanceDay {
  final String attendanceDate;
  final String? clockIn;
  final String? clockOut;
  final String? totalWork;
  final String? overtimeHours;
  final String? overtimeStatus;
  final String? attendanceStatus;
  final bool isOffDay;
  final bool workedOnLeave;
  final String? timeLate;
  final String? earlyLeaving;
  final bool isPresent;
  final bool isAbsent;
  final bool isLeave;

  AttendanceDay({
    required this.attendanceDate,
    this.clockIn,
    this.clockOut,
    this.totalWork,
    this.overtimeHours,
    this.overtimeStatus,
    this.attendanceStatus,
    required this.isOffDay,
    required this.workedOnLeave,
    this.timeLate,
    this.earlyLeaving,
    required this.isPresent,
    required this.isAbsent,
    required this.isLeave,
  });

  factory AttendanceDay.fromJson(Map<String, dynamic> json) {
    return AttendanceDay(
      attendanceDate: json['attendance_date'],
      clockIn: json['clock_in'],
      clockOut: json['clock_out'],
      totalWork: json['total_work'],
      overtimeHours: json['overtime_hours'],
      overtimeStatus: json['overtime_status'],
      attendanceStatus: json['attendance_status'],
      isOffDay: json['is_off_day'] ?? false,
      workedOnLeave: json['worked_on_leave'] ?? false,
      timeLate: json['time_late'],
      earlyLeaving: json['early_leaving'],
      isPresent: json['is_present'] ?? false,
      isAbsent: json['is_absent'] ?? false,
      isLeave: json['is_leave'] ?? false,
    );
  }
}
