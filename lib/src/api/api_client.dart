import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yele/src/api/api_introceptor.dart';
import 'package:yele/src/api/exception/api_exception.dart';
import 'package:yele/src/api/failure/failure.dart';
import 'package:yele/src/core/model/common_model.dart';


class ApiClient {
  static final List<int> _validStatusCode = [400, 401, 403, 404, 409];

  late Dio _dio;
  late ApiInterceptors _apiInterceptors;

  ApiClient() {
    _dio = Dio();
    _apiInterceptors = ApiInterceptors();
    _dio.options = BaseOptions(headers: {'Content-Type': 'application/json'});
    _dio.interceptors.add(_apiInterceptors.interceptorsWrapper);
  }

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response response = await _request(() async {
      Response response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });
    return response.data;
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response response = await _request(() async {
      Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });
    return response.data;
  }

  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response response = await _request(() async {
      Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });
    return response.data;
  }

  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response response = await _request(() async {
      Response response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });
    return response.data;
  }

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Response response = await _request(() async {
      Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    });
    return response.data;
  }

  Future<Response> _request(Future<Response> Function() handler) async {
    try {
      Response response = await handler();
      return response;
    } on DioException catch (e) {
      ApiException exception = _dioExceptionHandle(e);
      throw exception;
    } on TimeoutException {
      throw ApiException(Failure.failure(408));
    } on SocketException {
      throw ApiException(Failure.failure(500));
    } catch (e) {
      throw ApiException(Failure.failure(500));
    }
  }

  ApiException _dioExceptionHandle(DioException exception) {
    int statusCode = exception.response?.statusCode ?? 500;
    try {
      if (!_validStatusCode.contains(statusCode)) {
        return ApiException(Failure.failure(500));
      }
      final data = exception.response?.data;
      if (data == null) {
        return ApiException(Failure.failure(500));
      }
      final result = CommonModel.fromMap(data);
      return ApiException(Failure.failure(statusCode, result.message));
    } catch (e) {
      return ApiException(Failure.failure(500));
    }
  }
}
