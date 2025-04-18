import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_role_selection.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';
import 'package:yele/src/features/auth/register/screen/dealer_app_request.dart';
import 'package:yele/src/features/auth/register/screen/driver_register.dart';
import 'package:yele/src/features/auth/register/screen/user_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = Get.find();
  @override
  void initState() {
    registerController.userRole.value = UserRole.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // // Deferring the requestFocus to the next frame
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   FocusScope.of(context).requestFocus(FocusNode());
        // });
      },

      child: CustomBgWidget(
        appBar: Obx(
          () => customAppBar(
            title:
                registerController.userRole.value == UserRole.user
                    ? 'Register'
                    : registerController.userRole.value == UserRole.dealer
                    ? 'Dealer App Request'
                    : 'Driver’s Register',
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GapH(1.5.h),
                CustomRoleSelection(),

                if (registerController.userRole.value == UserRole.user) ...[
                  UserRegisterScreen(),
                ],
                if (registerController.userRole.value == UserRole.dealer) ...[
                  DealerAppRequestScreen(),
                ],
                if (registerController.userRole.value == UserRole.driver) ...[
                  DriverRegisterScreen(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
