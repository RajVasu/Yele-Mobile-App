import 'package:get/get.dart';
import 'package:yele/src/features/user/booked%20test%20drives/controller/booked_test_drives_controller.dart';

class BookedTestDrivesBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BookedTestDrivesController(), permanent: true);
  }
}
