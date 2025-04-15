import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/services/image_service.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/utils/log.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/features/auth/register/model/get_dealer_list_modal.dart';
import 'package:yele/src/repository/auth/auth_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  Rx<UserRole> userRole = UserRole.user.obs;
  RxBool agreePolicy = false.obs;
  final List<String> rolesList =
      UserRole.values.map((role) => role.toString().split('.').last).toList();
  RxString countryCode = '+1'.obs;
  RxString flag = 'us'.obs;
  RxString numberLenght = '10'.obs;

  // User Role
  RxBool userPasswordVisible = true.obs;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController driverLicenseController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController pwdUserController = TextEditingController();
  TextEditingController gNameController = TextEditingController();
  TextEditingController gDriverLicenseController = TextEditingController();
  RxString driverUserLicenseFile = ''.obs;
  RxString gDriverLicenseFile = ''.obs;

  Rx<FormzStatus> formzStatus = FormzStatus.pure.obs;

  Future<void> userRegister() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.userRegister(
      firstName: fNameController.text,
      lastName: lNameController.text,
      countryCode: countryCode.value,
      phoneNumber: phnoController.text,
      email: emailController.text,
      address: addController.text,
      password: pwdUserController.text,
      userLicense: driverUserLicenseFile.value,
      guardianName: gNameController.text,
      guardianLicense: gDriverLicenseFile.value,
    );
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    // await Storage.instance.setToken(result.data.token!.access!);

    // await Storage.instance.setUser(result.data);
    successSnackBar(message: result.data.message);
    formzStatus.value = FormzStatus.pure;
    clearUserData();

    Get.until((route) => route.settings.name == Routes.loginScreen);
  }

  Future<void> sendMail() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.sendMail({
      "email": emailController.text,
      "otp_type": "register",
    });
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
    Get.toNamed(Routes.verifyOtpScreen, arguments: 'userRegister');
  }

  Future<void> verifyEmail({required String otp}) async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.verifyEmail({
      "email": emailController.text,
      "otp": otp,
      "otp_type": "register",
    });
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    // successSnackBar(message: result.data.mess);
    formzStatus.value = FormzStatus.pure;
    await userRegister();
  }

  Future<void> pickFile({required String type}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
      type: FileType.custom,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = path.basename(file.path);

      Log.d("LICENSE :::: $fileName");
      if (type == AppStrings.userDriverLicenseType) {
        driverLicenseController.clear();
        driverUserLicenseFile.value = file.path;
        driverLicenseController.text = fileName;
        Log.d("LICENSE :::: ${driverUserLicenseFile.value}");
      } else if (type == AppStrings.guardianDriverLicenseType) {
        gDriverLicenseController.clear();
        gDriverLicenseFile.value = file.path;
        gDriverLicenseController.text = fileName;
        Log.d("LICENSE :::: ${gDriverLicenseFile.value}");
      } else if (type == AppStrings.driverLicenseType) {
        drLicenseController.clear();
        driverLicenseFile.value = file.path;
        drLicenseController.text = fileName;
        Log.d("LICENSE :::: ${driverLicenseFile.value}");
      }
    } else {
      // User canceled the picker
    }

    Get.back();
    // showModalBottomSheet(context: context, builder: {})
  }

  Future<void> pickImage({
    required BuildContext context,
    required String type,
  }) async {
    File? file = await ImageService.pickImage(
      context: context,
      source: ImageSource.gallery,
    );

    if (file != null) {
      File result = File(file.path);
      String fileName = path.basename(result.path);

      Log.d("LICENSE :::: $fileName");
      if (type == AppStrings.userDriverLicenseType) {
        driverLicenseController.clear();
        driverUserLicenseFile.value = file.path;
        driverLicenseController.text = fileName;
        Log.d("LICENSE :::: ${driverUserLicenseFile.value}");
      } else if (type == AppStrings.guardianDriverLicenseType) {
        gDriverLicenseController.clear();
        gDriverLicenseFile.value = file.path;
        gDriverLicenseController.text = fileName;
        Log.d("LICENSE :::: ${gDriverLicenseFile.value}");
      } else if (type == AppStrings.driverLicenseType) {
        drLicenseController.clear();
        driverLicenseFile.value = file.path;
        drLicenseController.text = fileName;
        Log.d("LICENSE :::: ${driverLicenseFile.value}");
      }
    } else {
      // User canceled the picker
    }
    Get.back();
  }

  Future<void> pickCamera({
    required BuildContext context,
    required String type,
  }) async {
    File? file = await ImageService.pickImage(
      context: context,
      source: ImageSource.camera,
    );
    if (file != null) {
      File result = File(file.path);
      String fileName = path.basename(result.path);

      Log.d("LICENSE :::: $fileName");
      if (type == AppStrings.userDriverLicenseType) {
        driverLicenseController.clear();
        driverUserLicenseFile.value = file.path;
        driverLicenseController.text = fileName;
        Log.d("LICENSE :::: ${driverUserLicenseFile.value}");
      } else if (type == AppStrings.guardianDriverLicenseType) {
        gDriverLicenseController.clear();
        gDriverLicenseFile.value = file.path;
        gDriverLicenseController.text = fileName;
        Log.d("LICENSE :::: ${gDriverLicenseFile.value}");
      } else if (type == AppStrings.driverLicenseType) {
        drLicenseController.clear();
        driverLicenseFile.value = file.path;
        drLicenseController.text = fileName;
        Log.d("LICENSE :::: ${driverLicenseFile.value}");
      }
    } else {
      // User canceled the picker
    }
    Get.back();
  }

  void showBottomSheet(BuildContext context, {required String type}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => pickCamera(context: context, type: type),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsCamera,
                    height: 5.h,
                    width: 5.h,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => pickImage(context: context, type: type),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsPicture,
                    height: 5.h,
                    width: 5.h,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => pickFile(type: type),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsFileManager,
                    height: 5.h,
                    width: 5.h,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Dealer Role
  RxBool dealerPasswordVisible = false.obs;
  TextEditingController dealerShipController = TextEditingController();
  TextEditingController dEmailController = TextEditingController();
  TextEditingController dFNameController = TextEditingController();
  TextEditingController dLNameController = TextEditingController();
  TextEditingController dPhoneController = TextEditingController();
  TextEditingController dCommentsController = TextEditingController();

  Future<void> dealerRegister() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.dealerRegister(
      firstName: dFNameController.text,
      lastName: dLNameController.text,
      countryCode: countryCode.value,
      phoneNumber: dPhoneController.text,
      email: dEmailController.text,
      dealership: dealerShipController.text,
      comment: dCommentsController.text,
    );
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    // await Storage.instance.setToken(result.data.token!.access!);
    // await Storage.instance.setUser(result.data);
    successSnackBar(message: result.data.message);
    formzStatus.value = FormzStatus.pure;
    clearDealerData();
    // Get.offAllNamed(Routes.loginScreen);
    Get.until((route) => route.settings.name == Routes.loginScreen);
  }

  // Driver Role
  RxBool driverPasswordVisible = true.obs;
  TextEditingController drFNameController = TextEditingController();
  TextEditingController drLNameController = TextEditingController();
  TextEditingController drPhoneController = TextEditingController();
  TextEditingController drEmailController = TextEditingController();
  TextEditingController drUserController = TextEditingController();
  TextEditingController drPwdController = TextEditingController();
  TextEditingController drLicenseController = TextEditingController();

  RxString driverLicenseFile = ''.obs;
  RxString selectedDealer = ''.obs;

  Future<void> driverRegister({required String dealer}) async {
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.driverRegister(
      firstName: drFNameController.text,
      lastName: drLNameController.text,
      countryCode: countryCode.value,
      phoneNumber: drPhoneController.text,
      email: drEmailController.text,
      password: drPwdController.text,
      dealer: dealer,
      driverLicense: driverLicenseFile.value,
      userName: drUserController.text,
    );
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    // await Storage.instance.setToken(result.data.token!.access!);
    // await Storage.instance.setUser(result.data);
    successSnackBar(message: result.data.message);
    formzStatus.value = FormzStatus.pure;
    clearDriverData();
    // Get.offAllNamed(Routes.loginScreen);
    Get.until((route) => route.settings.name == Routes.loginScreen);
  }

  RxList<GetDealerListModal> dealersList = <GetDealerListModal>[].obs;
  Future<void> getDealerList() async {
    dealersList.clear();
    formzStatus.value = FormzStatus.loading;
    final result = await _authRepository.getDealerList();
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    dealersList.addAll(result.data.toList());
    selectedDealer.value = dealersList.first.userId.toString();
    for (var element in dealersList) {
      Log.s("DATA ::: ${element.toJson()}");
      Log.s("DATA ::: ${element.userId}");
      Log.s("DATA ::: ${element.firstName}");
    }
    formzStatus.value = FormzStatus.pure;
  }

  void clearUserData() {
    fNameController.clear();
    lNameController.clear();
    driverLicenseController.clear();
    phnoController.clear();
    emailController.clear();
    addController.clear();
    pwdUserController.clear();
    gNameController.clear();
    gDriverLicenseController.clear();
    driverUserLicenseFile.value = '';
    gDriverLicenseFile.value = '';
    countryCode = '+1'.obs;
    flag = 'us'.obs;
    numberLenght = '10'.obs;
    userPasswordVisible.value = true;
  }

  void clearDealerData() {
    countryCode = '+1'.obs;
    flag = 'us'.obs;
    numberLenght = '10'.obs;
    dealerShipController.clear();
    dEmailController.clear();
    dFNameController.clear();
    dLNameController.clear();
    dPhoneController.clear();
    dCommentsController.clear();
    dealerPasswordVisible.value = false;
  }

  void clearDriverData() {
    countryCode = '+1'.obs;
    flag = 'us'.obs;
    numberLenght = '10'.obs;
    drFNameController.clear();
    drLNameController.clear();
    drPhoneController.clear();
    drEmailController.clear();
    drUserController.clear();
    drPwdController.clear();
    drLicenseController.clear();
    driverLicenseFile.value = '';
    driverPasswordVisible.value = true;
  }
}
