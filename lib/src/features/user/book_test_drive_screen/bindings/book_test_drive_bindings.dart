import 'package:get/get.dart';
import 'package:yele/src/features/user/book_test_drive_screen/controller/book_test_drive_controller.dart';

class BookTestDriveBindings extends Bindings {
  @override
  void dependencies() {
    Get.put( BookTestDriveController(), permanent: true);
  }
}
