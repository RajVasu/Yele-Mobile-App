import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/widgets/countries_picker.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class ProfileInfoWidget extends StatefulWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileInfoWidget({super.key, required this.formKey});

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Profile Info',
            fontWeight: FontWeight.w700,
            fontSize: 17.sp,
          ),
          GapH(2.h),
          CustomTextfield(
            displayText: AppStrings.firstName,
            hintText: AppStrings.enterFirstName,
            displayColor: AppColors.greyColor,
            controller: _profileController.fNameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterFirstName;
              }
              if (value.trim().length < 3) {
                return AppStrings.firstNameMustBe;
              }
              return null;
            },
          ),
          GapH(1.h),
          CustomTextfield(
            displayText: AppStrings.lastName,
            hintText: AppStrings.enterLastName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,

            displayColor: AppColors.greyColor,
            controller: _profileController.lNameController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterLasttName;
              }
              if (value.trim().length < 3) {
                return AppStrings.lastNameMustBe;
              }
              return null;
            },
          ),
          GapH(1.h),
          CustomTextfield(
            displayText: AppStrings.phoneNo,
            hintText: AppStrings.enterPhoneNo,
            displayColor: AppColors.greyColor,
            controller: _profileController.phNoController,
            // controller: registerController.phnoController,
            textInputAction: TextInputAction.next,
            prefix: CountriesPicker(
              phonrNumber: _profileController.phNoController.text,
              countryCode: _profileController.countryCode,
              flag: _profileController.flag,
              numberLenght: _profileController.numberLenght,
            ),
            keyboardType: TextInputType.numberWithOptions(),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterPhoneNo;
              }
              if (_profileController.numberLenght.value !=
                  _profileController.phNoController.text
                      .split(" ")
                      .last
                      .length
                      .toString()) {
                return 'Please enter valid phone number';
              }
              return null;
            },
          ),
          GapH(1.h),
          CustomTextfield(
            displayText: AppStrings.address,
            hintText: AppStrings.enterAddress,
            controller: _profileController.addController,
            displayColor: AppColors.greyColor,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterAddress;
              }

              return null;
            },
          ),
          GapH(1.h),
          CustomTextfield(
            displayColor: AppColors.greyColor,
            displayText: AppStrings.uploadLicense,
            hintText: AppStrings.attachDriverLicense,
            controller: _profileController.licenseController,
            readOnly: true,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseAttachDriverLicense;
              }

              return null;
            },

            suffixIcon: Assets.assetsIconsEditDoc,
            suffixIconcolor: AppColors.appColor,
            onTap: () {
              _profileController.showBottomSheet(
                context,
                type: AppStrings.userLicenseType,
              );
            },
          ),
          if (_profileController.userData.value.guardianName! != "") ...[
            GapH(1.h),
            CustomTextfield(
              displayColor: AppColors.greyColor,
              displayText: AppStrings.guardianName,
              hintText: AppStrings.enterGuardianName,
              controller: _profileController.gNameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ),
            GapH(1.h),
            CustomTextfield(
              displayColor: AppColors.greyColor,
              displayText: AppStrings.guardianLicense,
              hintText: AppStrings.attachGuardianLicense,
              controller: _profileController.gLicenseController,
              readOnly: true,
              suffixIcon: Assets.assetsIconsEditDoc,
              suffixIconcolor: AppColors.appColor,
              onTap: () {
                _profileController.showBottomSheet(
                  context,
                  type: AppStrings.gLicenseType,
                );
              },
            ),
          ],

          GapH(2.h),
          Obx(
            () => CustomButton(
              text: 'Save Details',
              isLoading: _profileController.formzStatus.value.isLoading,
              onTap: () => _onSaveDetailTap(context),
            ),
          ),
          GapH(2.h),
        ],
      ),
    );
  }

  void _onSaveDetailTap(BuildContext context) {
    if (!widget.formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    _profileController.editProfile();
  }
}
