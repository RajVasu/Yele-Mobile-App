import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLength;
  final String? displayTitle;
  final String? suffixIcon;
  final Color? suffixIconcolor;
  final Color? prefixIconColor;
  final String? prefixIcon;
  final Widget? prefix;
  final double? prefixIconSize;
  final String? hintText;
  final String? Function(String? value)? validator;
  final Function()? onTap;
  final Function()? suffixIconOnTap;
  final bool obscureText;
  final int? maxLines;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? suffixIconColor;
  final Color? bgColorColor;
  final TextInputAction? textInputAction;
  final bool isSuffixIconShow;
  final double? displyFontSize;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function()? onEditComplete;
  final String? errorText;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final FocusNode? focusNode2;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final Color? displayColor;
  final double? hintTextSize;
  final double? suffixIconPadding;
  final Color? hintTextColor;
  final Color? cursorColor;
  final String? prefixText;
  final String? suffixText;
  final String? displayText;
  const CustomTextfield({
    super.key,
    this.controller,
    this.hintText,
    this.cursorColor,
    this.suffixIconcolor,
    this.displayTitle,
    this.maxLength,
    this.onTap,
    this.suffixIconOnTap,
    this.prefixIcon,
    this.prefix,
    this.inputFormatters,
    this.validator,
    this.textColor,
    this.keyboardType,
    this.readOnly = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.prefixIconSize = 0.8,
    this.suffixIcon,
    this.suffixIconColor,
    this.bgColorColor = AppColors.whiteColor,
    this.prefixIconColor,
    this.textInputAction = TextInputAction.next,
    this.isSuffixIconShow = true,
    this.displyFontSize,
    this.onChanged,
    this.onFieldSubmitted,
    this.errorText,
    this.contentPadding,
    this.focusNode,
    this.focusNode2,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.suffixIconPadding,
    this.hintTextSize,
    this.hintTextColor,
    this.displayColor,
    this.onEditComplete,
    this.prefixText,
    this.suffixText,
    this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (displayText != null) ...[
          CustomText(
            text: displayText!,
            fontWeight: FontWeight.w600,
            fontSize: 15.5.sp,
            color: displayColor,
          ),
          GapH(0.5.h),
        ],
        SizedBox(
          height: height,
          child: TextFormField(
            textInputAction: textInputAction ?? TextInputAction.next,
            focusNode: focusNode,
            enableSuggestions: false,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            controller: controller,
            cursorColor: cursorColor ?? AppColors.appColor,

            style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              fontSize: 16.sp,
              color: textColor ?? AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            inputFormatters:
                keyboardType == TextInputType.phone
                    ? [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ]
                    : inputFormatters,
            onTap: onTap,
            maxLines: maxLines,
            maxLength: maxLength,
            validator: validator,
            obscureText: obscureText,
            readOnly: readOnly,
            // obscuringCharacter: '.',
            decoration: InputDecoration(
              suffixText: suffixText,
              suffixStyle: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: 16.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
              counterText: '',
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: borderRadius ?? BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: borderRadius ?? BorderRadius.circular(12),
              ),
              prefixText: prefixText,
              prefixStyle: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: 16.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: bgColorColor,
              isDense: true,
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
              counterStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: AppColors.blackColor,
                fontFamily: AppStrings.fontFamily,
              ),
              suffixIcon:
                  suffixIcon != null
                      ? GestureDetector(
                        onTap: () {
                          if (suffixIconOnTap != null) {
                            // FocusScope.of(context).requestFocus(FocusNode());
                            suffixIconOnTap!();
                          }
                        },

                        child: Padding(
                          padding: EdgeInsets.all(suffixIconPadding ?? 15),
                          child: CustomAssetImage(
                            image: suffixIcon!,
                            height: 6,
                            width: 6,
                            color: suffixIconcolor ?? AppColors.darkGreyColor,
                          ),
                        ),
                      )
                      : null,
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: AppStrings.fontFamily,
                color: hintTextColor ?? AppColors.darkGreyColor,
                fontWeight: FontWeight.w400,
                fontSize: hintTextSize ?? 15.sp,
              ),
              prefixIcon:
                  prefix ??
                  (prefixIcon != null
                      ? Padding(
                        padding: EdgeInsets.all(suffixIconPadding ?? 14),
                        child: CustomAssetImage(
                          image: prefixIcon!,
                          height: 5,
                          width: 5,
                          color: prefixIconColor,
                        ),
                      )
                      : null),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.borderColor,
                  width: 1.3,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(10),
              ),
              errorStyle: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: 15.sp,
                color: Colors.red,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.borderColor,
                  width: 1.3,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.borderColor,
                  width: 1.3,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(10),
              ),
              errorText: errorText,
              errorMaxLines: 3,
            ),
          ),
        ),
      ],
    );
  }
}
