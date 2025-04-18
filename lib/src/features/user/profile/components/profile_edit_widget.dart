import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart'
    show DashboardController;
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class ProfileEditWidget extends StatefulWidget {
  const ProfileEditWidget({super.key});

  @override
  State<ProfileEditWidget> createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {
  final ProfileController _profileController = Get.find();
  DashboardController dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.5.h,
      color: AppColors.whiteColor,
      child: Stack(
        children: [
          Container(
            height: 20.h,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.sp),
                bottomRight: Radius.circular(20.sp),
              ),
            ),
            child: customAppBar(
              title: 'My Account',
              actionWidget: Container(
                padding: EdgeInsets.all(13.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: GestureDetector(
                  onTap: () => _onLogoutTap(context),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsLogout,
                    height: 2.h,
                    width: 2.h,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),

              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15.sp),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7.sp),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Obx(
                          () => CircleAvatar(
                            radius: 23.sp,
                            backgroundColor: AppColors.appColor,
                            backgroundImage:
                                _profileController.selectedImage.value == null
                                    ? (_profileController
                                                .userData
                                                .value
                                                .profileImage !=
                                            null
                                        ? NetworkImage(
                                          '${Endpoints.baseUrl}${_profileController.userData.value.profileImage!}',
                                        )
                                        : AssetImage(
                                          Assets.assetsImagesUserImage,
                                        ))
                                    : FileImage(
                                      _profileController.selectedImage.value!,
                                    ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _profileController.showBottomSheet(
                              context,
                              type: AppStrings.userImage,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(13.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.appColor,
                              border: Border.all(
                                color: AppColors.whiteColor,
                                width: 1.5,
                              ),
                              image: DecorationImage(
                                image: AssetImage(Assets.assetsIconsEditImage),
                                scale: 4.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GapW(2.w),
                  CustomText(
                    text:
                        '${_profileController.userData.value.firstName} ${_profileController.userData.value.lastName}',
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLogoutTap(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
    // dashboardController.selectedIndex.value = 0;
    await _profileController.logOut();
  }
}
