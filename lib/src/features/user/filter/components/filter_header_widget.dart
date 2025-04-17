import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';

class FilterHeaderWidget extends StatelessWidget {
  String label;
  bool Function() onTap;
  bool isShown;
  FilterHeaderWidget({
    super.key,
    required this.isShown,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: label, fontWeight: FontWeight.w700),
            CustomAssetImage(
              image:
                  isShown
                      ? Assets.assetsIconsDropup
                      : Assets.assetsIconsDropdown,
              color: AppColors.appColor,
              width: 1.5.h,
              height: 1.5.h,
            ),
          ],
        ),
      ),
    );
  }
}
