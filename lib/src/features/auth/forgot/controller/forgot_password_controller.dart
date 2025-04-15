import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/repository/auth/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  RxBool newPasswordVisible = false.obs;
  RxBool newConPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cPwdController = TextEditingController();
  Rx<FormzStatus> formzStatus = FormzStatus.pure.obs;

  Future<void> sendOtp() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.sendOtp({
      "email": emailController.text,
      "otp_type": "forget_password",
    });
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    formzStatus.value = FormzStatus.pure;
    successSnackBar(message: result.data);
    Get.toNamed(Routes.verifyOtpScreen, arguments: 'forgetPassword');
  }

  Future<void> verfiyOtp({required String otp}) async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.verifyEmail({
      "email": emailController.text,
      "otp": otp,
      "otp_type": "forget_password",
    });
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
    Get.toNamed(Routes.newPasswordScreen);
  }

  Future<void> forgotPassword() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.forgotPassword({
      "email": emailController.text,
      "password": pwdController.text,
      "confirm_password": cPwdController.text,
    });
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
    clearData();
    Get.offAllNamed(Routes.loginScreen);
  }

  void clearData() {
    emailController.clear();
    pwdController.clear();
    cPwdController.clear();
  }
}
