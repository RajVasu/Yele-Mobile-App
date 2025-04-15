import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_divider.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/booked%20test%20drives/controller/booked_test_drives_controller.dart';

enum MoreOptions { changeLocation, reschedule, cancel }

class BookedTestDrivesScreen extends StatefulWidget {
  const BookedTestDrivesScreen({super.key});

  @override
  State<BookedTestDrivesScreen> createState() => BookedTestDrivesScreenState();
}

class BookedTestDrivesScreenState extends State<BookedTestDrivesScreen> {
  BookedTestDrivesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'Booked Test Drives'),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return bookedTestDriveWidget();
        },
        separatorBuilder: (context, index) {
          return GapH(1.h);
        },
      ),
    );
  }

  Widget bookedTestDriveWidget() {
    Rx<MoreOptions> selectedOption = MoreOptions.changeLocation.obs;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.dividerColor, width: 1.8),
      ),

      child: Column(
        children: [
          GapH(1.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Maruti Suzuki Swift',
                fontSize: 17.5.sp,
                fontWeight: FontWeight.w600,
              ),

              PopupMenuButton<MoreOptions>(
                onSelected: (MoreOptions item) => selectedOption.value = item,
                itemBuilder:
                    (BuildContext context) => <PopupMenuEntry<MoreOptions>>[
                      const PopupMenuItem<MoreOptions>(
                        value: MoreOptions.changeLocation,
                        child: CustomText(text: 'Change Location'),
                      ),
                      PopupMenuItem<MoreOptions>(
                        value: MoreOptions.reschedule,
                        child: CustomText(text: 'Reschedule'),
                        onTap: () {
                          showRescheduleDialog();
                        },
                      ),
                      PopupMenuItem<MoreOptions>(
                        value: MoreOptions.cancel,
                        child: CustomText(text: 'Cancel'),
                        onTap: () {
                          showCustomDialog(
                            message:
                                'Are you sure you want to cancel this ride?',
                            icon: Assets.assetsImagesCross,
                            title: 'Cancel',
                          );
                        },
                      ),
                    ],

                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.dividerColor),
                  ),

                  child: CustomAssetImage(
                    image: Assets.assetsIconsMoreOptions,
                    height: 2.h,
                    width: 2.h,
                  ),
                ),
              ),
            ],
          ),

          GapH(0.8.h),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: CustomAssetImage(image: Assets.assetsImagesCar),
          ),

          GapH(1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: '\$10.20',
                color: AppColors.appColor,
                fontWeight: FontWeight.bold,
              ),

              CustomButton(
                text: 'CANCEL',
                buttonColor: AppColors.deepRedColor.withAlpha(25),
                textColor: AppColors.deepRedColor,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                borderRadius: BorderRadius.circular(25),
                borderColor: AppColors.deepRedColor.withAlpha(51),
                borderWidth: 1.5,
                fontSize: 14.5.sp,
              ),
            ],
          ),

          GapH(1.5.h),
          detailWidget(
            title: 'Customer',
            subTitle: 'Emely Cooper',
            icon: Assets.assetsIconsProfile,
          ),
          detailWidget(
            title: 'Destination',
            subTitle: '25 Irving BLV, Springfield',
            icon: Assets.assetsIconsDestination,
          ),
          detailWidget(
            title: 'Distance',
            subTitle: '12 Miles',
            icon: Assets.assetsIconsDistance2,
          ),
          detailWidget(
            title: 'Arrival Time',
            subTitle: '15/05/2025 12:15 PM',
            icon: Assets.assetsIconsTime,
          ),

          GapH(1.h),
        ],
      ),
    );
  }

  void showRescheduleDialog() {
    Get.dialog(
      barrierDismissible: false,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.8.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),

                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Center(
                            child: CustomText(
                              text: 'Reschedule',
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                            ),
                          ),

                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.dividerColor,
                                  border: Border.all(
                                    color: AppColors.offWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: CustomAssetImage(
                                  image: Assets.assetsImagesCross,
                                  color: AppColors.blackColor,
                                  height: 0.9.h,
                                  width: 0.9.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GapH(1.h),
                  CustomDivider(),
                  GapH(0.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        CustomTextfield(
                          readOnly: true,
                          controller: controller.dateController,
                          suffixIcon: Assets.assetsIconsDatePicker,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            /*    controller.dateController.text =
                                (await customDatePicker(
                                  context: context,
                                  text: controller.dateController.text,
                                ))?.toFormatedString() ??
                                ''; */
                          },
                          hintText: '10-04-2025',
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailWidget({
    required String title,
    required String subTitle,
    required String icon,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGreyColor,
              ),
              child: CustomAssetImage(
                image: icon,
                height: 2.2.h,
                width: 2.2.h,
                color: AppColors.darkGreyColor,
              ),
            ),

            GapW(2.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.darkGreyColor,
                  fontSize: 15.5.sp,
                ),

                CustomText(
                  text: subTitle,
                  fontSize: 16.2.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),

        GapH(1.5.h),
      ],
    );
  }
}
