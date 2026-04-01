import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:table_calendar/table_calendar.dart';
class CustomCalendarBottomSheet extends StatefulWidget {
  @override
  State<CustomCalendarBottomSheet> createState() =>
      _CustomCalendarBottomSheetState();
}

class _CustomCalendarBottomSheetState
    extends State<CustomCalendarBottomSheet> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime focusedDay = DateTime.now();

  bool isInRange(DateTime day) {
    if (startDate == null || endDate == null) return false;
    return day.isAfter(startDate!) && day.isBefore(endDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// DRAG HANDLE
          Container(
            height: 5,
            width: 50,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select Dates",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${focusedDay.month}/${focusedDay.year}",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),

          SizedBox(height: 10),

          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: focusedDay,

            selectedDayPredicate: (day) =>
            isSameDay(startDate, day) || isSameDay(endDate, day),

            onDaySelected: (selectedDay, _) {
              setState(() {
                if (startDate == null || endDate != null) {
                  startDate = selectedDay;
                  endDate = null;
                } else {
                  endDate = selectedDay;
                }
              });
            },

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                if (isSameDay(day, startDate) ||
                    isSameDay(day, endDate)) {
                  return _selectedBox(day,
                      isEnd: isSameDay(day, endDate));
                } else if (isInRange(day)) {
                  return _rangeBox(day);
                }
                return Center(child: Text('${day.day}'));
              },
            ),
          ),


          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("FROM"),
                  Text(startDate != null
                      ? "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                      : "-"),
                ],
              ),
              Column(
                children: [
                  Text("TO"),
                  Text(endDate != null
                      ? "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                      : "-"),
                ],
              ),
            ],
          ),

          SizedBox(height: 15),

          CommonAppButton(
            backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
              text: 'Apply',
            onPressed: () {
              if (startDate != null && endDate != null) {
                Navigator.pop(context, {
                  "startDate": startDate,
                  "endDate": endDate,
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _selectedBox(DateTime day, {bool isEnd = false}) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(isEnd ? 0 : 12),
          right: Radius.circular(isEnd ? 12 : 0),
        ),
      ),
      alignment: Alignment.center,
      child: Text("${day.day}", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _rangeBox(DateTime day) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorResource.primaryColor,
      ),
      alignment: Alignment.center,
      child: Text("${day.day}"),
    );
  }
}