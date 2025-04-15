import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class PermissionDailog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? children;
  final EdgeInsets? contentPadding;
  final double? height;
  final bool isShowClosebutton;

  const PermissionDailog({
    super.key,
    this.children,
    required this.title,
    required this.message,
    this.contentPadding,
    this.height,
    this.isShowClosebutton = true,
  });

  @override
  Widget build(BuildContext context) {
    double borderRadius = 20;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GapH(2.h),
          CustomText(
            text: title,
            textAlign: TextAlign.center,
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
          GapH(1.2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: CustomText(
              text: message,
              textAlign: TextAlign.center,
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          GapH(2.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    fontSize: 15.sp,
                    text: 'Cancel',
                    buttonColor: AppColors.appColor,
                    textColor: AppColors.whiteColor,

                    onTap: () => Get.back(),
                    // radius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(borderRadius),
                    // ),
                  ),
                ),
                GapW(2.w),
                Expanded(
                  child: CustomButton(
                    text: 'Go to Settings',
                    fontSize: 15.sp,
                    onTap: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
