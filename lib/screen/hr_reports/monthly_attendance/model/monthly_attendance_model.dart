class AttendanceResponse {
  final String month;
  final int year;
  final List<DayData> days;
  final Summary summary;

  AttendanceResponse({
    required this.month,
    required this.year,
    required this.days,
    required this.summary,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      month: json['month'] ?? '',
      year: json['year'] ?? 0,
      days: (json['days'] as List<dynamic>)
          .map((e) => DayData.fromJson(e))
          .toList(),
      summary: Summary.fromJson(json['summary']),
    );
  }
}

class DayData {
  final String date;
  final String day;
  final String? status; // nullable
  final String workingHours;

  DayData({
    required this.date,
    required this.day,
    required this.status,
    required this.workingHours,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      date: json['date'] ?? '',
      day: json['day'] ?? '',
      status: json['status'], // can be null
      workingHours: json['working_hours'] ?? '00:00',
    );
  }
}

class Summary {
  final int present;
  final int absent;
  final int leave;
  final int holiday;
  final int offDay;
  final String totalWorkingHours;

  Summary({
    required this.present,
    required this.absent,
    required this.leave,
    required this.holiday,
    required this.offDay,
    required this.totalWorkingHours,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      present: json['present'] ?? 0,
      absent: json['absent'] ?? 0,
      leave: json['leave'] ?? 0,
      holiday: json['holiday'] ?? 0,
      offDay: json['off_day'] ?? 0,
      totalWorkingHours: json['total_working_hours'] ?? '00:00',
    );
  }
}
