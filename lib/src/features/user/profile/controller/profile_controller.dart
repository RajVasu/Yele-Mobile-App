import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/services/image_service.dart';
import 'package:yele/src/core/utils/countries_list.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/utils/log.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/features/auth/login/model/user_model.dart';
import 'package:yele/src/repository/user/user_profile_repository.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phNoController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController gNameController = TextEditingController();
  TextEditingController gLicenseController = TextEditingController();

  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController conPwdController = TextEditingController();
  RxString licenseFile = ''.obs;
  RxString gLicenseFile = ''.obs;
  RxString imageFile = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString countryCode = '+1'.obs;
  RxString flag = 'us'.obs;
  RxString numberLenght = '10'.obs;

  Rx<FormzStatus> formzStatus = FormzStatus.pure.obs;

  @override
  void onInit() {
    if (Storage.instance.getToken() != null) {
      getCurrentUserData();
    }
    super.onInit();
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
      if (type == AppStrings.userLicenseType) {
        licenseFile.value = file.path;
        licenseController.text = fileName;
        Log.d("LICENSE :::: ${licenseFile.value}");
      } else if (type == AppStrings.gLicenseType) {
        gLicenseFile.value = file.path;
        gLicenseController.text = fileName;
        Log.d("LICENSE :::: ${gLicenseFile.value}");
      }
    }

    Get.back();
  }

  Future<void> pickImage({
    required BuildContext context,
    required String type,
  }) async {
    File? file = await ImageService.pickImage(
      context: context,
      source: ImageSource.gallery,
    );
    if (type == AppStrings.userImage) {
      selectedImage.value = File(file!.path);
      imageFile.value = file.path;
      Get.back();
    } else if (type == AppStrings.userLicenseType) {
      if (file != null) {
        File result = File(file.path);
        String fileName = path.basename(result.path);

        Log.d("LICENSE :::: $fileName");
        licenseFile.value = file.path;
        licenseController.text = fileName;
        Log.d("LICENSE :::: ${licenseFile.value}");
      }
      Get.back();
    } else if (type == AppStrings.gLicenseType) {
      if (file != null) {
        File result = File(file.path);
        String fileName = path.basename(result.path);

        Log.d("LICENSE :::: $fileName");
        gLicenseFile.value = file.path;
        gLicenseController.text = fileName;
        Log.d("LICENSE :::: ${gLicenseFile.value}");
      }
      Get.back();
    }
  }

  Future<void> pickCamera({
    required BuildContext context,
    required String type,
  }) async {
    File? file = await ImageService.pickImage(
      context: context,
      source: ImageSource.camera,
    );
    if (type == AppStrings.userImage) {
      selectedImage.value = File(file!.path);
      imageFile.value = file.path;
      Get.back();
    } else if (type == AppStrings.userLicenseType) {
      if (file != null) {
        File result = File(file.path);
        String fileName = path.basename(result.path);

        Log.d("LICENSE :::: $fileName");
        licenseFile.value = file.path;
        licenseController.text = fileName;
        Log.d("LICENSE :::: ${licenseFile.value}");
      }
      Get.back();
    } else if (type == AppStrings.gLicenseType) {
      if (file != null) {
        File result = File(file.path);
        String fileName = path.basename(result.path);

        Log.d("LICENSE :::: $fileName");
        gLicenseFile.value = file.path;
        gLicenseController.text = fileName;
        Log.d("LICENSE :::: ${gLicenseFile.value}");
      }
      Get.back();
    }
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

              if (type != AppStrings.userImage)
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

  Rx<UserModel> userData = UserModel().obs;

  Future<void> getCurrentUserData() async {
    final result = await _userRepository.getUserData();
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    userData.value = result.data!;
    emailController.text = userData.value.email.toString();
    fNameController.text = userData.value.firstName.toString();
    lNameController.text = userData.value.lastName.toString();
    phNoController.text = userData.value.phoneNumber.toString();
    addController.text = userData.value.address.toString();

    for (var element in countries) {
      if (element.dialCode == userData.value.countryCode) {
        countryCode.value = element.dialCode;
        numberLenght.value = element.maxLength.toString();
        flag.value = element.code.toString().toLowerCase();
        print(flag.value);
      }
    }
    File file = File(userData.value.userLicense!);
    String fileName = path.basename(file.path);
    licenseController.text = fileName;
    // licenseFile.value = userData.value.userLicense!;

    if ((userData.value.guardianName != "" &&
            userData.value.guardianName != null) &&
        userData.value.guardianLicense != "" &&
        userData.value.guardianLicense != null) {
      File file = File(userData.value.guardianLicense!);
      String fileName = path.basename(file.path);
      gLicenseController.text = fileName;
      // gLicenseFile.value = userData.value.guardianLicense!;
      gNameController.text = userData.value.guardianName!;
    }
  }

  Future<void> editProfile() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _userRepository.editProfileData(
      firstName: fNameController.text,
      lastName: lNameController.text,
      countryCode: countryCode.value,
      phoneNumber: phNoController.text,
      email: emailController.text,
      address: addController.text,
      userLicense: licenseFile.value,
      guardianName: gNameController.text,
      guardianLicense: gLicenseFile.value,
      profileImage: imageFile.value,
    );
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
  }

  Future<void> resetPwd() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _userRepository.resetPassword(
      oldPwd: oldPwdController.text,
      newPwd: newPwdController.text,
      comPwd: conPwdController.text,
    );
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
    clearResetData();
  }

  Future<void> deleteAccount() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _userRepository.deleteAccount();
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
    clearResetData();
  }

  Future<void> logOut() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _userRepository.logOut();
    if (result.isFailure) {
      formzStatus.value = FormzStatus.pure;
      errorSnackBar(message: result.failure.message);
      return;
    }
    Storage.instance.clear();
    successSnackBar(message: result.data);
    formzStatus.value = FormzStatus.pure;
    clearResetData();
  }

  clearResetData() async {
    oldPwdController.clear();
    newPwdController.clear();
    conPwdController.clear();
  }

  clearData() async {
    emailController.clear();
    fNameController.clear();
    lNameController.clear();
    phNoController.clear();
    addController.clear();
    licenseController.clear();
    gNameController.clear();
    gLicenseController.clear();
    for (var element in countries) {
      if (element.dialCode == userData.value.countryCode) {
        countryCode.value = element.dialCode;
        numberLenght.value = element.maxLength.toString();
        flag.value = element.code.toString().toLowerCase();
        print(flag.value);
      }
    }
    selectedImage = Rx<File?>(null);
  }
}
