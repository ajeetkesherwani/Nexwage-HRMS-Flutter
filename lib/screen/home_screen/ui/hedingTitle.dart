import 'package:flutter/material.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/custom_text.dart';
class hedingTitle extends StatelessWidget {
  final String title;
  const hedingTitle({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title,
      size: 16,
      weight: FontWeight.w600,
      color: ColorResource.black,
    );
  }
}
