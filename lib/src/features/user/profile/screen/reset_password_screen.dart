import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart'
    show NoInternetScreen;
import 'package:yele/src/core/utils/formz_status.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';

import '../controller/profile_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: ResetPasswordView());
  }
}

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ProfileController _profileController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _profileController.clearResetData();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: CustomBgWidget(
        appBar: customAppBar(title: 'Reset Password'),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextfield(
                controller: _profileController.oldPwdController,
                displayText: AppStrings.oldPassword,
                hintText: AppStrings.enterOldPassword,
                validator: (value) => Validator.validatePassword(value!),
              ),
              GapH(2.h),
              CustomTextfield(
                controller: _profileController.newPwdController,

                displayText: AppStrings.newPassword,
                hintText: AppStrings.enterNewPassword,
                validator: (value) => Validator.validatePassword(value!),
              ),
              GapH(2.h),
              CustomTextfield(
                displayText: AppStrings.conPassword,
                hintText: AppStrings.enterConPassword,
                controller: _profileController.conPwdController,
                validator: (value) => Validator.validatePassword(value!),
              ),
              Spacer(),
              Obx(
                () => CustomButton(
                  text: 'Change Password',
                  isLoading: _profileController.formzStatus.value.isLoading,
                  onTap: () => _onChangePwdTap(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChangePwdTap(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    _profileController.resetPwd();
  }
}
