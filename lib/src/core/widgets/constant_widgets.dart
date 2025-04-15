import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

///
/// Snackbar for showing error message
///
errorSnackBar({String? title, String? message, int seconds = 3}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Error',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      // backgroundColor: Colors.red.withOpacity(0.80),
      backgroundColor: AppColors.errorSnackColor,
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: seconds),
    ),
  );
}

///
/// Snackbar for showing success message
///
successSnackBar({String? title, String? message, Duration? duration}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Success',
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.suscessSnackColor,
      icon: const Icon(
        Icons.task_alt_outlined,
        size: 30.0,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: duration ?? const Duration(seconds: 3),
    ),
  );
}

informationSnackBar({
  String? title,
  String? message,
  IconData? icon,
  int duration = 3,
}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      title: title,
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.infoSnackColor.withOpacity(
        icon == null ? 0.8 : 1,
      ),
      icon: icon != null ? Icon(icon, size: 25.0, color: Colors.white) : null,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
    ),
  );
}




void showCustomDialog({
  String? title,
  required String message,
  required String icon,
  void Function()? onNoBtnTap,
  void Function()? onYesBtnTap,
  bool isCloseButton = false,
}) {
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCloseButton) ...[
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.close,
                      color: AppColors.greyColor,
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
              Container(
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightPinkColor,
                ),

                child: CustomAssetImage(image: icon, height: 5.h, width: 5.h),
              ),

              GapH(2.h),
              if (title != null && title.isNotEmpty) ...[
                CustomText(
                  text: title,
                  fontSize: 17.5.sp,
                  fontWeight: FontWeight.w700,
                ),
                GapH(1.h),
              ],

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CustomText(
                  fontSize: 16.5.sp,
                  textAlign: TextAlign.center,
                  text: message,
                ),
              ),

              GapH(3.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: onNoBtnTap,
                      text: 'No',
                      borderColor: AppColors.appColor,
                      buttonColor: AppColors.whiteColor,
                      textColor: AppColors.appColor,
                      borderWidth: 1.2,
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                    ),
                  ),
                  GapW(3.w),
                  Expanded(
                    child: CustomButton(
                      onTap: onYesBtnTap,
                      text: 'Yes',
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
