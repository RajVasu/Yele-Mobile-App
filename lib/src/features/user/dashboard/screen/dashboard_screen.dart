import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart';
import 'package:yele/src/features/user/home/screen/home_screen.dart';
import 'package:yele/src/features/user/new_car/screen/new_car_screen.dart';
import 'package:yele/src/features/user/profile/screen/profile_screen.dart';
import 'package:yele/src/features/user/used_car/screen/used_car_screen.dart';

class BottomItem {
  final String icon;
  final String label;
  final Widget screen;
  BottomItem({required this.icon, required this.label, required this.screen});
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.find();

  final List<BottomItem> items = [
    BottomItem(
      label: 'Home',
      icon: Assets.assetsIconsHome,
      screen: HomeScreen(),
    ),
    BottomItem(
      label: 'New Car',
      icon: Assets.assetsIconsNewCar,
      screen: NewCarScreen(),
    ),
    BottomItem(
      label: 'Used Car',
      icon: Assets.assetsIconsUsedCar,
      screen: UsedCarScreen(),
      
    ),
    BottomItem(
      label: 'Profile',
      icon: Assets.assetsIconsProfile,
      screen: ProfileScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: items[dashboardController.selectedIndex.value].screen,
        bottomNavigationBar: DashboardBottomBar(
          bottomList: items,
          selectedIndex: dashboardController.selectedIndex.value,
          onItemTapped: (index) =>
              dashboardController.selectedIndex.value = index,
        ),
      ),
    );
  }
}

class DashboardBottomBar extends StatelessWidget {
  final List<BottomItem> bottomList;
  final int selectedIndex;
  final void Function(int index) onItemTapped;
  const DashboardBottomBar({
    super.key,
    required this.bottomList,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final double height = 8.h;
    // final double imageHeight = 26;

    return Container(
      padding: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withAlpha(20),
            blurRadius: 20,
            offset: Offset(0, -2),
            spreadRadius: 10,
          ),
        ],
      ),
      child: Container(
        height: height,
        // color: const Color.fromARGB(255, 63, 245, 72),
        // padding: EdgeInsets.symmetric(horizontal: 3.w),
        padding: EdgeInsets.only(top: 0.5.h, left: 3.w, right: 3.w),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < bottomList.length; i++) ...[
              Expanded(
                child: InkWell(
                  splashColor: AppColors.transparentColor,
                  highlightColor: AppColors.transparentColor,
                  onTap: () => onItemTapped(i),
                  child: Column(
                    children: [
                      GapH(1.5.h),
                      Image.asset(
                        bottomList[i].icon,
                        color: selectedIndex == i ? AppColors.appColor : null,
                        height: 20,
                      ),
                      GapH(0.6.h),
                      CustomText(
                        text: bottomList[i].label,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: selectedIndex == i
                            ? AppColors.appColor
                            : AppColors.darkGreyColor,
                      ),
                    ],
                  ),
                ),
              ),
              if (i != bottomList.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: VerticalDivider(
                    color: AppColors.dividerColor,
                    thickness: 2,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
