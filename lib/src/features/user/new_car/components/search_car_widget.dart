import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';

class SearchCarWidget extends StatefulWidget {
  const SearchCarWidget({super.key});

  @override
  State<SearchCarWidget> createState() => _SearchCarWidgetState();
}

class _SearchCarWidgetState extends State<SearchCarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextfield(
            prefixIcon: Assets.assetsIconsSearchCar,
            hintText: 'Search cars...',
            readOnly: true,
            prefixIconColor: AppColors.darkGreyColor,
            borderRadius: BorderRadius.circular(30.sp),
          ),
        ),
        GapW(2.w),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.filterScreen),
          child: Container(
            height: 5.5.h,
            width: 5.5.h,
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderColor, width: 1.4),
            ),
            child: CustomAssetImage(image: Assets.assetsIconsFilter),
          ),
        ),
      ],
    );
  }
}
