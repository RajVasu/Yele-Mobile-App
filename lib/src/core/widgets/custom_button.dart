import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? textColor;
  final Color? buttonColor;
  final double? fontSize;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isLoading;

  final BorderRadiusGeometry? borderRadius;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final double? borderWidth;
  final Gradient? gradient;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.fontWeight,
    this.borderColor,
    this.borderWidth,
    this.margin,
    this.isLoading = false,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 1.4.h),
        margin: margin,
        // height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0.0,
          ),
          color: buttonColor ?? AppColors.appColor,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 20.7,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.whiteColor,
                  ),
                )
                : CustomText(
                  text: text,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  color: textColor ?? AppColors.whiteColor,
                  fontSize: fontSize ?? 17.sp,
                ),
      ),
    );
  }
}
