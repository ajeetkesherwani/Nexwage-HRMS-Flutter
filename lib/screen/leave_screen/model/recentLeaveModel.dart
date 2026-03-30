class RecentLeaveModel {
  final String type;
  final String dateRange;
  final String days;
  final String appliedOn;
  final String status;
  final String? approvedBy;
  final String? note;

  RecentLeaveModel({
    required this.type,
    required this.dateRange,
    required this.days,
    required this.appliedOn,
    required this.status,
    this.approvedBy,
    this.note,
  });
}