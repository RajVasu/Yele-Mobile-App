import 'package:yele/src/api/api_client.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/api/exception/api_exception.dart';
import 'package:yele/src/api/failure/failure.dart';
import 'package:yele/src/api/state/data_state.dart';
import 'package:yele/src/core/model/common_model.dart';
import 'package:yele/src/core/services/network_service.dart';
import 'package:yele/src/features/user/car/model/get_car_compare_model.dart';
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
          'car_brand':
              carBrand?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'car_model':
              carModel?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'fuel_type':
              fuelType?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'model_year':
              modelYear?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'body_type':
              bodyType?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'transmissions':
              transmissions?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'owners':
              owners?.map((e) => '\'$e\'').toList().toString() ?? [].toString(),
          'seats':
              seats?.map((e) => '\'$e\'').toList().toString() ?? [].toString(),
          'km_driven':
              kmDriven?.map((e) => '\'$e\'').toList().toString() ??
              [].toString(),
          'color':
              color?.map((e) => '\'$e\'').toList().toString() ?? [].toString(),
          'rto': rto?.map((e) => '\'$e\'').toList().toString() ?? [].toString(),
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

  Future<DataState<List<GetCarCompareModel>>> getCarCompareData({carId}) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get('${Endpoints.carCompare}/$carId');
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return List.from(
            data,
          ).map((e) => GetCarCompareModel.fromJson(e)).toList();
        },
      );
      if (result.success) {
        return DataState.success(result.data! ?? []);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  Future<DataState<String>> addFavoriteCar({required int carId}) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(
        Endpoints.userFavoriteCar,
        data: {'car_id': carId},
      );
      final result = CommonModel.fromMap(response);
      if (result.success) {
        return DataState.success(result.message!);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  Future<DataState<String>> removeFavoriteCar({required int carId}) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.delete(
        Endpoints.userFavoriteCar,
        data: {'car_id': carId},
      );
      final result = CommonModel.fromMap(response);
      if (result.success) {
        return DataState.success(result.message!);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  Future<DataState<GetCarListModel>> getFavoriteCarList({
    required int page,
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(
        Endpoints.userFavoriteCar,
        queryParameters: {'page': page, 'api_type': 'app', 'page_size': '5'},
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
}
