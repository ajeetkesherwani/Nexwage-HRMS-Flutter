import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/customImageView.dart';
import '../../../widget/custom_text.dart';
class mainMenu extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String image;
  final Color color;
  const mainMenu({super.key,required this.onTap,required this.title,required this.image,required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 104,
        width: 94,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: image,
              height: 32,
              width: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            CustomText(
              title,
              size: 10,
              weight: FontWeight.w600,
              color: ColorResource.black,
            ),
          ],
        ),
      ),
    );
  }
}
