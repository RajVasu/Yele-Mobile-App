import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/utils/validator.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class AccountInfoWidget extends StatefulWidget {
  const AccountInfoWidget({super.key});

  @override
  State<AccountInfoWidget> createState() => _AccountInfoWidgetState();
}

class _AccountInfoWidgetState extends State<AccountInfoWidget> {
  final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GapH(0.5.h),
          CustomText(
            text: 'Account Info',
            fontWeight: FontWeight.w700,
            fontSize: 17.sp,
          ),
          GapH(2.h),
          CustomTextfield(
            displayText: AppStrings.emailAdd,
            hintText: AppStrings.enterEmailAdd,
            keyboardType: TextInputType.emailAddress,

            textInputAction: TextInputAction.next,
            // displayText: 'Email Address',
            displayColor: AppColors.greyColor,
            controller: _profileController.emailController,
            validator: (value) => Validator.validateEmail(value!),
          ),
          GapH(2.h),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.resetPasswordScreen),
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                text: 'Reset Password',
                fontSize: 17.sp,
                color: AppColors.appColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
