import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/filter/components/filter_checkbox_list_widget.dart';
import 'package:yele/src/features/user/filter/model/get_filter_model.dart';
import 'package:yele/src/features/user/new_car/controller/new_car_controller.dart';
import 'package:yele/src/features/user/used_car/controller/used_car_controller.dart';
import 'package:yele/src/repository/user/user_car_repository.dart';

class FilterController extends GetxController {
  final UserCarRepository _carRepository = UserCarRepository();
  Rx<FormzStatus> formzStatus = FormzStatus.pure.obs;
  RxBool showMakeModelList = true.obs;
  final UsedCarController _usedCarController = Get.find();
  final NewCarController _newCarController = Get.find();
  RxBool showFuelFilters = false.obs;
  RxBool showModelYearFilters = false.obs;
  RxBool showFeatureFilters = false.obs;
  RxBool showRtoFilters = false.obs;
  RxBool showBodyTypeFilters = false.obs;
  RxBool showTransmissionFilters = false.obs;
  RxBool showOwnerFilters = false.obs;
  RxBool showSeatFilters = false.obs;
  RxBool showKmDrivenFilters = false.obs;
  RxBool showColorFilters = false.obs;
  RxBool showBrandsList = true.obs;

  List<FilterListModel> makeModelList = <FilterListModel>[];

  List<FilterListModel> brandsList = <FilterListModel>[];

  List<FilterListModel> fuelFilters = [];

  List<FilterListModel> modelYearFilters = [];

  List<FilterListModel> featureFilters = [];

  List<FilterListModel> rtoFilters = [];

  List<FilterListModel> bodyTypeFilters = [];

  List<FilterListModel> transmissionFilters = [];

  List<FilterListModel> ownerFilters = [];

  List<FilterListModel> seatFilters = [];

  List<FilterListModel> kmDrivenFilters = [];

  List<FilterListModel> colorFilters = [];

  RxBool showBudgetSlider = true.obs;
  RxDouble currentBudget = 100000.0.obs;

  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  Rx<RangeValues> budgetValues = RangeValues(0, 10).obs;
  var getFilterData = GetFilterModel().obs;

  List<String> makeModelFilterList = [];
  List<String> brandsFilterList = [];
  List<String> newBrandFilterList = [];
  List<String> fuelFiltersList = [];
  List<String> modelYearFiltersList = [];
  List<String> rtoFiltersList = [];
  List<String> bodyTypeFiltersList = [];
  List<String> transmissionFiltersList = [];
  List<String> ownerFiltersList = [];
  List<String> seatFiltersList = [];
  List<String> kmDrivenFiltersList = [];
  List<String> colorFiltersList = [];

  RxList<String> mainList = <String>[].obs;
  @override
  void onInit() {
    getCarFilterData();
    super.onInit();
  }

  Future<void> getCarFilterData() async {
    formzStatus.value = FormzStatus.loading;
    final result = await _carRepository.getFilterData();
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    getFilterData.value = result.data;
    minPrice.value =
        double.tryParse(
          getFilterData.value.budget!.minPrice!
              .replaceAll(',', '')
              .replaceAll('\$', ''),
        ) ??
        0;
    maxPrice.value =
        double.tryParse(
          getFilterData.value.budget!.maxPrice!
              .replaceAll(',', '')
              .replaceAll('\$', ''),
        ) ??
        0;

    if (minPrice.value <= maxPrice.value) {
      budgetValues.value = RangeValues(minPrice.value, maxPrice.value);
    } else {
      budgetValues.value = RangeValues(0, 10);
    }
    for (var element in getFilterData.value.model!) {
      makeModelList.add(
        FilterListModel(title: element.modelName!, clicked: false.obs),
      );
    }
    for (var element in getFilterData.value.brand!) {
      brandsList.add(
        FilterListModel(title: element.brandName!, clicked: false.obs),
      );
    }
    for (var element in getFilterData.value.fuelType!) {
      fuelFilters.add(
        FilterListModel(title: element.fuelTypeName!, clicked: false.obs),
      );
    }
    for (var element in getFilterData.value.modelYear!) {
      modelYearFilters.add(
        FilterListModel(
          title: element.modelYear.toString(),
          clicked: false.obs,
        ),
      );
    }
    for (var element in getFilterData.value.rto!) {
      rtoFilters.add(
        FilterListModel(title: element.rtoName.toString(), clicked: false.obs),
      );
    }
    for (var element in getFilterData.value.bodyType!) {
      bodyTypeFilters.add(
        FilterListModel(title: element.typeName.toString(), clicked: false.obs),
      );
    }
    for (var element in getFilterData.value.transmission!) {
      transmissionFilters.add(
        FilterListModel(
          title: element.transmissionType.toString(),
          clicked: false.obs,
        ),
      );
    }
    for (var element in getFilterData.value.owners!) {
      ownerFilters.add(
        FilterListModel(title: element.owner.toString(), clicked: false.obs),
      );
    }
    for (var element in getFilterData.value.seats!) {
      seatFilters.add(
        FilterListModel(
          title: element.seatNumber.toString(),
          clicked: false.obs,
        ),
      );
    }
    for (var element in getFilterData.value.kmsDriven!) {
      kmDrivenFilters.add(
        FilterListModel(
          title: element.kmsDriven.toString(),
          clicked: false.obs,
        ),
      );
    }
    for (var element in getFilterData.value.color!) {
      colorFilters.add(
        FilterListModel(
          title: element.colorName.toString(),
          clicked: false.obs,
        ),
      );
    }

    formzStatus.value = FormzStatus.pure;
    update();
  }

