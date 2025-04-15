import 'package:get/get.dart';
import 'package:yele/src/features/driver/driver_home/controller/driver_home_controller.dart';

class DriverHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DriverHomeController(), permanent: true);
  }
}
