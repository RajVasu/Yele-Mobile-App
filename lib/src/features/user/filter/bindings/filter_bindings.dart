import 'package:get/get.dart';
import 'package:yele/src/features/user/filter/controller/filter_controller.dart';

class FilterBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FilterController(), permanent: true);
  }
}
