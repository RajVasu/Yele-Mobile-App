import 'package:get/get.dart';
import 'package:yele/src/features/auth/forgot/controller/forgot_password_controller.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';
import 'package:yele/src/features/user/booked%20test%20drives/controller/booked_test_drives_controller.dart';
import 'package:yele/src/features/user/new_car/controller/new_car_controller.dart';

class InitailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController(), permanent: true);
    Get.put(RegisterController(), permanent: true);
    Get.put(NewCarController(), permanent: true);
    Get.put(BookedTestDrivesController(), permanent: true);
  }
}
