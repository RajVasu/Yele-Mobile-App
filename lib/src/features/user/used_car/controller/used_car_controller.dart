import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/car/model/get_car_list_model.dart';
import 'package:yele/src/repository/user/user_car_repository.dart';

class UsedCarController extends GetxController {
  final UserCarRepository _carRepository = UserCarRepository();
  RxList<CarListData> usedCarList = <CarListData>[].obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  RxBool agreeRequestInfo = false.obs;
  RxBool paginationselected = false.obs;
  RxInt currentPageIndex = 0.obs;
  var getCarData = GetCarListModel().obs;
  @override
  void onInit() {
    getCarBrandListData();
    super.onInit();
  }

  Future<void> getCarBrandListData() async {
    currentPageIndex.value = 0;
    currentPageIndex.value = currentPageIndex.value + 1;
    usedCarList.clear();

    final result = await _carRepository.getCarList(
      carType: 'Used Car',
      page: currentPageIndex.value,
    );
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    getCarData.value = result.data;
    // Null check for carListData
    if (result.data.carListData != null) {
      usedCarList.addAll(result.data.carListData!.toList());
    } else {
      // Handle case where carListData is null
      errorSnackBar(message: 'No car list data available.');
    }
    update();
  }

  Future<void> getCarBrandListDataPagination() async {
    currentPageIndex.value = currentPageIndex.value + 1;

    final result = await _carRepository.getCarList(
      carType: 'Used Car',
      page: currentPageIndex.value,
    );
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    // Null check for carListData
    if (result.data.carListData != null) {
      usedCarList.addAll(result.data.carListData!.toList());
    } else {
      // Handle case where carListData is null
      errorSnackBar(message: 'No car list data available.');
    }
    update();
  }

}
