import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppButton.dart';
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
  Future<bool> showExitDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                ),

                const SizedBox(height: 15),

               CustomText(
                 'Exit App',
                 size: 18,
                 weight: FontWeight.w700,
                 color: ColorResource.black,
               ),

                const SizedBox(height: 10),

                CustomText(
                  'Are you sure you want to exit?',
                  size: 13,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                 Expanded(
                   child: CommonAppButton(
                     backgroundColor1: ColorResource.green,
                       backgroundColor2: ColorResource.green,
                       text: 'Cancel',
                     onPressed: () {
                       Navigator.pop(context, false);
                     },
                   ),
                 ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CommonAppButton(
                        backgroundColor2: ColorResource.red,
                        backgroundColor1: ColorResource.red,
                        text: 'Exit',
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        );
      },
    ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitDialog();
      },
      child: SafeArea(
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