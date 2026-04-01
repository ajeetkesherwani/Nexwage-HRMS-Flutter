import 'package:flutter/material.dart';
import 'package:nexwage/screen/holidays/ui/past_screen.dart';
import 'package:nexwage/screen/holidays/ui/up_coming.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import '../../../widget/custom_text.dart';

class HolidaysScreen extends StatefulWidget {
  const HolidaysScreen({super.key});
  @override
  State<HolidaysScreen> createState() => _HolidaysScreenState();
}

class _HolidaysScreenState extends State<HolidaysScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(title: 'Holidays'),
        backgroundColor: ColorResource.white,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            "Upcoming",
                            size: 14,
                            weight: FontWeight.w600,
                            color: selectedTab == 0
                                ? ColorResource.black
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
                            "Past",
                            size: 14,
                            weight: FontWeight.w600,
                            color: selectedTab == 1
                                ? ColorResource.black
                                : ColorResource.grayText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: selectedTab == 0
                    ? const UpComingScreen()
                    : const PastScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}