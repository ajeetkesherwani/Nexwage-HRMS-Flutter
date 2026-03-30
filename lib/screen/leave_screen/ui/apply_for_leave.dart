import 'package:flutter/material.dart';
import 'package:nexwage/screen/leave_screen/ui/first_half.dart';
import 'package:nexwage/screen/leave_screen/ui/full_day_screen.dart';
import 'package:nexwage/screen/leave_screen/ui/second_half.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:nexwage/widget/commonTextFormField.dart';
import 'package:nexwage/widget/custom_text.dart';
class ApplyForLeaveScreen extends StatefulWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  State<ApplyForLeaveScreen> createState() => _ApplyForLeaveScreenState();
}

class _ApplyForLeaveScreenState extends State<ApplyForLeaveScreen> {
  TextEditingController leaveController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTimeRange? selectedDateRange;

  List<String> leaveTypes = [
    'Sick Leave',
    'Casual Leave',
    'Paid Leave',
    'Annual Leave',
  ];
  int selectedTab = 0;
  String? selectedLeave;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Apply for leave'),
          backgroundColor: ColorResource.white,
          body: Padding(
              padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Leave Type',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                CommonTextFormField(
                  controller: leaveController,
                  hintText: 'Select leave type',
                  readOnly: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                          itemCount: leaveTypes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(leaveTypes[index]),
                              onTap: () {
                                setState(() {
                                  selectedLeave = leaveTypes[index];
                                  leaveController.text = selectedLeave!;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 10,),
                CustomText(
                  'Selected Date',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                CommonTextFormField(
                  controller: dateController,
                  prefixIcon: Icons.calendar_today,
                  hintText: 'Select date',
                  readOnly: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDateRange: selectedDateRange,
                    );

                    if (picked != null) {
                      setState(() {
                        selectedDateRange = picked;

                        dateController.text =
                        "${picked.start.day}/${picked.start.month}/${picked.start.year} "
                            "- "
                            "${picked.end.day}/${picked.end.month}/${picked.end.year}";
                      });
                    }
                  },
                ),
                SizedBox(height: 10,),
                CustomText(
                  'Session',
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorResource.holidaysColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = 0;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedTab == 0
                                  ? ColorResource.white
                                  : ColorResource.holidaysColor,
                            ),
                            child: CustomText(
                              "Full Day",
                              size: 14,
                              weight: FontWeight.w600,
                              color: selectedTab == 0
                                  ? ColorResource.orange
                                  : ColorResource.grayText,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = 1;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedTab == 1
                                  ? ColorResource.white
                                  : ColorResource.holidaysColor,
                            ),
                            child: CustomText(
                              "First Half",
                              size: 14,
                              weight: FontWeight.w600,
                              color: selectedTab == 1
                                  ? ColorResource.orange
                                  : ColorResource.grayText,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = 2;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedTab == 2
                                  ? ColorResource.white
                                  : ColorResource.holidaysColor,
                            ),
                            child: CustomText(
                              "Second Half",
                              size: 14,
                              weight: FontWeight.w600,
                              color: selectedTab == 2
                                  ? ColorResource.orange
                                  : ColorResource.grayText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: selectedTab == 0
                      ? const FullDayScreen()
                      : selectedTab == 1
                      ? const FirstHalfScreen()
                      : const SecondHalfScreen(),
                ),
              ],
            ),
          ),
        )
    );
  }
}
