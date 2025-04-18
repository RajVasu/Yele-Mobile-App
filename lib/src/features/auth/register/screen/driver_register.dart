import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/countries_picker.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';
import 'package:yele/src/features/auth/register/model/get_dealer_list_modal.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {
  RegisterController registerController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    registerController.getDealerList();
    registerController.clearDriverData();
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
            controller: registerController.drFNameController,
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
            controller: registerController.drLNameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
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

          CustomTextfield(
            displayText: AppStrings.phoneNo,
            hintText: AppStrings.enterPhoneNo,
            controller: registerController.drPhoneController,
            prefix: CountriesPicker(
              phonrNumber: registerController.drPhoneController.text,
              countryCode: registerController.countryCode,
              flag: registerController.flag,
              numberLenght: registerController.numberLenght,
            ),
            keyboardType: TextInputType.numberWithOptions(),

            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return AppStrings.pleaseEnterPhoneNo;
              }
              if (registerController.numberLenght.value !=
                  registerController.drPhoneController.text
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
            controller: registerController.drEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => Validator.validateEmail(value!),
          ),
          GapH(1.5.h),

          CustomTextfield(
            displayText: AppStrings.username,
            hintText: AppStrings.enterUsername,
            controller: registerController.drUserController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => Validator.validateUsername(value!),
          ),
          GapH(1.5.h),

          Obx(
            () => CustomTextfield(
              displayText: AppStrings.password,
              hintText: AppStrings.enterPassword,
              controller: registerController.drPwdController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              suffixIconOnTap:
                  () =>
                      registerController.driverPasswordVisible.value =
                          !registerController.driverPasswordVisible.value,
              suffixIcon:
                  registerController.driverPasswordVisible.value
                      ? Assets.assetsIconsInvisible
                      : Assets.assetsIconsVisible,
              obscureText: registerController.driverPasswordVisible.value,
              validator: (value) => Validator.validatePassword(value!),
            ),
          ),
          GapH(1.5.h),

          Obx(
            () => CustomTextfield(
              displayText: AppStrings.driverLicense,
              hintText: AppStrings.attachDriverLicense,
              controller: registerController.drLicenseController,
              readOnly: true,
              suffixIcon:
                  registerController.driverLicenseFile.value == ''
                      ? Assets.assetsIconsAttachPin
                      : Assets.assetsIconsEditDoc,
              suffixIconcolor:
                  registerController.driverLicenseFile.value == ''
                      ? AppColors.darkGreyColor
                      : AppColors.appColor,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return AppStrings.pleaseAttachDriverLicense;
                }

                return null;
              },
              onTap:
                  () => registerController.showBottomSheet(
                    context,
                    type: AppStrings.driverLicenseType,
                  ),
            ),
          ),
          GapH(1.5.h),

          CustomText(
            text: 'Dealer',
            fontWeight: FontWeight.w600,
            fontSize: 15.5.sp,
          ),
          GapH(0.5.h),
          Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                hint: CustomText(
                  text: 'Select a dealer',
                  fontFamily: AppStrings.fontFamily,
                  color: AppColors.darkGreyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                ),
                iconStyleData: IconStyleData(
                  icon: CustomAssetImage(
                    image: Assets.assetsIconsDropdown,
                    width: 1.5.h,
                    height: 1.5.h,
                  ),
                ),
                isExpanded: true,
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                buttonStyleData: ButtonStyleData(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1.3,
                    ),
                  ),
                ),
                value: registerController.selectedDealer.value,
                onChanged: (newValue) {
                  if (registerController.selectedDealer.value != newValue) {
                    registerController.selectedDealer.value = newValue!;
                    print(newValue);
                  }
                },
                items:
                    registerController.dealersList
                        .map<DropdownMenuItem<String>>((
                          GetDealerListModal dealer,
                        ) {
                          String value = dealer.firstName!;
                          return DropdownMenuItem<String>(
                            value: dealer.userId.toString(),
                            child: CustomText(text: value.capitalize!),
                          );
                        })
                        .toList(),
              ),
            ),
          ),
          GapH(2.5.h),

          Obx(
            () => CustomButton(
              text: 'Register',
              isLoading: registerController.formzStatus.value.isLoading,
              onTap: () => _onRegisterTap(context),
            ),
          ),
          GapH(3.h),

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
    registerController.driverRegister(
      dealer: registerController.selectedDealer.value,
    );
  }
}
