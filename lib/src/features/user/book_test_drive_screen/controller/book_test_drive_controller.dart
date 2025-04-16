import 'package:get/get.dart';

class BookTestDriveController extends GetxController {
  Rx<DateTime> selectedDay = (DateTime.now()).obs;
  Rx<DateTime> focusedDay = (DateTime.now()).obs;

  final DateTime firstDay = DateTime.now();
  final DateTime lastDay = DateTime.utc(2030, 12, 31);
}
