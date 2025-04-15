import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/countries_picker.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';

class DealerAppRequestScreen extends StatefulWidget {
  const DealerAppRequestScreen({super.key});

  @override
  State<DealerAppRequestScreen> createState() => _DealerAppRequestScreenState();
}

class _DealerAppRequestScreenState extends State<DealerAppRequestScreen> {
  RegisterController registerController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    registerController.clearDealerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),

      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextfield(
              displayText: AppStrings.dealership,
              hintText: AppStrings.enterDealership,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: registerController.dealerShipController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return AppStrings.pleaseEnterDealership;
                }

                return null;
              },
            ),
            GapH(1.5.h),
            CustomTextfield(
              displayText: AppStrings.dealeremail,
              hintText: AppStrings.enterDealeremail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: registerController.dEmailController,
              validator:
                  (value) => Validator.validateEmail(
                    value!,
                    type: 'Please enter dealer email address',
                  ),
            ),
            GapH(1.5.h),
            CustomTextfield(
              displayText: AppStrings.firstName,
              hintText: AppStrings.enterFirstName,
              controller: registerController.dFNameController,
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
              controller: registerController.dLNameController,
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
              displayText: AppStrings.dealershipsPhone,
              hintText: AppStrings.enterDealerPhone,

              textInputAction: TextInputAction.next,
              controller: registerController.dPhoneController,
              prefix: CountriesPicker(
                phonrNumber: registerController.dPhoneController.text,
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
                    registerController.dPhoneController.text
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
              maxLines: 4,
              maxLength: 500,
              controller: registerController.dCommentsController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              displayText: AppStrings.comments,
              hintText: AppStrings.typeComments,
            ),

            GapH(2.5.h),
            Obx(
              () => CustomButton(
                text: 'Request',
                isLoading: registerController.formzStatus.value.isLoading,
                onTap: () => _onRegisterTap(context),
              ),
            ),

            GapH(2.h),

            CustomText(
              text: 'We will get right back to you!',
              color: AppColors.darkGreyColor,
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterTap(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    registerController.dealerRegister();
  }
}
