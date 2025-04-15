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
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            GapH(7.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GapH(4.h),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(Routes.dashboardScreen);
                              loginController.clearData();
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: CustomAssetImage(
                                image: Assets.assetsIconsBackIcon,
                                color: AppColors.blackColor,
                                height: 3.h,
                                width: 3.h,
                              ),
                            ),
                          ),

                          Container(
                            height: 25.h,
                            width: 25.h,
                            padding: EdgeInsets.all(20.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFFF2FBFF).withOpacity(0.2),
                                  const Color(0xFFF2FBFF),
                                  // First color
                                ],
                              ),
                            ),
                            child: CustomAssetImage(
                              image: Assets.assetsImagesAppLogo,
                              height: 18.h,
                              width: 18.h,
                            ),
                          ),

                          GapH(6.h),

                          CustomText(
                            text: 'Log in to your account',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          GapH(0.5.h),
                          CustomText(
                            text: 'Enter your credential to login',
                            fontSize: 16.4.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreyColor,
                          ),
                          GapH(3.h),

                          CustomTextfield(
                            displayText: AppStrings.email,
                            hintText: AppStrings.enterEmail,
                            keyboardType: TextInputType.emailAddress,
                            controller: loginController.emailController,
                            textInputAction: TextInputAction.next,
                            validator:
                                (value) => Validator.validateEmail(value!),
                          ),

                          GapH(1.5.h),
                          Obx(
                            () => CustomTextfield(
                              displayText: AppStrings.password,
                              hintText: AppStrings.enterPassword,
                              controller: loginController.pwdController,
                              textInputAction: TextInputAction.done,
                              validator:
                                  (value) => Validator.validatePassword(value!),
                              obscureText:
                                  !loginController.loginPasswordVisible.value,
                              suffixIconOnTap:
                                  () =>
                                      loginController
                                          .loginPasswordVisible
                                          .value = !loginController
                                              .loginPasswordVisible
                                              .value,
                              suffixIcon:
                                  loginController.loginPasswordVisible.value
                                      ? Assets.assetsIconsInvisible
                                      : Assets.assetsIconsVisible,
                            ),
                          ),

                          GapH(1.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.forgotPasswordScreen);
                                loginController.emailController.clear();
                                loginController.pwdController.clear();
                              },
                              child: Container(
                                // color: Colors.amber,
                                padding: EdgeInsets.only(
                                  left: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: CustomText(
                                  text: 'Forgot Password?',
                                  color: AppColors.appColor,
                                  fontSize: 15.2.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          GapH(3.h),

                          Obx(
                            () => CustomButton(
                              text: 'Login',
                              isLoading:
                                  loginController.formzStatus.value.isLoading,
                              onTap: () => _onLoginTap(context),
                            ),
                          ),
                          GapH(8.h),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: AppStrings.fontFamily,

                                fontSize: 16.sp,
                                color: AppColors.darkGreyColor,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: 'Create New',
                                  style: const TextStyle(
                                    color: AppColors.appColor,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          loginController.emailController
                                              .clear();
                                          loginController.pwdController.clear();
                                          Get.toNamed(Routes.registerScreen);
                                        },
                                ),
                              ],
                            ),
                          ),
                          GapH(2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginTap(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    loginController.login();
  }
}
