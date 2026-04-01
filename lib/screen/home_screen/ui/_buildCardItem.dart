import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/custom_text.dart';
class buildCardItem extends StatelessWidget {
  final String timer;
  final String shift;
  final String shiftStatus;
  final String buttonText;
  final VoidCallback onTap;
  const buildCardItem({super.key,required this.timer,required this.shift,required this.shiftStatus,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Attendance',
              size: 16,
              weight: FontWeight.w600,
              color: ColorResource.black,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: shiftStatus.contains("ON")
                    ? ColorResource.greenBackground
                    : ColorResource.greenBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(53),
                ),
              ),
              child: CustomText(
                shiftStatus,
                size: 10,
                weight: FontWeight.w700,
                color: shift.contains("ON")
                    ? ColorResource.green
                    : Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  timer,
                  size: 30,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),
                CustomText(
                  shift,
                  size: 10,
                  weight: FontWeight.w600,
                  color: ColorResource.grayText,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorResource.button1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  buttonText,
                  size: 14,
                  weight: FontWeight.w700,
                  color: ColorResource.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