  clearData() {
    if (mainList.isNotEmpty) {
      checkDataList();
    } else {
      checkDataList();
      makeModelList.clear();
      brandsList.clear();
      fuelFilters.clear();
      modelYearFilters.clear();
      rtoFilters.clear();
      bodyTypeFilters.clear();
      transmissionFilters.clear();
      ownerFilters.clear();
      seatFilters.clear();
      kmDrivenFilters.clear();
      colorFilters.clear();
    }
    showMakeModelList = false.obs;
    showFuelFilters = false.obs;
    showModelYearFilters = false.obs;
    showRtoFilters = false.obs;
    showBodyTypeFilters = false.obs;
    showTransmissionFilters = false.obs;
    showOwnerFilters = false.obs;
    showSeatFilters = false.obs;
    showKmDrivenFilters = false.obs;
    showColorFilters = false.obs;
    showBrandsList = false.obs;
    showBudgetSlider = false.obs;
    minPrice = 0.0.obs;
    maxPrice = 0.0.obs;
    budgetValues = RangeValues(0, 10).obs;
  }

  addSearchData({required String data, required String type}) {
    if (type == 'model') {
      makeModelFilterList.add(data);
    } else if (type == 'brand') {
      brandsFilterList.add(data);
    } else if (type == 'fuel_type') {
      fuelFiltersList.add(data);
    } else if (type == 'model_year') {
      modelYearFiltersList.add(data);
    } else if (type == 'rto') {
      rtoFiltersList.add(data);
    } else if (type == 'body_type') {
      bodyTypeFiltersList.add(data);
    } else if (type == 'transmission') {
      transmissionFiltersList.add(data);
    } else if (type == 'owners') {
      ownerFiltersList.add(data);
    } else if (type == 'seats') {
      seatFiltersList.add(data);
    } else if (type == 'kms_driven') {
      kmDrivenFiltersList.add(data);
    } else if (type == 'color') {
      colorFiltersList.add(data);
    }
    update();
  }

  removeSearchData({required String data, required String type}) {
    if (type == 'model') {
      makeModelFilterList.remove(data);
    } else if (type == 'brand') {
      brandsFilterList.remove(data);
    } else if (type == 'fuel_type') {
      fuelFiltersList.remove(data);
    } else if (type == 'model_year') {
      modelYearFiltersList.remove(data);
    } else if (type == 'rto') {
      rtoFiltersList.remove(data);
    } else if (type == 'body_type') {
      bodyTypeFiltersList.remove(data);
    } else if (type == 'transmission') {
      transmissionFiltersList.remove(data);
    } else if (type == 'owners') {
      ownerFiltersList.remove(data);
    } else if (type == 'seats') {
      seatFiltersList.remove(data);
    } else if (type == 'kms_driven') {
      kmDrivenFiltersList.remove(data);
    } else if (type == 'color') {
      colorFiltersList.remove(data);
    }

    update();
  }

