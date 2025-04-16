import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:yele/src/api/api_client.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/api/exception/api_exception.dart';
import 'package:yele/src/api/failure/failure.dart';
import 'package:yele/src/api/state/data_state.dart';
import 'package:yele/src/core/model/common_model.dart';
import 'package:yele/src/core/services/network_service.dart';
import 'package:yele/src/features/auth/login/model/user_model.dart';
import 'package:yele/src/features/auth/register/model/get_dealer_list_modal.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  String getFileMediaType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      return 'image/$extension';
    } else {
      return 'application/pdf';
    }
  }
  //******************************************************** Login ********************************************************//

  Future<DataState<UserModel>> login(Map<String, dynamic> data) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(Endpoints.login, data: data);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return UserModel.fromJson(data, message: message);
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

  //******************************************************** Forgot Password ********************************************************//

  Future<DataState<String>> sendOtp(Map<String, dynamic> data) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(Endpoints.sendOtp, data: data);
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

  Future<DataState<String>> verfiyOtp(Map<String, dynamic> data) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(Endpoints.verifyOtp, data: data);
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

  Future<DataState<String>> forgotPassword(Map<String, dynamic> data) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(
        Endpoints.forgotPassword,
        data: data,
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

  //******************************************************** User Role ********************************************************//

  Future<DataState<UserModel>> userRegister({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String address,
    required String password,
    required String userLicense,
    String? guardianName,
    String? guardianLicense,
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }

      dynamic data = {
        'first_name': firstName,
        'last_name': lastName,
        'user_role': 1,
        'country_code': countryCode,
        'phone_number': phoneNumber,
        'email': email,
        'address': address,
        'password': password,
        'guardian_name': guardianName,
        'device_type': 'mobile,',
      };
      final mediaType = getFileMediaType(userLicense);
      MultipartFile fileUserLicence = await MultipartFile.fromFile(
        userLicense,
        contentType: MediaType.parse(mediaType),
      );

      MultipartFile? fileGuardianLicense;
      if (guardianLicense != "") {
        final mediaType = getFileMediaType(guardianLicense!);

        fileUserLicence = await MultipartFile.fromFile(
          guardianLicense,
          contentType: MediaType.parse(mediaType),
        );
      }
      data = FormData.fromMap({
        ...data,
        'user_license': fileUserLicence,
        'guardian_license': fileGuardianLicense,
      });
      final response = await _apiClient.post(
        Endpoints.userRegister,
        data: data,
      );
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return UserModel.fromJson(data, message: message);
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

  Future<DataState<String>> sendMail(Map<String, dynamic> data) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(Endpoints.sendMail, data: data);
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

  Future<DataState<String>> verifyEmail(Map<String, dynamic> data) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.post(Endpoints.verifyMail, data: data);
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

  //******************************************************** Dealer Role ********************************************************//

  Future<DataState<UserModel>> dealerRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String dealership,
    required String countryCode,
    required String phoneNumber,
    required String comment,
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }

      dynamic data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'dealership': dealership,
        'country_code': countryCode,
        'phone_number': phoneNumber,
        'user_role': 2,
        'comment': comment,
        'device_type': 'mobile,',
      };

      final response = await _apiClient.post(
        Endpoints.dealerRegister,
        data: data,
      );
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return UserModel.fromJson(data, message: message);
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

  //******************************************************** Driver Role ********************************************************//

  Future<DataState<UserModel>> driverRegister({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String password,
    required String userName,
    required String dealer,
    required String driverLicense,
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }

      dynamic data = {
        'first_name': firstName,
        'last_name': lastName,
        'user_role': 3,
        'country_code': countryCode,
        'phone_number': phoneNumber,
        'email': email,
        'password': password,
        'username': userName,
        'dealer': dealer,
        'device_type': 'mobile,',
      };
      final mediaType = getFileMediaType(driverLicense);
      MultipartFile fileUserLicence = await MultipartFile.fromFile(
        driverLicense,
        contentType: MediaType.parse(mediaType),
      );

      data = FormData.fromMap({...data, 'driver_license': fileUserLicence});
      final response = await _apiClient.post(
        Endpoints.driverRegister,
        data: data,
      );
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return UserModel.fromJson(data, message: message);
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

  Future<DataState<List<GetDealerListModal>>> getDealerList() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(Endpoints.driverDealerList);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return List.from(
            data,
          ).map((e) => GetDealerListModal.fromJson(e)).toList();
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
