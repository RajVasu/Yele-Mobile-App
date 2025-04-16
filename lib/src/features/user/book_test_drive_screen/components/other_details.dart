import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class OtherDetails extends StatelessWidget {
  final bool isBorder;
  const OtherDetails({super.key, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppColors.blueIceColor,
          ),

          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  shape: BoxShape.circle,
                ),
                child: CustomAssetImage(
                  image: Assets.assetsIconsCheckmark,
                  height: 1.h,
                  width: 1.h,
                ),
              ),
              GapW(2.w),
              Expanded(
                child: CustomText(
                  fontSize: 14.7.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appColor,
                  text: 'Selected Date Is Available For Schedule',
                ),
              ),
            ],
          ),
        ),
        GapH(1.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Select Time Between 09:00 to 18:50',
                fontSize: 15.2.sp,
              ),
              GapH(1.h),
              Row(
                children: [
                  timeBox('9:00'),
                  GapW(5.w),
                  const CustomText(text: 'to', fontWeight: FontWeight.w400),
                  GapW(5.w),
                  timeBox('11:00'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget timeBox(String time) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isBorder ? AppColors.dividerColor : AppColors.transparentColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              textAlign: TextAlign.center,
              text: time,
              fontWeight: FontWeight.w400,
            ),

            CustomAssetImage(
              color: AppColors.blackColor,
              image: Assets.assetsIconsClockBorder,
              height: 2.h,
              width: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
