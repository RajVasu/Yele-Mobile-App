import 'package:get/get.dart';
import 'package:yele/src/features/user/car/controller/car_controller.dart';

class CarBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CarController(), permanent: true);
  }
}
