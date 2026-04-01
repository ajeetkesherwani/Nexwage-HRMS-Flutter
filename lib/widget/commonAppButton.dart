import 'package:flutter/material.dart';


import '../util/FontResource/FontResource.dart';
import '../util/color/app_colors.dart';
import 'customImageView.dart';

class CommonAppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading; // 👈 main control
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color textColor;
  final Color? borderColor;
  final String? image;

  const CommonAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor1 = ColorResource.button1,
    this.backgroundColor2 = ColorResource.button2,
    this.textColor = ColorResource.white,
    this.borderColor,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed, // 👈 disable click
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [Colors.grey, Colors.grey] // 👈 loading color
                : [backgroundColor1, backgroundColor2],
          ),
          borderRadius: BorderRadius.circular(12),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? const SizedBox(
            key: ValueKey("loader"),
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
              : Row(
            key: const ValueKey("text"),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null) ...[
                CustomImageView(
                  imagePath: image,
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: FontResource.plusJakartaSans,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




