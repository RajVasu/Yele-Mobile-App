import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
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
import 'package:yele/src/features/user/book_test_drive_screen/components/other_details.dart';
import 'package:yele/src/features/user/booked_test_drives/controller/booked_test_drives_controller.dart';

enum MoreOptions { changeLocation, reschedule, cancel }

class BookedTestDrivesScreen extends StatefulWidget {
  const BookedTestDrivesScreen({super.key});

  @override
  State<BookedTestDrivesScreen> createState() => BookedTestDrivesScreenState();
}

class BookedTestDrivesScreenState extends State<BookedTestDrivesScreen> {
  BookedTestDrivesController controller = Get.find();

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    controller.dateController.text = formattedDate;
  }

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
                      PopupMenuItem<MoreOptions>(
                        value: MoreOptions.changeLocation,
                        child: CustomText(text: 'Change Location'),
                        onTap: () {
                          showChangeLocationDialog();
                        },
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

  void showChangeLocationDialog({
    void Function()? onCancelBtnTap,
    void Function()? onSaveBtnTap,
  }) {
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
                              text: 'Change Location',
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
                          prefixIcon: Assets.assetsIconsSelectLocation,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          hintText: 'Select Location',
                        ),

                        GapH(2.h),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 0.2.h,
                                color: AppColors.dividerColor,
                              ),
                            ),

                            GapW(2.w),
                            CustomText(
                              text: 'Enter Manually',
                              fontSize: 15.5.sp,
                            ),
                            GapW(2.w),

                            Expanded(
                              child: Container(
                                height: 0.2.h,

                                color: AppColors.dividerColor,
                              ),
                            ),
                          ],
                        ),

                        GapH(2.h),

                        CustomTextfield(
                          displayText: 'Address',
                          hintText: 'Enter Address',
                        ),

                        GapH(1.5.h),

                        CustomTextfield(
                          displayText: 'State',
                          hintText: 'Select State',
                        ),
                        GapH(1.5.h),

                        CustomTextfield(
                          displayText: 'City',
                          hintText: 'Select City',
                        ),
                        GapH(1.5.h),

                        CustomTextfield(
                          displayText: 'Zip Code',
                          hintText: 'Enter Zip Code',
                        ),

                        GapH(2.5.h),

                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onTap: onCancelBtnTap,
                                text: 'Cancel',
                                borderColor: AppColors.appColor,
                                buttonColor: AppColors.whiteColor,
                                textColor: AppColors.appColor,
                                borderWidth: 1.2,
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                              ),
                            ),
                            GapW(3.w),
                            Expanded(
                              child: CustomButton(
                                onTap: onSaveBtnTap,
                                text: 'Save',
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                              ),
                            ),
                          ],
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
                          hintText: '10-04-2025',
                        ),

                        GapH(0.5.h),
                        dateCalendar(),
                        OtherDetails(isBorder: true),
                        GapH(1.5.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Cancel',
                                borderColor: AppColors.appColor,
                                buttonColor: AppColors.whiteColor,
                                textColor: AppColors.appColor,
                                borderWidth: 1.2,
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                              ),
                            ),
                            GapW(3.w),
                            Expanded(
                              child: CustomButton(
                                // onTap:
                                //     () =>
                                //         Get.offNamed(Routes.confirmationScreen),
                                text: 'Save',
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                              ),
                            ),
                          ],
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

  Widget dateCalendar() {
    return Obx(
      () => TableCalendar(
        formatAnimationDuration: Duration(seconds: 1),
        firstDay: controller.firstDay,
        lastDay: controller.lastDay,
        focusedDay: controller.focusedDay.value,
        selectedDayPredicate: (day) {
          return isSameDay(controller.selectedDay.value, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          controller.selectedDay.value = selectedDay;
          String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDay);
          controller.dateController.text = formattedDate;
        },

        onPageChanged: (focusedDay) {
          controller.focusedDay.value = focusedDay;
        },

        daysOfWeekHeight: 2.5.h,

        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final text = DateFormat.E().format(day);
            return Center(
              child: CustomText(
                fontSize: 15.2.sp,
                text: text.toUpperCase(),
                color: AppColors.midGreyColor,
              ),
            );
          },
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(
            color: AppColors.appColor,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color:
                controller.selectedDay.value.day ==
                        controller.focusedDay.value.day
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          defaultTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          disabledTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.midGreyColor,
          ),
          weekendTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          selectedTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
          outsideTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.midGreyColor,
          ),
        ),

        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w600,
          ),

          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: CustomAssetImage(
            image: Assets.assetsIconsBackIcon,
            height: 2.h,
            width: 2.h,
            color: AppColors.vividBlueColor,
          ),
          rightChevronIcon: CustomAssetImage(
            image: Assets.assetsIconsNext,
            height: 2.h,
            width: 2.h,
            color: AppColors.vividBlueColor,
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



/* import 'dart:ui';

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
import 'package:yele/src/features/user/booked_test_drives/controller/booked_test_drives_controller.dart';

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
 */