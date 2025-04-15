import 'package:get/get.dart';
import 'package:yele/src/features/dealer/dealer_home/controller/dealer_home_controller.dart';

class DealerHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DealerHomeController(), permanent: true);
  }
}
