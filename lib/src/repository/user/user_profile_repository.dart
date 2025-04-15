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

class UserRepository {
  final ApiClient _apiClient = ApiClient();

  Future<DataState<UserModel?>> getUserData() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      final response = await _apiClient.get(Endpoints.userProfile);
      final result = CommonModel.fromMap(
        response,
        handlerWithMessage: (data, message) {
          return UserModel.fromJson(data);
        },
      );
      if (result.success) {
        return DataState.success(result.data);
      } else {
        throw ApiException(Failure.failure(500, result.message));
      }
    } on ApiException catch (e) {
      return DataState.failure(e.failure);
    } catch (e) {
      return DataState.failure(Failure.failure(500));
    }
  }

  String getFileMediaType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      return 'image/$extension';
    } else {
      return 'application/pdf';
    }
  }

  Future<DataState<String>> editProfileData({
    String? firstName,
    String? lastName,
    String? countryCode,
    String? phoneNumber,
    String? email,
    String? address,
    String profileImage = '',
    String userLicense = '',
    String? guardianName,
    String guardianLicense = '',
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      dynamic data = {
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'country_code': countryCode,
        'email': email,
        'address': address,
        'guardian_name': guardianName,
      };
      MultipartFile? fileUserLicence;
      MultipartFile? fileGuardianLicense;
      MultipartFile? fileProfileImage;

      if (profileImage != "") {
        final mediaType = getFileMediaType(profileImage);
        fileProfileImage = await MultipartFile.fromFile(
          profileImage,
          contentType: MediaType.parse(mediaType),
        );
        data = {...data, "profile_image": fileProfileImage};
      }
      if (userLicense != "") {
        final mediaType = getFileMediaType(userLicense);

        fileUserLicence = await MultipartFile.fromFile(
          userLicense,
          contentType: MediaType.parse(mediaType),
        );
        data = {...data, "user_license": fileUserLicence};
      }
      if (guardianLicense != "") {
        final mediaType = getFileMediaType(guardianLicense);

        fileGuardianLicense = await MultipartFile.fromFile(
          guardianLicense,
          contentType: MediaType.parse(mediaType),
        );

        data = {...data, "guardian_license": fileGuardianLicense};
      }

      if (guardianLicense != '' || profileImage != '' || userLicense != '') {
        data = FormData.fromMap({...data});
      }

      final response = await _apiClient.put(Endpoints.userProfile, data: data);
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

  Future<DataState<String>> resetPassword({
    required String oldPwd,
    required String newPwd,
    required String comPwd,
  }) async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }
      dynamic data = {
        'old_password': oldPwd,
        'new_password': newPwd,
        'confirm_password': comPwd,
      };

      final response = await _apiClient.put(
        Endpoints.resetPassword,
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

  Future<DataState<String>> deleteAccount() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }

      final response = await _apiClient.delete(Endpoints.userProfile);
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

  Future<DataState<String>> logOut() async {
    try {
      if (!await NetworkService.instance.isInternetAvailable) {
        return DataState.failure(Failure.noInternet());
      }

      final response = await _apiClient.post(
        Endpoints.userLogout,
        data: {'device_type': 'mobile'},
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
}
