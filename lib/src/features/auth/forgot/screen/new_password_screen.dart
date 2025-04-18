import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/forgot/controller/forgot_password_controller.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  ForgotPasswordController forgotPasswordController = Get.find();

  @override
  void dispose() {
    super.dispose();
    forgotPasswordController.pwdController.clear();
    forgotPasswordController.cPwdController.clear();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomBgWidget(
        appBar: customAppBar(title: 'New Password'),
        body: Column(
          children: [
            GapH(2.h),
            CustomText(
              text:
                  'Please make sure, your new password must be unique from previously used password',
              color: AppColors.darkGreyColor,
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
            GapH(1.5.h),
            Obx(
              () => CustomTextfield(
                displayText: AppStrings.password,
                hintText: AppStrings.enterPassword,
                controller: forgotPasswordController.pwdController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.validatePassword(value!),
                obscureText: !forgotPasswordController.newPasswordVisible.value,
                suffixIconOnTap:
                    () =>
                        forgotPasswordController.newPasswordVisible.value =
                            !forgotPasswordController.newPasswordVisible.value,
                suffixIcon:
                    forgotPasswordController.newPasswordVisible.value
                        ? Assets.assetsIconsInvisible
                        : Assets.assetsIconsVisible,
              ),
            ),
            GapH(1.5.h),
            Obx(
              () => CustomTextfield(
                displayText: AppStrings.confirmPassword,
                hintText: AppStrings.enterConfirmPassword,
                controller: forgotPasswordController.cPwdController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (value) => Validator.validatePassword(value!),
                obscureText:
                    !forgotPasswordController.newConPasswordVisible.value,
                suffixIconOnTap:
                    () =>
                        forgotPasswordController.newConPasswordVisible.value =
                            !forgotPasswordController
                                .newConPasswordVisible
                                .value,
                suffixIcon:
                    forgotPasswordController.newConPasswordVisible.value
                        ? Assets.assetsIconsInvisible
                        : Assets.assetsIconsVisible,
              ),
            ),
            Spacer(),
            Obx(
              () => CustomButton(
                text: 'Reset Password',
                onTap: () => _onResetPwdTap(context),
                isLoading: forgotPasswordController.formzStatus.value.isLoading,
              ),
            ),
            GapH(3.h),
          ],
        ),
      ),
    );
  }

  void _onResetPwdTap(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    forgotPasswordController.forgotPassword();
  }
}
