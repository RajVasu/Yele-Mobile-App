import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/car/model/get_car_compare_model.dart';
import 'package:yele/src/features/user/car/model/get_car_model.dart';
import 'package:yele/src/repository/user/user_car_repository.dart';

class CarController extends GetxController {
  final UserCarRepository _carRepository = UserCarRepository();
  final RxDouble currentPage = 0.0.obs;
  final RxBool favorite = false.obs;

  List tempList = [
    {'name': '32,458 KM', 'icon': Assets.assetsIconsDistance},
    {'name': 'Petrol', 'icon': Assets.assetsIconsPetrol},
    {'name': 'Manual', 'icon': Assets.assetsIconsManual},
    {'name': '2nd Owner', 'icon': Assets.assetsIconsOwner},
  ];

  RxBool agreeRequestInfo = false.obs;
  Rx<FormzStatus> formzStatus = FormzStatus.pure.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  var getCarData = GetCarModel().obs;
  RxList<GetCarCompareModel> carCompareList = <GetCarCompareModel>[].obs;

  Future<void> getCarDetailData({carId}) async {
    formzStatus.value = FormzStatus.loading;
    final result = await _carRepository.getCarData(carId: carId);
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    getCarData.value = result.data;
    favorite.value = getCarData.value.isFavorite!;
    formzStatus.value = FormzStatus.pure;
    update();
  }

  Future<void> favoriteCar({required int carId}) async {
    formzStatus.value = FormzStatus.loading;
    if (favorite.value) {
      final result = await _carRepository.removeFavoriteCar(carId: carId);
      if (result.isFailure) {
        errorSnackBar(message: result.failure.message);
        return;
      }
      favorite.value = false;
    } else {
      final result = await _carRepository.addFavoriteCar(carId: carId);
      if (result.isFailure) {
        errorSnackBar(message: result.failure.message);
        return;
      }
      favorite.value = true;
    }
    formzStatus.value = FormzStatus.pure;
    update();
  }

  Future<void> getCarCompareData({carId}) async {
    carCompareList.clear();

    final result = await _carRepository.getCarCompareData(carId: carId);
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    carCompareList.addAll(result.data.toList());
    update();
  }
}
