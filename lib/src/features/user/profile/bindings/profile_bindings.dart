import 'package:get/get.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(), permanent: true);
  }
}
