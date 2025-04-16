import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/features/user/book_test_drive_screen/controller/book_test_drive_controller.dart';

class DateCalendar extends StatefulWidget {
  const DateCalendar({super.key});

  @override
  State<DateCalendar> createState() => _DateCalendarState();
}

class _DateCalendarState extends State<DateCalendar> {
  BookTestDriveController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
}
