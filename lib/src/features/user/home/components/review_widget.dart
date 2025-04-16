import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.inDepthCarReviewsScreen),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.5.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.appColor.withOpacity(0.2),
              AppColors.appColor.withOpacity(0.1),
              AppColors.appColor.withOpacity(0.1),
              AppColors.appColor.withOpacity(0.02),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                children: [
                  CustomText(text: 'In Depth Car Reviews'),
                  Spacer(),
                  CustomText(
                    text: 'View All',
                    fontSize: 15.sp,
                    color: AppColors.appColor,
                  ),
                  CustomAssetImage(
                    image: Assets.assetsIconsNext,
                    color: AppColors.appColor,
                    height: 2.h,
                    width: 2.h,
                  ),
                ],
              ),
            ),
            GapH(15),
            SizedBox(
              height: 31.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 60.w, // Ensure this width is appropriate
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize
                              .min, // Ensure it takes the minimum space needed
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: CustomAssetImage(
                            image: Assets.assetsImagesNewCar,
                            height: 15.h,
                            width:
                                double
                                    .infinity, // Use the full width of the container
                            fit: BoxFit.cover,
                          ),
                        ),
                        GapH(15),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomText(
                                text: 'Skoda Kylaq Review: Driver’s Delight',
                                fontSize: 15.sp,
                                color: AppColors.blackColor,
                              ),
                              Divider(endIndent: 10, indent: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjRkfdV2CW7Sg2sT7e3zRmUyUUIOh5IW0bw&s',
                                    ),
                                  ),
                                  GapW(10),
                                  CustomText(
                                    text: 'Emely Cooper',
                                    fontSize: 15.sp,
                                    color: AppColors.darkGreyColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => GapW(2.w),
              ),
            ),
            GapH(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () {
                    if (_scrollController.hasClients) {
                      double position = _scrollController.position.pixels;
                      // Scroll back by a certain width
                      _scrollController.animateTo(
                        position - (60.w), // Adjust the scroll width
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.appColor),
                    ),
                    child: CustomAssetImage(
                      image: Assets.assetsIconsBackIcon,
                      height: 2.h,
                      width: 2.h,
                      color: AppColors.appColor,
                    ),
                  ),
                ),
                GapW(2.w),
                // Next Button
                GestureDetector(
                  onTap: () {
                    if (_scrollController.hasClients) {
                      double position = _scrollController.position.pixels;
                      // Scroll forward by a certain width
                      _scrollController.animateTo(
                        position + (60.w), // Adjust the scroll width
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.appColor,
                      border: Border.all(color: AppColors.appColor),
                    ),
                    child: CustomAssetImage(
                      image: Assets.assetsIconsNext,
                      height: 2.h,
                      width: 2.h,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/* import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AppColors.gradient.begin,
          end: AppColors.gradient.end,
          colors: [
            AppColors.gradient.colors[0].withOpacity(0.2),
            AppColors.gradient.colors[0].withOpacity(0.1),
            AppColors.gradient.colors[0].withOpacity(0.1),
            AppColors.gradient.colors[0].withOpacity(0.02),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
              children: [
                CustomText(text: 'In Depth Car Reviews'),
                Spacer(),
                CustomText(
                  text: 'View All',
                  fontSize: 15.sp,
                  color: AppColors.appColor,
                ),
                CustomAssetImage(
                  image: Assets.assetsIconsNext,
                  color: AppColors.appColor,
                  height: 2.h,
                  width: 2.h,
                ),
              ],
            ),
          ),
          GapH(15),
          SizedBox(
            height: 31.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 60.w, // Ensure this width is appropriate
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Ensure it takes the minimum space needed
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.sp),
                        child: CustomAssetImage(
                          image: Assets.assetsImagesNewCar,
                          height: 15.h,
                          width:
                              double
                                  .infinity, // Use the full width of the container
                          fit: BoxFit.cover,
                        ),
                      ),
                      GapH(15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Skoda Kylaq Review: Driver’s Delight',
                              fontSize: 15.sp,
                              color: AppColors.blackColor,
                            ),
                            Divider(endIndent: 10, indent: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjRkfdV2CW7Sg2sT7e3zRmUyUUIOh5IW0bw&s',
                                  ),
                                ),
                                GapW(10),
                                CustomText(
                                  text: 'Emely Cooper',
                                  fontSize: 15.sp,
                                  color: AppColors.darkGreyColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => GapW(2.w),
            ),
          ),
          GapH(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  if (_scrollController.hasClients) {
                    double position = _scrollController.position.pixels;
                    // Scroll back by a certain width
                    _scrollController.animateTo(
                      position - (60.w), // Adjust the scroll width
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.appColor),
                  ),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsBackIcon,
                    height: 2.h,
                    width: 2.h,
                    color: AppColors.appColor,
                  ),
                ),
              ),
              GapW(2.w),
              // Next Button
              GestureDetector(
                onTap: () {
                  if (_scrollController.hasClients) {
                    double position = _scrollController.position.pixels;
                    // Scroll forward by a certain width
                    _scrollController.animateTo(
                      position + (60.w), // Adjust the scroll width
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.appColor,
                    border: Border.all(color: AppColors.appColor),
                  ),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsNext,
                    height: 2.h,
                    width: 2.h,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 */