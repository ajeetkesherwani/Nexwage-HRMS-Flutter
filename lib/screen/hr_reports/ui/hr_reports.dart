import 'package:flutter/material.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/commonAppButton.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/custom_text.dart';

import '../../../widget/commonAppBar.dart';
import '../../../widget/navigator_method.dart';
import '../monthly_attendance/ui/annual_reports.dart';
import '../monthly_attendance/ui/monthly_attendance.dart';

class HrReportsScreen extends StatefulWidget {
  const HrReportsScreen({super.key});

  @override
  State<HrReportsScreen> createState() => _HrReportsScreenState();
}

class _HrReportsScreenState extends State<HrReportsScreen> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    int lastDayOfMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'HR REPORTS'),
        backgroundColor: ColorResource.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                CustomText(
                  'Access and download your official employment\nreports and summaries.',
                  size: 13,
                  weight: FontWeight.w400,
                  color: ColorResource.grayText,
                  align: TextAlign.center,
                ),
                SizedBox(height: 15),


                hrReport(
                  onTap: () {
                    navPush(
                      context: context,
                      action: MonthlyAttendanceScreen(),
                    );
                  },
                  image: AppImages.monthkyReport,
                  title: 'Monthly Attendance Report',
                  subTitle:
                      'Period: 1 ${monthNames[selectedMonth - 1]} – $lastDayOfMonth ${monthNames[selectedMonth - 1]}, $selectedYear',
                ),
                // SizedBox(height: 10),
                // hrReport(
                //   onTap: () {},
                //   image: AppImages.dateWish,
                //   title: 'Date Wise Attendance',
                //   subTitle: 'Choose date',
                // ),
                SizedBox(height: 10),
                hrReport(
                  onTap: () {
                    navPush(context: context, action: AnnualAttendanceScreen());
                  },
                  image: AppImages.montlyAttendence,
                  title: 'Monthly Attendance',
                  subTitle: '$selectedYear Annual Filing',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hrReport({
    required String image,
    required String title,
    required String subTitle,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: image,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),
                  CustomText(
                    subTitle,
                    size: 10,
                    weight: FontWeight.w400,
                    color: ColorResource.grayText,
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.picture_as_pdf,
                size: 24,
                color: ColorResource.grayText,
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: CommonAppButton(
              text: 'View Report',
              onPressed: onTap,
              backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
            ),
          ),
        ],
      ),
    );
  }
}
