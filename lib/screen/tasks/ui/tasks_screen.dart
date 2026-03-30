import 'package:flutter/material.dart';
import 'package:nexwage/screen/tasks/ui/to_do_screen.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';

import '../../../widget/custom_text.dart';
import 'completed_screen.dart';
import 'in_progress_screen.dart';
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          appBar: CommonAppBar(title: 'Tasks'),
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
                              "To Do",
                              size: 14,
                              weight: FontWeight.w600,
                              color: selectedTab == 0
                                  ? ColorResource.button1
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
                              "In Progress",
                              size: 14,
                              weight: FontWeight.w600,
                              color: selectedTab == 1
                                  ? ColorResource.button1
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
                              "Completed",
                              size: 14,
                              weight: FontWeight.w600,
                              color: selectedTab == 2
                                  ? ColorResource.button1
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
                      ? const ToDoScreen()
                      : selectedTab == 1
                      ? const InProgressScreen()
                      : const CompletedScreen(),
                ),

                // Expanded(
                //   child: [
                //     const ToDoScreen(),
                //     const InProgressScreen(),
                //     const CompletedScreen(),
                //   ][selectedTab],
                // ),
              ],
            ),
          ),
        )
    );
  }
}
