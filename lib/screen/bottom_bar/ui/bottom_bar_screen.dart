import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../util/image_resource/image_resource.dart';
import '../../../widget/custom_text.dart';
import '../../attendance_screen/ui/attendance_screen.dart';
import '../../home_screen/ui/home_screen.dart';
import '../../leave_screen/ui/leave_screen.dart';
import '../../payslip_screen/ui/payslip_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const AttendanceScreen(),
    const LeaveScreen(),
    const PayslipScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        body: pages[currentIndex],

        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
              )
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomItem(
                index: 0,
                label: "Home",
                selectedIcon: AppIcons.homeActive,
                unSelectedIcon: AppIcons.homeInActive,
              ),

              bottomItem(
                index: 1,
                label: "Attendance",
                selectedIcon: AppIcons.attendeceActive,
                unSelectedIcon: AppIcons.attendanceInActive,
              ),

              bottomItem(
                index: 2,
                label: "Leave",
                selectedIcon: AppIcons.leaveActive,
                unSelectedIcon:  AppIcons.leaveInActive,
              ),

              bottomItem(
                index: 3,
                label: "Payslip",
                selectedIcon: AppIcons.payshipActive,
                unSelectedIcon: AppIcons.payslipInActive,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomItem({
    required int index,
    required String label,
    required String selectedIcon,
    required String unSelectedIcon,
  }) {

    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            isSelected ? selectedIcon : unSelectedIcon,
            height: 20,
          ),

          const SizedBox(height: 5),
          CustomText(
            label,
            size: 10,
            weight: FontWeight.w500,
            color:  isSelected ? ColorResource.button1 : ColorResource.grayText,
          )
        ],
      ),
    );
  }
}