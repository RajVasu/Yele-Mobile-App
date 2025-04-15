import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/features/user/filter/screens/filter_screen.dart';

class FilterController extends GetxController {
  RxBool showMakeModelList = true.obs;

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

  List<FilterListModel> makeModelList = <FilterListModel>[
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
  ];

  List<FilterListModel> brandsList = <FilterListModel>[
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
    FilterListModel(title: 'Volkswagen Ameo', clicked: false.obs),
  ];

  List<FilterListModel> fuelFilters = [
    FilterListModel(title: 'Petrol', clicked: false.obs),
    FilterListModel(title: 'Diesel', clicked: false.obs),
    FilterListModel(title: 'CNG', clicked: false.obs),
    FilterListModel(title: 'Electric', clicked: false.obs),
    FilterListModel(title: 'Hybrid', clicked: false.obs),
  ];

  List<FilterListModel> modelYearFilters = [
    FilterListModel(title: '2023', clicked: false.obs),
    FilterListModel(title: '2022', clicked: false.obs),
    FilterListModel(title: '2021', clicked: false.obs),
    FilterListModel(title: '2020', clicked: false.obs),
    FilterListModel(title: '2019', clicked: false.obs),
    FilterListModel(title: '2018', clicked: false.obs),
    FilterListModel(title: '2017', clicked: false.obs),
  ];

  List<FilterListModel> featureFilters = [
    FilterListModel(title: 'Sunroof', clicked: false.obs),
    FilterListModel(title: 'Bluetooth', clicked: false.obs),
    FilterListModel(title: 'Leather Seats', clicked: false.obs),
    FilterListModel(title: 'Navigation System', clicked: false.obs),
    FilterListModel(title: 'Rear Camera', clicked: false.obs),
    FilterListModel(title: 'Parking Sensors', clicked: false.obs),
    FilterListModel(title: 'Heated Seats', clicked: false.obs),
    FilterListModel(title: 'Apple CarPlay', clicked: false.obs),
  ];

  List<FilterListModel> rtoFilters = [
    FilterListModel(title: 'Delhi', clicked: false.obs),
    FilterListModel(title: 'Mumbai', clicked: false.obs),
    FilterListModel(title: 'Bangalore', clicked: false.obs),
    FilterListModel(title: 'Chennai', clicked: false.obs),
    FilterListModel(title: 'Kolkata', clicked: false.obs),
    FilterListModel(title: 'Hyderabad', clicked: false.obs),
    FilterListModel(title: 'Pune', clicked: false.obs),
    FilterListModel(title: 'Ahmedabad', clicked: false.obs),
  ];

  List<FilterListModel> bodyTypeFilters = [
    FilterListModel(title: 'Sedan', clicked: false.obs),
    FilterListModel(title: 'SUV', clicked: false.obs),
    FilterListModel(title: 'Hatchback', clicked: false.obs),
    FilterListModel(title: 'Coupe', clicked: false.obs),
    FilterListModel(title: 'Convertible', clicked: false.obs),
    FilterListModel(title: 'Wagon', clicked: false.obs),
    FilterListModel(title: 'Pickup', clicked: false.obs),
  ];

  List<FilterListModel> transmissionFilters = [
    FilterListModel(title: 'Automatic', clicked: false.obs),
    FilterListModel(title: 'Manual', clicked: false.obs),
    FilterListModel(title: 'CVT', clicked: false.obs),
    FilterListModel(title: 'Dual-clutch', clicked: false.obs),
  ];

  List<FilterListModel> ownerFilters = [
    FilterListModel(title: '1st Owner', clicked: false.obs),
    FilterListModel(title: '2nd Owner', clicked: false.obs),
    FilterListModel(title: '3rd Owner', clicked: false.obs),
    FilterListModel(title: 'More than 3 Owners', clicked: false.obs),
  ];

  List<FilterListModel> seatFilters = [
    FilterListModel(title: '2 Seater', clicked: false.obs),
    FilterListModel(title: '4 Seater', clicked: false.obs),
    FilterListModel(title: '5 Seater', clicked: false.obs),
    FilterListModel(title: '7 Seater', clicked: false.obs),
    FilterListModel(title: '8 Seater', clicked: false.obs),
  ];

  List<FilterListModel> kmDrivenFilters = [
    FilterListModel(title: 'Less than 10,000 km', clicked: false.obs),
    FilterListModel(title: '10,000 - 30,000 km', clicked: false.obs),
    FilterListModel(title: '30,000 - 50,000 km', clicked: false.obs),
    FilterListModel(title: '50,000 - 75,000 km', clicked: false.obs),
    FilterListModel(title: '75,000 - 100,000 km', clicked: false.obs),
    FilterListModel(title: 'More than 100,000 km', clicked: false.obs),
  ];

  List<FilterListModel> colorFilters = [
    FilterListModel(title: 'Red', clicked: false.obs),
    FilterListModel(title: 'Black', clicked: false.obs),
    FilterListModel(title: 'White', clicked: false.obs),
    FilterListModel(title: 'Blue', clicked: false.obs),
    FilterListModel(title: 'Silver', clicked: false.obs),
    FilterListModel(title: 'Grey', clicked: false.obs),
    FilterListModel(title: 'Green', clicked: false.obs),
    FilterListModel(title: 'Yellow', clicked: false.obs),
    FilterListModel(title: 'Orange', clicked: false.obs),
  ];

  RxBool showBudgetSlider = true.obs;
  RxDouble currentBudget = 100000.0.obs;

  RangeValues budgetValues = RangeValues(100000, 350000);
  /*  final List<double> budgetValues = [
    100000,
    150000,
    200000,
    250000,
    300000,
    350000,
  ]; */
}
