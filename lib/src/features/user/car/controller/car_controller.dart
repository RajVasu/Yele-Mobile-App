import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/car/model/get_car_model.dart';
import 'package:yele/src/repository/user/user_car_repository.dart';

class CarController extends GetxController {
  final UserCarRepository _carRepository = UserCarRepository();
  final RxDouble currentPage = 0.0.obs;
  final RxBool favorite = false.obs;

  List imageList = [
    Assets.assetsImagesBCar1,
    Assets.assetsImagesBCar3,
    Assets.assetsImagesBCar5,
  ];
  List tempList = [
    {'name': '32,458 KM', 'icon': Assets.assetsIconsDistance},
    {'name': 'Petrol', 'icon': Assets.assetsIconsPetrol},
    {'name': 'Manual', 'icon': Assets.assetsIconsManual},
    {'name': '2nd Owner', 'icon': Assets.assetsIconsOwner},
  ];

  RxBool agreeRequestInfo = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  var getCarData = GetCarModel().obs;

  Future<void> getCarBrandListData({carId}) async {
    final result = await _carRepository.getCarData(carId: carId);
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    getCarData.value = result.data;

    update();
  }
}
