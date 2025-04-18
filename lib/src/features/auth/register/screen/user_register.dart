import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/core/widgets/countries_picker.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  RegisterController registerController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    registerController.clearUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextfield(
            displayText: AppStrings.firstName,
            hintText: AppStrings.enterFirstName,
            controller: registerController.fNameController,
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
          GapH(1.5.h),
          CustomTextfield(
            displayText: AppStrings.lastName,
            hintText: AppStrings.enterLastName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: registerController.lNameController,
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
          GapH(1.5.h),
          Obx(
            () => CustomTextfield(
              displayText: AppStrings.driverLicense,
              hintText: AppStrings.attachDriverLicense,
              controller: registerController.driverLicenseController,
              readOnly: true,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return AppStrings.pleaseAttachDriverLicense;
                }

                return null;
              },
              suffixIcon:
                  registerController.driverUserLicenseFile.value == ''
                      ? Assets.assetsIconsAttachPin
                      : Assets.assetsIconsEditDoc,
              suffixIconcolor:
                  registerController.driverUserLicenseFile.value == ''
                      ? AppColors.darkGreyColor
                      : AppColors.appColor,
              onTap: () {
                registerController.showBottomSheet(
                  context,
                  type: AppStrings.userDriverLicenseType,
                );
              },
            ),
          ),
          GapH(1.5.h),
          CustomTextfield(
            displayText: AppStrings.phoneNo,
            hintText: AppStrings.enterPhoneNo,
            controller: registerController.phnoController,

            textInputAction: TextInputAction.next,
            prefix: CountriesPicker(
              phonrNumber: registerController.phnoController.text,
              countryCode: registerController.countryCode,
              flag: registerController.flag,
              numberLenght: registerController.numberLenght,
            ),
            keyboardType: TextInputType.numberWithOptions(),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterPhoneNo;
              }
              if (registerController.numberLenght.value !=
                  registerController.phnoController.text
                      .split(" ")
                      .last
                      .length
                      .toString()) {
                return 'Please enter valid phone number';
              }
              return null;
            },
          ),
          GapH(1.5.h),
          CustomTextfield(
            displayText: AppStrings.email,
            hintText: AppStrings.enterEmail,
            keyboardType: TextInputType.emailAddress,

            textInputAction: TextInputAction.next,
            controller: registerController.emailController,
            validator: (value) => Validator.validateEmail(value!),
          ),
          GapH(1.5.h),
          CustomTextfield(
            displayText: AppStrings.address,
            hintText: AppStrings.enterAddress,
            controller: registerController.addController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterAddress;
              }

              return null;
            },
          ),
          GapH(1.5.h),
          Obx(
            () => CustomTextfield(
              displayText: AppStrings.password,
              hintText: AppStrings.enterPassword,
              controller: registerController.pwdUserController,
              validator: (value) => Validator.validatePassword(value!),
              suffixIconOnTap:
                  () =>
                      registerController.userPasswordVisible.value =
                          !registerController.userPasswordVisible.value,
              suffixIcon:
                  registerController.userPasswordVisible.value
                      ? Assets.assetsIconsInvisible
                      : Assets.assetsIconsVisible,
              obscureText: registerController.userPasswordVisible.value,
            ),
          ),
          GapH(2.h),
          CustomText(
            text: 'If Under 21',
            fontSize: 17.5.sp,
            fontWeight: FontWeight.w700,
          ),
          GapH(2.h),
          CustomTextfield(
            displayText: AppStrings.guardianName,
            hintText: AppStrings.enterGuardianName,
            controller: registerController.gNameController,
            // validator: (value) {
            //   if (value!.trim().isEmpty) {
            //     return AppStrings.pleaseEnterGuardianName;
            //   }
            //   if (value.trim().length < 3) {
            //     return AppStrings.guardianNameMustBe;
            //   }
            //   return null;
            // },
          ),
          GapH(1.5.h),
          Obx(
            () => CustomTextfield(
              displayText: AppStrings.guardianLicense,
              hintText: AppStrings.attachGuardianLicense,
              readOnly: true,

              controller: registerController.gDriverLicenseController,
              suffixIcon:
                  registerController.gDriverLicenseFile.value == ''
                      ? Assets.assetsIconsAttachPin
                      : Assets.assetsIconsEditDoc,
              suffixIconcolor:
                  registerController.gDriverLicenseFile.value == ''
                      ? AppColors.darkGreyColor
                      : AppColors.appColor,
              onTap:
                  () => registerController.showBottomSheet(
                    context,
                    type: AppStrings.guardianDriverLicenseType,
                  ),
            ),
          ),
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: registerController.agreePolicy.value,
                  onChanged: (bool? newValue) {
                    registerController.agreePolicy.value =
                        !registerController.agreePolicy.value;
                  },
                  activeColor: AppColors.appColor,
                  checkColor: AppColors.whiteColor,

                  side: BorderSide(color: AppColors.greyColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5.sp,
                    color: AppColors.blackColor,
                  ),
                  children: [
                    const TextSpan(text: "I Agree to "),
                    TextSpan(
                      text: 'privacy policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap =
                                () => Get.toNamed(Routes.privacyPolicyScreen),
                    ),
                  ],
                ),
              ),
            ],
          ),
          /*    Obx(
            () => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              // dense: true,
              visualDensity: VisualDensity.compact,
    
              side: BorderSide(width: 1.3, color: AppColors.greyColor),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (!states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return null;
              }),
    
              title: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5.sp,
                    color: AppColors.blackColor,
                  ),
                  children: [
                    const TextSpan(text: "I Agree to "),
                    TextSpan(
                      text: 'privacy policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap =
                                () => Get.toNamed(Routes.privacyPolicyScreen),
                    ),
                  ],
                ),
              ),
              value: registerController.agreePolicy.value,
    
              onChanged:
                  (bool? newValue) =>
                      registerController.agreePolicy.value =
                          !registerController.agreePolicy.value,
    
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.appColor,
              // checkboxScaleFactor: 1.3,
              checkboxShape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
         */
          Obx(
            () => CustomButton(
              text: 'Register',
              isLoading: registerController.formzStatus.value.isLoading,
              onTap: () => _onRegisterTap(context),
            ),
          ),
          GapH(1.5.h),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: AppStrings.fontFamily,
                  fontSize: 15.5.sp,
                  color: AppColors.darkGreyColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: 'Login Now',
                    style: const TextStyle(
                      color: AppColors.appColor,
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer:
                        TapGestureRecognizer()..onTap = () => Get.back(),
                  ),
                ],
              ),
            ),
          ),
          GapH(3.h),
        ],
      ),
    );
  }

  void _onRegisterTap(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (registerController.agreePolicy.value) {
      registerController.sendMail();
    } else {
      errorSnackBar(message: AppStrings.privacyPolicyMsg);
    }
  }
}
