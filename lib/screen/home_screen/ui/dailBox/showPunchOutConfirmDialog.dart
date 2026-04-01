import 'package:flutter/material.dart';

import '../../../../util/color/app_colors.dart';
import '../../../../widget/commonAppButton.dart';
import '../../../../widget/custom_text.dart';

class ShowDailBox{
  static void showPunchOutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: Center(
            child: CustomText(
              "Confirm",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.orange,
                size: 60,
              ),
              SizedBox(height: 10),
              CustomText(
                "Are you sure you want to Punch Out?",
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonAppButton(
                    text: "No",
                    backgroundColor1: Colors.grey,
                    backgroundColor2: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CommonAppButton(
                    text: "Yes",
                    backgroundColor1: ColorResource.button1,
                    backgroundColor2: ColorResource.button1,
                    onPressed: () {
                      Navigator.pop(context);
                      showPunchOutSuccessDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }



  static void showPunchOutSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: Center(
            child: CustomText(
              "Success",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: Colors.orange,
                size: 60,
              ),
              SizedBox(height: 10),
              CustomText(
                "Punch Out Successfully",
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),

          actions: [
            CommonAppButton(
              text: "OK",
              backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static   void showAttendanceSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Center(
            child: CustomText(
              "Success",
              size: 18,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              CustomText(
                "Attendance Marked Successfully",
                size: 13,
                weight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ],
          ),
          actions: [
            CommonAppButton(
              text: "OK",
              backgroundColor1: ColorResource.button1,
              backgroundColor2: ColorResource.button1,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static  void showOutOfRangeDialog(BuildContext context, double distance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),

                const SizedBox(height: 20),

                CustomText(
                  'Out of Range',
                  size: 20,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),

                const SizedBox(height: 10),

                CustomText(
                  "You are ${distance.toStringAsFixed(0)}m away from the office premises. Please move closer to clock in.",
                  size: 14,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                  align: TextAlign.center,
                ),

                const SizedBox(height: 25),

                CommonAppButton(
                  text: 'Try Again',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor1: ColorResource.button1,
                  backgroundColor2: ColorResource.button1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showAlreadyMarkedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Already Marked",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Your attendance has already been marked for today.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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

}