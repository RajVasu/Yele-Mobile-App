import 'package:yele/src/api/api_client.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/api/exception/api_exception.dart';
import 'package:yele/src/api/failure/failure.dart';
import 'package:yele/src/api/state/data_state.dart';
import 'package:yele/src/core/model/common_model.dart';
import 'package:yele/src/core/services/network_service.dart';
import 'package:yele/src/features/user/car/model/get_car_list_model.dart';
import 'package:yele/src/features/user/car/model/get_car_model.dart';
import 'package:yele/src/features/user/filter/model/get_filter_model.dart';

class UserCarRepository {
  final ApiClient _apiClient = ApiClient();

  Future<DataState<GetCarListModel>> getCarList({
    required int page,
    required String carType,
    List? carBrand,
    List? carModel,
    List? fuelType,
    List? modelYear,
    List? bodyType,
    List? transmissions,
    List? owners,
    List? seats,
    List? kmDriven,
    List? color,
    List? rto,
    dynamic minPrice,
    dynamic maxPrice,
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
          'car_brand': carBrand?.toString() ?? [].toString(),
          'car_model':
              carModel?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'fuel_type':
              fuelType?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'model_year': modelYear?.toString() ?? [].toString(),
          'body_type': bodyType?.toString() ?? [].toString(),
          'transmissions': transmissions?.toString() ?? [].toString(),
          'owners': owners?.toString() ?? [].toString(),
          'seats': seats?.toString() ?? [].toString(),
          'km_driven': kmDriven?.toString() ?? [].toString(),
          'color': color?.toString() ?? [].toString(),
          'rto': rto?.toString() ?? [].toString(),
          'min_price': minPrice,
          'max_price': maxPrice,
        },
      );
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return GetCarListModel.fromJson(data);
        },
      );
      if (result.success) {
        return DataState.success(
          result.data! /* ??
              GetCarListModel(
                carListData: [],
                page: 1,
                pageSize: 5,
                total: 0,
                totalPages: 0,
              ), */,
        );
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

  Future<DataState<GetFilterModel>> getFilterData() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(Endpoints.filterOption);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return GetFilterModel.fromJson(data);
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