  addMianData({type}) async {
    mainList.clear();
    RxDouble newMinPrice = RxDouble(
      double.tryParse(
            getFilterData.value.budget!.minPrice!
                .replaceAll(',', '')
                .replaceAll('\$', ''),
          ) ??
          0.0,
    );

    RxDouble newMaxPrice = RxDouble(
      (double.tryParse(
            getFilterData.value.budget!.maxPrice!
                .replaceAll(',', '')
                .replaceAll('\$', ''),
          ) ??
          0.0),
    );
    if (newMinPrice.value != budgetValues.value.start.round() ||
        newMaxPrice.value != budgetValues.value.end.round()) {
      mainList.insert(
        0,
        '\$ ${budgetValues.value.start.round()} - \$ ${budgetValues.value.end.round()}',
      );
    }
    mainList.addAll([
      ...makeModelFilterList,
      ...brandsFilterList,
      ...fuelFiltersList,
      ...modelYearFiltersList,
      ...rtoFiltersList,
      ...bodyTypeFiltersList,
      ...transmissionFiltersList,
      ...ownerFiltersList,
      ...seatFiltersList,
      ...kmDrivenFiltersList,
      ...colorFiltersList,
    ]);
    print(mainList);
    await matchBrand();
    if (type == 'Used Car') {
      await _usedCarController.getUsedCarListData(
        carModel: makeModelFilterList.toList(),
        carBrand: newBrandFilterList.toList(),
        fuelType: fuelFiltersList.toList(),
        modelYear: modelYearFiltersList.toList(),
        rto: rtoFiltersList.toList(),
        bodyType: bodyTypeFiltersList.toList(),
        transmissions: transmissionFiltersList.toList(),
        owners: ownerFiltersList.toList(),
        seats: seatFiltersList.toList(),
        kmDriven: kmDrivenFiltersList.toList(),
        color: colorFiltersList.toList(),
        minPrice: budgetValues.value.start,
        maxPrice: budgetValues.value.end,
      );
      Get.back();
    } else {
      await _newCarController.getNewCarListData(
        carModel: makeModelFilterList.toList(),
        carBrand: newBrandFilterList.toList(),
        fuelType: fuelFiltersList.toList(),
        modelYear: modelYearFiltersList.toList(),
        rto: rtoFiltersList.toList(),
        bodyType: bodyTypeFiltersList.toList(),
        transmissions: transmissionFiltersList.toList(),
        owners: ownerFiltersList.toList(),
        seats: seatFiltersList.toList(),
        kmDriven: kmDrivenFiltersList.toList(),
        color: colorFiltersList.toList(),
        minPrice: budgetValues.value.start,
        maxPrice: budgetValues.value.end,
      );
      Get.back();
    }
  }

  removeMainData({required String data, type}) async {
    mainList.remove(data);
    await checkDataList();
    await matchBrand();
    if (type == 'Used Car') {
      await _usedCarController.getUsedCarListData(
        carModel: makeModelFilterList.toList(),
        carBrand: newBrandFilterList.toList(),
        fuelType: fuelFiltersList.toList(),
        modelYear: modelYearFiltersList.toList(),
        rto: rtoFiltersList.toList(),
        bodyType: bodyTypeFiltersList.toList(),
        transmissions: transmissionFiltersList.toList(),
        owners: ownerFiltersList.toList(),
        seats: seatFiltersList.toList(),
        kmDriven: kmDrivenFiltersList.toList(),
        color: colorFiltersList.toList(),
        minPrice: budgetValues.value.start,
        maxPrice: budgetValues.value.end,
      );
      Get.back();
    } else {
      await _newCarController.getNewCarListData(
        carModel: makeModelFilterList.toList(),
        carBrand: newBrandFilterList.toList(),
        fuelType: fuelFiltersList.toList(),
        modelYear: modelYearFiltersList.toList(),
        rto: rtoFiltersList.toList(),
        bodyType: bodyTypeFiltersList.toList(),
        transmissions: transmissionFiltersList.toList(),
        owners: ownerFiltersList.toList(),
        seats: seatFiltersList.toList(),
        kmDriven: kmDrivenFiltersList.toList(),
        color: colorFiltersList.toList(),
        minPrice: budgetValues.value.start,
        maxPrice: budgetValues.value.end,
      );
      Get.back();
    }
    print(mainList);
  }

