import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;
  final int? maxLines;
  final double? height;
  final TextOverflow? textOverFlow;
  final TextDecoration? decoration;
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.textAlign,
    this.fontFamily,
    this.maxLines,
    this.height,
    this.textOverFlow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          overflow: textOverFlow,
          height: height,
          fontFamily: fontFamily ?? AppStrings.fontFamily,
          fontSize: fontSize ?? 16.sp,
          color: color ?? AppColors.blackColor,
          fontWeight: fontWeight,
          decoration: decoration),
    );
  }
}
