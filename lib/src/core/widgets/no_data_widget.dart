import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            GapH(18.h),
            CustomAssetImage(
              image: Assets.assetsImagesNoDataFound,
              width: 18.h,
            ),
            GapH(2.h),
            CustomText(
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              fontSize: 18.sp,
              text: 'No data available for the selected criteria.',
            ),
            GapH(0.3.h),
            CustomText(
              textAlign: TextAlign.center,
              color: AppColors.darkGreyColor,
              fontSize: 15.sp,
              text: 'Adjust your filters to broaden the search.',
            ),
          ],
        ),
      ),
    );
  }
}