  checkDataList() {
    if (mainList.isNotEmpty) {
      if (mainList[0].startsWith('\$')) {
        print("The first value starts with the dollar sign.");
      } else {
        minPrice.value =
            double.tryParse(
              getFilterData.value.budget!.minPrice!
                  .replaceAll(',', '')
                  .replaceAll('\$', ''),
            ) ??
            0;
        maxPrice.value =
            double.tryParse(
              getFilterData.value.budget!.maxPrice!
                  .replaceAll(',', '')
                  .replaceAll('\$', ''),
            ) ??
            0;

        if (minPrice.value <= maxPrice.value) {
          budgetValues.value = RangeValues(minPrice.value, maxPrice.value);
        } else {
          budgetValues.value = RangeValues(0, 10);
        }
      }
    } else {
      minPrice.value =
          double.tryParse(
            getFilterData.value.budget!.minPrice!
                .replaceAll(',', '')
                .replaceAll('\$', ''),
          ) ??
          0;
      maxPrice.value =
          double.tryParse(
            getFilterData.value.budget!.maxPrice!
                .replaceAll(',', '')
                .replaceAll('\$', ''),
          ) ??
          0;

      if (minPrice.value <= maxPrice.value) {
        budgetValues.value = RangeValues(minPrice.value, maxPrice.value);
      } else {
        budgetValues.value = RangeValues(0, 10);
      }
    }
    makeModelFilterList.retainWhere((item) => mainList.contains(item));
    brandsFilterList.retainWhere((item) => mainList.contains(item));
    fuelFiltersList.retainWhere((item) => mainList.contains(item));
    modelYearFiltersList.retainWhere((item) => mainList.contains(item));
    rtoFiltersList.retainWhere((item) => mainList.contains(item));
    bodyTypeFiltersList.retainWhere((item) => mainList.contains(item));
    transmissionFiltersList.retainWhere((item) => mainList.contains(item));
    ownerFiltersList.retainWhere((item) => mainList.contains(item));
    seatFiltersList.retainWhere((item) => mainList.contains(item));
    kmDrivenFiltersList.retainWhere((item) => mainList.contains(item));
    colorFiltersList.retainWhere((item) => mainList.contains(item));

    for (var filter in makeModelList) {
      if (makeModelFilterList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in brandsList) {
      if (brandsFilterList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in fuelFilters) {
      if (fuelFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in modelYearFilters) {
      if (modelYearFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in rtoFilters) {
      if (rtoFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in bodyTypeFilters) {
      if (bodyTypeFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in transmissionFilters) {
      if (transmissionFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in ownerFilters) {
      if (ownerFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in seatFilters) {
      if (seatFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in kmDrivenFilters) {
      if (kmDrivenFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
    for (var filter in colorFilters) {
      if (colorFiltersList.contains(filter.title)) {
        filter.clicked.value = true;
      } else {
        filter.clicked.value = false;
      }
    }
  }

  clearDataInit() async {
    makeModelList.clear();
    brandsList.clear();
    fuelFilters.clear();
    modelYearFilters.clear();
    rtoFilters.clear();
    bodyTypeFilters.clear();
    transmissionFilters.clear();
    ownerFilters.clear();
    seatFilters.clear();
    kmDrivenFilters.clear();
    colorFilters.clear();
    mainList.clear();
    showMakeModelList = false.obs;
    showFuelFilters = false.obs;
    showModelYearFilters = false.obs;
    showRtoFilters = false.obs;
    showBodyTypeFilters = false.obs;
    showTransmissionFilters = false.obs;
    showOwnerFilters = false.obs;
    showSeatFilters = false.obs;
    showKmDrivenFilters = false.obs;
    showColorFilters = false.obs;
    showBrandsList = false.obs;
    showBudgetSlider = false.obs;
    minPrice = 0.0.obs;
    maxPrice = 0.0.obs;
    budgetValues = RangeValues(0, 10).obs;
    makeModelFilterList.retainWhere((item) => mainList.contains(item));
    brandsFilterList.retainWhere((item) => mainList.contains(item));
    fuelFiltersList.retainWhere((item) => mainList.contains(item));
    modelYearFiltersList.retainWhere((item) => mainList.contains(item));
    rtoFiltersList.retainWhere((item) => mainList.contains(item));
    bodyTypeFiltersList.retainWhere((item) => mainList.contains(item));
    transmissionFiltersList.retainWhere((item) => mainList.contains(item));
    ownerFiltersList.retainWhere((item) => mainList.contains(item));
    seatFiltersList.retainWhere((item) => mainList.contains(item));
    kmDrivenFiltersList.retainWhere((item) => mainList.contains(item));
    colorFiltersList.retainWhere((item) => mainList.contains(item));
    await matchBrand();
    await _usedCarController.getUsedCarListData(
      carModel: makeModelFilterList.toList(),
      carBrand: newBrandFilterList.toList(),
      fuelType: fuelFiltersList.toList(),
      modelYear: modelYearFiltersList.toList(),
      rto: rtoFiltersList.toList(),
      bodyType: bodyTypeFiltersList.toList(),
      transmissions: transmissionFiltersList.toList(),
      owners: ownerFiltersList.toList(),
      seats: seatFiltersList.toList(),
      kmDriven: kmDrivenFiltersList.toList(),
      color: colorFiltersList.toList(),
      maxPrice: 0,
      minPrice: 0,
    );

    await _newCarController.getNewCarListData(
      carModel: makeModelFilterList.toList(),
      carBrand: newBrandFilterList.toList(),
      fuelType: fuelFiltersList.toList(),
      modelYear: modelYearFiltersList.toList(),
      rto: rtoFiltersList.toList(),
      bodyType: bodyTypeFiltersList.toList(),
      transmissions: transmissionFiltersList.toList(),
      owners: ownerFiltersList.toList(),
      seats: seatFiltersList.toList(),
      kmDriven: kmDrivenFiltersList.toList(),
      color: colorFiltersList.toList(),
      maxPrice: 0,
      minPrice: 0,
    );
  }

  matchBrand() {
    newBrandFilterList.clear();
    for (var brandName in brandsFilterList) {
      var matchedBrand = getFilterData.value.brand?.firstWhere(
        (e) => e.brandName == brandName,
      );

      if (matchedBrand != null) {
        newBrandFilterList.add('${matchedBrand.brandId}');
      }
    }

    print(newBrandFilterList);
  }
}
