import 'package:get/get.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart';
import 'package:yele/src/features/user/home/controller/user_home_controller.dart';
import 'package:yele/src/features/user/new_car/controller/new_car_controller.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';
import 'package:yele/src/features/user/used_car/controller/used_car_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(UserHomeController(), permanent: true);
    Get.put(UsedCarController(), permanent: true);
    Get.put(NewCarController(), permanent: true);
  }
}
