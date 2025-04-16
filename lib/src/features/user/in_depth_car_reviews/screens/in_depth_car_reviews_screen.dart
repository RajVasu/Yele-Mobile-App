import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class InDepthCarReviewsScreen extends StatefulWidget {
  const InDepthCarReviewsScreen({super.key});

  @override
  State<InDepthCarReviewsScreen> createState() =>
      _InDepthCarReviewsScreenState();
}

class _InDepthCarReviewsScreenState extends State<InDepthCarReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'In Depth Car Reviews'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Skoda Kylaq Review: Driver’s Delight',
            fontWeight: FontWeight.bold,
          ),
          GapH(0.5.h),
          CustomText(
            text: 'Published date: 13 Mar, 2025',
            fontWeight: FontWeight.w600,
            fontSize: 14.5.sp,
            color: AppColors.darkGreyColor,
          ),

          GapH(1.5.h),
          CustomAssetImage(image: Assets.assetsImagesCar),

          GapH(1.5.h)
        ],
      ),
    );
  }
}
