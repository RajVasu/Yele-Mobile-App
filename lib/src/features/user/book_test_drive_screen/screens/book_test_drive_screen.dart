import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/book_test_drive_screen/components/date_calendar.dart';
import 'package:yele/src/features/user/book_test_drive_screen/components/other_details.dart';

class BookTestDriveScreen extends StatefulWidget {
  const BookTestDriveScreen({super.key});

  @override
  State<BookTestDriveScreen> createState() => _BookTestDriveScreenState();
}

class _BookTestDriveScreenState extends State<BookTestDriveScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'Book Test Drive'),

      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.lightBlueColor,
                  ),
                  child: Column(
                    children: [
                      DateCalendar(),
                      GapH(1.h),
                      OtherDetails(),
                      GapH(2.h),
                    ],
                  ),
                ),
              ],
            ),
          ),

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
                  onTap: () => Get.offNamed(Routes.confirmationScreen),

                  text: 'Book',
                  borderRadius: BorderRadius.circular(10),
                  padding: EdgeInsets.symmetric(vertical: 1.2.h),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
