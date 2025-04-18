import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/core/extensions/string_extension.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/forgot/controller/forgot_password_controller.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  RegisterController registerController = Get.find();
  ForgotPasswordController forgotPasswordController = Get.find();
  TextEditingController otpController = TextEditingController();

  String type = '';
  Timer? _timer;
  int _remainingTime = 60; // 60 seconds for the countdown
  bool _isResendEnabled = false; // Initially, resend is disabled
  @override
  void initState() {
    type = Get.arguments;
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();

    otpController.clear();
    print("dispose");
  }

  void _startCountdown() {
    _isResendEnabled = false; // Initially, disable the button
    _remainingTime = 60; // Reset countdown time to 60 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isResendEnabled = true; // Enable the button when time is up
        });
        _timer?.cancel(); // Stop the timer when the countdown reaches 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomBgWidget(
        appBar: customAppBar(title: 'Verify OTP'),
        body: Column(
          children: [
            GapH(2.h),
            CustomText(
              text:
                  'Please enter the 4 digit verification code we just sent to ${type == "userRegister" ? formatEmail(registerController.emailController.text) : formatEmail(forgotPasswordController.emailController.text)}',
              color: AppColors.darkGreyColor,
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
            GapH(1.5.h),
            Container(
              color: Colors.transparent,

              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: PinCodeTextField(
                showCursor: false,
                autoDisposeControllers: false,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                appContext: context,
                length: 4,
                enableActiveFill: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  fieldHeight: 50,
                  fieldWidth: 50,
                  borderWidth: 0.5,
                  inactiveColor: AppColors.greyColor.withOpacity(0.5),
                  activeColor: AppColors.blackColor,
                  selectedColor: AppColors.greyColor.withOpacity(0.5),
                ),
                cursorColor: AppColors.blackColor,
                controller: otpController,
                keyboardType: TextInputType.number,
                onCompleted: (v) {
                  debugPrint("OTP Completed: $v");
                },
                onChanged: (value) {
                  debugPrint("Current OTP: $value");
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  return true;
                },
              ),
            ),
            GapH(1.5.h),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: AppStrings.fontFamily,

                      fontSize: 15.5.sp,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: "Didn’t received code? "),
                      TextSpan(
                        text: 'Resend',
                        style: TextStyle(
                          color:
                              _isResendEnabled
                                  ? AppColors.appColor
                                  : AppColors.greyColor,

                          fontWeight: FontWeight.w600,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap =
                                  _isResendEnabled
                                      ? () => _onResendOTPTap(context)
                                      : null,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomText(
                  text: '00:${_remainingTime.toString().padLeft(2, '0')}',
                  color: AppColors.appColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ],
            ),
            Spacer(),
            Obx(
              () => CustomButton(
                text: 'Verify Code',
                isLoading:
                    type == "userRegister"
                        ? registerController.formzStatus.value.isLoading
                        : forgotPasswordController.formzStatus.value.isLoading,
                onTap: () => _onOTPVerifyTap(context),
              ),
            ),
            GapH(3.h),
          ],
        ),
      ),
    );
  }

  void _onOTPVerifyTap(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (type == "userRegister") {
      registerController.verifyEmail(otp: otpController.text);
    } else {
      forgotPasswordController.verfiyOtp(otp: otpController.text);
    }
  }

  void _onResendOTPTap(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    _startCountdown();
    if (type == "userRegister") {
      registerController.sendMail();
    } else {
      forgotPasswordController.sendOtp();
    }
  }
}
