import 'package:flutter/material.dart';

import '../util/FontResource/FontResource.dart';
import '../util/color/app_colors.dart';
import 'custom_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final bool isBack;
  final String? actionImage;
  final VoidCallback? onActionTap;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.subTitle,
    this.isBack = true,
    this.actionImage,
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          automaticallyImplyLeading: false,
          titleSpacing: 0,
          actions: [
            if (actionImage != null)
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: onActionTap,
                  child: Image.asset(
                    actionImage!,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
          ],

          title: Stack(

            children: [

              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: FontResource.sora,
                      ),
                    ),
                    if (subTitle != null && subTitle!.isNotEmpty)
                      CustomText(
                        subTitle!,
                        size: 11,
                        weight: FontWeight.w400,
                        color: ColorResource.black,
                      ),
                  ],
                ),
              ),

              if (isBack)
                Positioned(
                  left: 15,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),

              // if (actionImage != null)
              //   Positioned(
              //     right: 15,
              //     child: GestureDetector(
              //       onTap: onActionTap,
              //       child: Image.asset(
              //         actionImage!,
              //         height: 24,
              //         width: 24,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}