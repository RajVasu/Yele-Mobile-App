import 'package:get/get.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController(), permanent: true);
  }
}
