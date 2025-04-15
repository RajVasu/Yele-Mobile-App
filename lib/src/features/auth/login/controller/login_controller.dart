import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/repository/auth/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  RxBool loginPasswordVisible = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  Rx<FormzStatus> formzStatus = FormzStatus.pure.obs;

  Future<void> login() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.login({
      'email': emailController.text,
      'password': pwdController.text,
      'device_type': 'mobile',
    });
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    await Storage.instance.setToken(result.data.token!.access!);
    await Storage.instance.setUser(result.data);
    successSnackBar(message: result.data.message);
    formzStatus.value = FormzStatus.pure;
    if (AppStrings.userRoleType == result.data.userRoleName) {
      Get.offAllNamed(Routes.dashboardScreen);
    } else if (AppStrings.dealerRoleType == result.data.userRoleName) {
      Get.offAllNamed(Routes.dealerHomeScreen);
    } else if (AppStrings.driverRoleType == result.data.userRoleName) {
      Get.offAllNamed(Routes.driverHomeScreen);
    }
    clearData();
  }

  void clearData() {
    emailController.clear();
    pwdController.clear();
    loginPasswordVisible.value = false;
  }
}
