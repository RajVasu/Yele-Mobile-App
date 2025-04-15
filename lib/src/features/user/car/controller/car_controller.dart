import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/config/constants/assets.dart';

class CarController extends GetxController {
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
}
