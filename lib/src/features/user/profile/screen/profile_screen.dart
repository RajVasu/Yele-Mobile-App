import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart';
import 'package:yele/src/features/user/profile/components/profile_item_widget.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: ProfileView());
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  DashboardController dashboardController = Get.find();
  final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'Profile', isBack: false),
      body: Column(
        children: [
          ProfileItemWidget(
            title: 'My Account',
            onTap: () async {
              if (Storage.instance.getToken() != null) {
                await _profileController.getCurrentUserData();
                await Get.toNamed(Routes.myAccountScreen);
              } else {
                Get.toNamed(Routes.loginScreen);
              }
            },
          ),
            ProfileItemWidget(
            title: 'Saved Search',
            onTap: () {
              if (Storage.instance.getToken() != null) {
                Get.toNamed(Routes.savedSearchScreen);
              } else {
                Get.toNamed(Routes.loginScreen);
              }
            },
          ),
          ProfileItemWidget(
            title: 'Favorite Cars',
            onTap: () {
              if (Storage.instance.getToken() != null) {
                Get.toNamed(Routes.favoriteCarsScreen);
              } else {
                Get.toNamed(Routes.loginScreen);
              }
            },
          ),
          ProfileItemWidget(
            title: 'Booked Test Drives',
            onTap: () {
              if (Storage.instance.getToken() != null) {
                Get.toNamed(Routes.bookedTestDrivesScreen);
              } else {
                Get.toNamed(Routes.loginScreen);
              }
            },
          ),
          if (Storage.instance.getToken() != null) ...[
            ProfileItemWidget(
              title: 'Delete Account',
              isViewDivider: false,
              onTap:
                  () => showCustomDialog(
                    message: 'Are you sure you want to delete this account?',
                    icon: Assets.assetsIconsDeleteAcc,
                    onNoBtnTap: () => Get.back(),
                    onYesBtnTap: () async {
                      Get.back();
                      await _profileController.deleteAccount();
                      await Storage.instance.clear();
                      dashboardController.selectedIndex.value = 0;
                    },
                  ),
              textColor: AppColors.redColor,
            ),
            Spacer(),
            CustomButton(
              text: 'Logout',
              onTap: () async {
                await _profileController.logOut();
                dashboardController.selectedIndex.value = 0;
              },
            ),
          ],
        ],
      ),
    );
  }

  void showCustomDialog({
    String? title,
    required String message,
    required String icon,
    void Function()? onNoBtnTap,
    void Function()? onYesBtnTap,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.close,
                    color: AppColors.greyColor,
                    size: 22.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(45),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightPinkColor,
                ),

                child: CustomAssetImage(image: icon, height: 5.5.h, width: 5.5.h),
              ),

              GapH(2.h),
              if (title != null && title.isNotEmpty) ...[
                CustomText(
                  text: title,
                  fontSize: 17.5.sp,
                  fontWeight: FontWeight.w700,
                ),
                GapH(1.h),
              ],

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CustomText(
                  fontSize: 17.3.sp,
                  textAlign: TextAlign.center,
                  text: message,
                ),
              ),

              GapH(3.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: onNoBtnTap,
                      text: 'No',
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
                      onTap: onYesBtnTap,
                      text: 'Yes',
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
