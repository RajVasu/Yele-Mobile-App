import 'package:get/get.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';
import 'package:yele/src/features/user/home/model/get_browse_type_model.dart';
import 'package:yele/src/features/user/home/model/get_car_brand_list_model.dart';
import 'package:yele/src/features/user/home/model/get_car_model_list_model.dart';
import 'package:yele/src/repository/user/user_home_repository.dart';

class UserHomeController extends GetxController {
  final UserHomeRepository _homeRepository = UserHomeRepository();
  RxList<GetCarBrandListModel> carBrandList = <GetCarBrandListModel>[].obs;
  RxList<GetCarModelListModel> carModelList = <GetCarModelListModel>[].obs;
  RxList<GetBrowseTypeModel> browseTypeList = <GetBrowseTypeModel>[].obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future getData() async {
    Future.wait([
      getCarBrandListData(),
      getCarModelListData(),
      getBrowseTypeData(),
    ]);
  }

  Future<void> getCarBrandListData() async {
    carBrandList.clear();

    final result = await _homeRepository.getCarBrandList();
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    carBrandList.addAll(result.data.toList());
    update();
  }

  Future<void> getCarModelListData() async {
    carModelList.clear();

    final result = await _homeRepository.getCarModelList();
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    carModelList.addAll(result.data.toList());
    update();
  }

  Future<void> getBrowseTypeData() async {
    browseTypeList.clear();

    final result = await _homeRepository.getBrowseTypeList();
    if (result.isFailure) {
      errorSnackBar(message: result.failure.message);
      return;
    }
    browseTypeList.addAll(result.data.toList());
    update();
  }
}
