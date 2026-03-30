import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:provider/provider.dart';
import '../provider/report_provider.dart';
import '../model/annual_attendance_model.dart';

class AnnualAttendanceScreen extends StatefulWidget {
  const AnnualAttendanceScreen({super.key});

  @override
  State<AnnualAttendanceScreen> createState() => _AnnualAttendanceScreenState();
}

class _AnnualAttendanceScreenState extends State<AnnualAttendanceScreen> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  final List<int> years = List.generate(
    DateTime.now().year - 2019,
    (index) => 2024 + index,
  );
  final List<int> months = List.generate(12, (index) => index + 1);

  final List<Map<String, dynamic>> monthList = [
    {'name': 'Jan', 'value': 1},
    {'name': 'Feb', 'value': 2},
    {'name': 'Mar', 'value': 3},
    {'name': 'Apr', 'value': 4},
    {'name': 'May', 'value': 5},
    {'name': 'Jun', 'value': 6},
    {'name': 'Jul', 'value': 7},
    {'name': 'Aug', 'value': 8},
    {'name': 'Sep', 'value': 9},
    {'name': 'Oct', 'value': 10},
    {'name': 'Nov', 'value': 11},
    {'name': 'Dec', 'value': 12},
  ];

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  void _fetchAttendance() {
    Future.microtask(() {
      Provider.of<ReportProvider>(
        context,
        listen: false,
      ).getAnnualAttendance({"month": selectedMonth, "year": selectedYear});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'Attendance'),
        body: Column(
          children: [
            _buildFilters(),
            Expanded(
              child: Consumer<ReportProvider>(
                builder: (context, provider, child) {
                  if (provider.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = provider.annualAttendanceResponse;
                  if (data == null) {
                    return const Center(child: Text("No Data"));
                  }

                  final summary = _calculateSummary(data.data);

                  return Column(
                    children: [
                      _buildHeader(summary),
                      _buildSummary(summary),
                      const SizedBox(height: 10),
                      _buildWeekDays(),
                      Expanded(child: _buildCalendarGrid(data.data)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _styledDropdown(
              value: selectedYear,
              items: years,
              onChanged: (val) {
                if (val != null) {
                  setState(() => selectedYear = val);
                  _fetchAttendance();
                }
              },
              hint: "Year",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButton<int>(
                value: selectedMonth,
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                items: monthList
                    .map(
                      (month) => DropdownMenuItem<int>(
                        value: month['value'],
                        child: Text(month['name']),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedMonth = val);
                    _fetchAttendance();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _styledDropdown({
    required int value,
    required List<int> items,
    required Function(int?) onChanged,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<int>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(), // remove default underline
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        items: items
            .map((i) => DropdownMenuItem(value: i, child: Text(i.toString())))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  /// Header with month/year
  Widget _buildHeader(AttendanceSummary summary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$selectedMonth/$selectedYear",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Attendance Overview",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.2,
            children: [
              _statusCard("Present", summary.present, Colors.green),
              _statusCard("Absent", summary.absent, Colors.red),
              _statusCard("Off Day", summary.offDay, Colors.blue),
              _statusCard("Leave", summary.leave, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusCard(String title, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "$value days",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Summary Row
  Widget _buildSummary(AttendanceSummary summary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem("P", summary.present, Colors.green),
          _summaryItem("A", summary.absent, Colors.red),
          _summaryItem("O", summary.offDay, Colors.blue),
          _summaryItem("L", summary.leave, Colors.orange),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            "$label: $count",
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map(
            (e) => Expanded(
              child: Center(
                child: Text(
                  e,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid(List<AttendanceDay> days) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final day = days[index];
        final date = DateTime.parse(
          day.attendanceDate.split('-').reversed.join('-'),
        ); // dd-mm-yyyy → yyyy-mm-dd

        return GestureDetector(
          onTap: () => _showDayDetails(day),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${date.day}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                if (day.attendanceStatus != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: _getDotColor(day.attendanceStatus),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getDotColor(String? status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'off':
        return Colors.blue;
      case 'leave':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showDayDetails(AttendanceDay day) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day.attendanceDate,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text("Status: ${day.attendanceStatus ?? 'N/A'}"),
              Text("Clock In: ${day.clockIn ?? 'N/A'}"),
              Text("Clock Out: ${day.clockOut ?? 'N/A'}"),
              Text("Total Work: ${day.totalWork ?? 'N/A'}"),
              Text("Overtime Hours: ${day.overtimeHours ?? 'N/A'}"),
              Text("Late By: ${day.timeLate ?? 'N/A'}"),
              Text("Early Leaving: ${day.earlyLeaving ?? 'N/A'}"),
            ],
          ),
        );
      },
    );
  }

  /// Calculate summary for Present / Absent / Off Day / Leave
  AttendanceSummary _calculateSummary(List<AttendanceDay> days) {
    int present = 0, absent = 0, offDay = 0, leave = 0;

    for (var day in days) {
      switch (day.attendanceStatus) {
        case 'present':
          present++;
          break;
        case 'absent':
          absent++;
          break;
        case 'off':
          offDay++;
          break;
        case 'leave':
          leave++;
          break;
      }
    }
    return AttendanceSummary(
      present: present,
      absent: absent,
      offDay: offDay,
      leave: leave,
    );
  }
}

/// Simple summary model
class AttendanceSummary {
  final int present;
  final int absent;
  final int offDay;
  final int leave;

  AttendanceSummary({
    required this.present,
    required this.absent,
    required this.offDay,
    required this.leave,
  });
}
