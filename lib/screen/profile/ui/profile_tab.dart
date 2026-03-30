import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/custom_text.dart';
class ProfileTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ProfileTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorResource.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isSelected
                  ? ColorResource.button1
                  : Colors.transparent,
            ),
          ),
        ),
        child: CustomText(
          title,
          size: 14,
          weight: FontWeight.w600,
          color: isSelected
              ? ColorResource.button1
              : ColorResource.grayText,
        ),
      ),
    );
  }
}