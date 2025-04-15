import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart';

class HomeBannerWidget extends StatefulWidget {
  const HomeBannerWidget({super.key});

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget> {
  final DashboardController _dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 23.h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.0,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        BannerWidget(
          image: Assets.assetsImagesNewCar,
          type: 'new car',
          onTap: () => _dashboardController.selectedIndex.value = 1,
        ),
        BannerWidget(
          image: Assets.assetsImagesUsedCar,
          type: 'used car',
          onTap: () => _dashboardController.selectedIndex.value = 2,
        ),
      ],
    );
  }
}

class BannerWidget extends StatelessWidget {
  String image;
  String type;
  void Function()? onTap;
  BannerWidget({
    super.key,
    required this.image,
    required this.type,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Looking for a $type?',
            color: AppColors.whiteColor,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
          CustomText(
            text: 'Let us handle the hassle so you\ncan enjoy the ride!',
            fontSize: 14.sp,
            color: AppColors.whiteColor,
          ),
          GapH(3.h),
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                10.sp,
              ), // Ensure the clip is consistent
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ), // Apply the blur filter
                child: Container(
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: AppColors.blackColor.withOpacity(
                      0.3,
                    ), // Adjust background color with opacity
                    border: Border.all(
                      color: AppColors.whiteColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Explore'.toUpperCase(),
                        color: AppColors.whiteColor,
                      ),
                      GapW(2.w),
                      CustomAssetImage(
                        image: Assets.assetsIconsBannerArrow,
                        width: 8.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
