import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/forgot/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController forgotPasswordController = Get.find();
  @override
  void dispose() {
    super.dispose();
    forgotPasswordController.emailController.clear();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomBgWidget(
        appBar: customAppBar(title: 'Forgot Password'),
        body: Column(
          children: [
            GapH(1.h),
            CustomText(
              text: 'Enter the email address associated with your account',
              color: AppColors.darkGreyColor,
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
            GapH(1.5.h),
            CustomTextfield(
              displayText: AppStrings.email,
              hintText: AppStrings.enterEmail,
              controller: forgotPasswordController.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) => Validator.validatePassword(value!),
            ),
            Spacer(),
            Obx(
              () => CustomButton(
                text: 'Send Code',
                isLoading: forgotPasswordController.formzStatus.value.isLoading,
                onTap: () => _onSendOTPTap(context),
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
                    const TextSpan(text: "Remember password? "),
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
      ),
    );
  }

  void _onSendOTPTap(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    forgotPasswordController.sendOtp();
  }
}
