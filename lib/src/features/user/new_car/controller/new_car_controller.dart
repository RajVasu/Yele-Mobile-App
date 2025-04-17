import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/car/model/get_car_list_model.dart';
import 'package:yele/src/repository/user/user_car_repository.dart';

class NewCarController extends GetxController {
  final UserCarRepository _carRepository = UserCarRepository();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  RxList<CarListData> newCarList = <CarListData>[].obs;
  RxBool agreeRequestInfo = false.obs;
  RxBool paginationselected = false.obs;
  RxInt currentPageIndex = 0.obs;
  var getCarData = GetCarListModel().obs;

  @override
  void onInit() {
    getNewCarListData();
    super.onInit();
  }

  Future<void> getNewCarListData({
    List? carBrand,
    List? carModel,
    List? fuelType,
    List? modelYear,
    List? bodyType,
    List? transmissions,
    List? owners,
    List? seats,
    List? kmDriven,
    List? color,
    List? rto,
    dynamic minPrice,
    dynamic maxPrice,
  }) async {
    currentPageIndex.value = 0;
    currentPageIndex.value = currentPageIndex.value + 1;
    newCarList.clear();

    final result = await _carRepository.getCarList(
      carType: 'New Car',
      page: currentPageIndex.value,
      carModel: carModel,
      carBrand: carBrand,
      fuelType: fuelType,
      modelYear: modelYear,
      rto: rto,
      bodyType: bodyType,
      transmissions: transmissions,
      owners: owners,
      seats: seats,
      kmDriven: kmDriven,
      color: color,
      maxPrice: maxPrice,
      minPrice: minPrice,
    );
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    getCarData.value = result.data;
    // Null check for carListData
    if (result.data.carListData != null) {
      newCarList.addAll(result.data.carListData!.toList());
    } else {
      // Handle case where carListData is null
      errorSnackBar(message: 'No car list data available.');
    }
    update();
  }

  Future<void> getNewCarListDataPagination() async {
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
      newCarList.addAll(result.data.carListData!.toList());
    } else {
      // Handle case where carListData is null
      errorSnackBar(message: 'No car list data available.');
    }
    update();
  }
}
