import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCarController extends GetxController {
  RxBool agreeRequestInfo = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
}
