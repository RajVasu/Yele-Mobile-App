import 'package:get/get.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart';
import 'package:yele/src/features/user/home/controller/user_home_controller.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(UserHomeController(), permanent: true);
  }
}
