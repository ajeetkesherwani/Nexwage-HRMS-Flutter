import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/FontResource/FontResource.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText(
      this.text, {
        super.key,
        this.size = 14,
        this.weight = FontWeight.w400,
        this.color,
        this.align,
        this.maxLines,
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        //fontFamily: FontResource.plusJakartaSans,
        fontFamily: FontResource.sora,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }
}
