import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/services/network_service.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class NoInternetScreen extends StatefulWidget {
  final Widget child;

  const NoInternetScreen({super.key, required this.child});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: NetworkService.instance.internetStream,
      initialData: NetworkService.instance.isInternet,
      builder: (context, snapshot) {
        final isInternet = snapshot.data ?? NetworkService.instance.isInternet;

        if (!isInternet) {
          return CustomBgWidget(
            appBar: customAppBar(isBack: false, title: ''),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAssetImage(image: Assets.assetsImagesNoInternet, height: 60.w),
                GapH(2.h),
                CustomText(
                  text: 'No Internet :(',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
                GapH(2.h),
                CustomText(
                  text:
                      'Please check your internet\nconnection, you are offline now.',
                  textAlign: TextAlign.center,
                  color: AppColors.darkGreyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ],
            ),
          );
        }
        return widget.child;
      },
    );
  }
}
