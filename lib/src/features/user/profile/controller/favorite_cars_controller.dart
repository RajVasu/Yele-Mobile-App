import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/car/model/get_car_list_model.dart';
import 'package:yele/src/repository/user/user_car_repository.dart';

class FavoriteCarsController extends GetxController {
  final UserCarRepository _carRepository = UserCarRepository();
  RxBool agreeRequestInfo = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  var getFavoriteCarData = GetCarListModel().obs;
  RxBool paginationselected = false.obs;
  RxInt currentPageIndex = 0.obs;
  RxList<CarListData> favoriteCarList = <CarListData>[].obs;

  Future<void> getFavoriteCarListData() async {
    currentPageIndex.value = 0;
    currentPageIndex.value = currentPageIndex.value + 1;
    favoriteCarList.clear();

    final result = await _carRepository.getFavoriteCarList(
      page: currentPageIndex.value,
    );
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    getFavoriteCarData.value = result.data;
    if (result.data.carListData != null) {
      favoriteCarList.addAll(result.data.carListData!.toList());
    } else {
      errorSnackBar(message: 'No car list data available.');
    }
    update();
  }

  Future<void> getFavoriteCarListDataPagination() async {
    currentPageIndex.value = currentPageIndex.value + 1;

    final result = await _carRepository.getFavoriteCarList(
      page: currentPageIndex.value,
    );
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    // Null check for carListData
    if (result.data.carListData != null) {
      favoriteCarList.addAll(result.data.carListData!.toList());
    } else {
      // Handle case where carListData is null
      errorSnackBar(message: 'No car list data available.');
    }
    update();
  }

  Future<void> removeFavoriteCar({carId}) async {
    final result = await _carRepository.removeFavoriteCar(carId: carId);
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    await getFavoriteCarListData();
    update();
  }
}
