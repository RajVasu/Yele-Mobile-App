import 'package:get/get.dart';
import 'package:yele/src/features/user/profile/controller/favorite_cars_controller.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';
import 'package:yele/src/features/user/profile/controller/saved_search_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(), permanent: true);
     Get.put(SavedSearchController(), permanent: true);
    Get.put(FavoriteCarsController(), permanent: true);
 
  }
}
