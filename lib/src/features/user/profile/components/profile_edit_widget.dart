import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class ProfileEditWidget extends StatefulWidget {
  const ProfileEditWidget({super.key});

  @override
  State<ProfileEditWidget> createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {
  final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.h,
      left: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),

        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15.sp),
          boxShadow: [BoxShadow(color: AppColors.borderColor, blurRadius: 1)],
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
                                  : AssetImage(Assets.assetsImagesUserImage))
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
    );
  }
}
