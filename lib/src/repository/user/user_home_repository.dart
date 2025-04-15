import 'package:yele/src/api/api_client.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/api/exception/api_exception.dart';
import 'package:yele/src/api/failure/failure.dart';
import 'package:yele/src/api/state/data_state.dart';
import 'package:yele/src/core/model/common_model.dart';
import 'package:yele/src/core/services/network_service.dart';
import 'package:yele/src/features/user/home/model/get_browse_type_model.dart';
import 'package:yele/src/features/user/home/model/get_car_brand_list_model.dart';
import 'package:yele/src/features/user/home/model/get_car_model_list_model.dart';

class UserHomeRepository {
  final ApiClient _apiClient = ApiClient();

  Future<DataState<List<GetCarBrandListModel>>> getCarBrandList() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(Endpoints.carBrandList);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return List.from(
            data,
          ).map((e) => GetCarBrandListModel.fromJson(e)).toList();
        },
      );
      if (result.success) {
        return DataState.success(result.data ?? []);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  Future<DataState<List<GetCarModelListModel>>> getCarModelList() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(Endpoints.carModelList);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return List.from(
            data,
          ).map((e) => GetCarModelListModel.fromJson(e)).toList();
        },
      );
      if (result.success) {
        return DataState.success(result.data ?? []);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  Future<DataState<List<GetBrowseTypeModel>>> getBrowseTypeList() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(Endpoints.carTypeList);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return List.from(
            data,
          ).map((e) => GetBrowseTypeModel.fromJson(e)).toList();
        },
      );
      if (result.success) {
        return DataState.success(result.data ?? []);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }
}
