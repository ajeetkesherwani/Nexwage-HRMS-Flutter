import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/customImageView.dart';
import '../../../widget/custom_text.dart';
class Announecement extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const Announecement({super.key,required this.image,required this.title,required this.subTitle,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorResource.white,
        borderRadius: BorderRadius.circular(24),
        border: const Border(
          left: BorderSide(width: 10, color: ColorResource.button1),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: image,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Column(
            children: [
              CustomText(
                title,
                size: 16,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              CustomText(
                subTitle,
                size: 14,
                weight: FontWeight.w400,
                color: ColorResource.grayText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
