import 'package:get/get.dart';
import 'package:yele/src/features/user/new_car/controller/new_car_controller.dart';

class NewCarBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NewCarController(), permanent: true);
  }
}
