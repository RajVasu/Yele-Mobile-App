import 'package:yele/src/api/api_client.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/api/exception/api_exception.dart';
import 'package:yele/src/api/failure/failure.dart';
import 'package:yele/src/api/state/data_state.dart';
import 'package:yele/src/core/model/common_model.dart';
import 'package:yele/src/core/services/network_service.dart';
import 'package:yele/src/features/user/car/model/get_car_list_model.dart';
import 'package:yele/src/features/user/car/model/get_car_model.dart';

class UserCarRepository {
  final ApiClient _apiClient = ApiClient();

  Future<DataState<GetCarListModel>> getCarList({
    required int page,
    required String carType,
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(
        Endpoints.carList,
        queryParameters: {
          'page': page,
          'car_type': carType,
          'api_type': 'app',
          'page_size': '5',
        },
      );
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return GetCarListModel.fromJson(data);
        },
      );
      if (result.success) {
        return DataState.success(result.data!);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  Future<DataState<GetCarModel>> getCarData({carId}) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get('${Endpoints.carDetail}/$carId');
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return GetCarModel.fromJson(data);
        },
      );
      if (result.success) {
        return DataState.success(result.data!);
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
