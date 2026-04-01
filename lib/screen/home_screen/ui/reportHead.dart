import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../util/image_resource/image_resource.dart';
import '../../../widget/customImageView.dart';
import '../../../widget/custom_text.dart';
class reportHead extends StatelessWidget {
  final String title;
  final String subTitle;
  final String email;
  final String mobileNumber;
  const reportHead({super.key,required this.title,required this.subTitle,required this.email,required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFF8FAFC)),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResource.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.person, color: ColorResource.button1),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                  CustomText(
                    subTitle,
                    size: 11,
                    weight: FontWeight.w400,
                    color: ColorResource.grayText,
                  ),
                  CustomText(
                    email,
                    size: 11,
                    weight: FontWeight.w400,
                    color: ColorResource.grayText,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                CustomText(
                  mobileNumber,
                  size: 12,
                  weight: FontWeight.w600,
                  color: ColorResource.grayText,
                ),
                Spacer(),
                CustomImageView(
                  imagePath: AppIcons.callIcon,
                  height: 14,
                  width: 14,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 5),
                CustomText(
                  'CALL NOW',
                  size: 11,
                  weight: FontWeight.w700,
                  color: ColorResource.button1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
