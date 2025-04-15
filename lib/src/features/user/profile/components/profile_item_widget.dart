import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';

class ProfileItemWidget extends StatelessWidget {
  bool? isViewDivider = true;
  String title;
  Color? textColor;
  void Function()? onTap;
  ProfileItemWidget({
    super.key,
    this.isViewDivider = true,
    this.onTap,
    this.textColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Row(
              children: [
                CustomText(
                  text: title,
                  fontSize: 17.5.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? AppColors.blackColor,
                ),
                Spacer(),
                if (isViewDivider == true)
                  CustomAssetImage(
                    image: Assets.assetsIconsNext,
                    height: 2.h,
                    width: 2.h,
                  ),
              ],
            ),
          ),
          if (isViewDivider == true) ...[
            Divider(color: AppColors.dividerColor, thickness: 1.5, height: 4.h),
          ],
        ],
      ),
    );
  }
}
