import 'package:dio/dio.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/utils/log.dart';

class ApiInterceptors {
  InterceptorsWrapper get interceptorsWrapper {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        String token = Storage.instance.getToken() ?? '';
        Log.d(
            '-----------------------------------------------------------------------------------');
        Log.d('URI:- ${options.uri.toString()}');
        Log.d('DATA:- ${options.data.toString()}');
        Log.d('TOKEN:- $token');
        Log.d(
            '-----------------------------------------------------------------------------------');
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        Log.d(
            '-----------------------------------------------------------------------------------');
        Log.d('STATUS CODE:- ${response.statusCode}');
        Log.d('RESPONSE:- ${response.data}');
        Log.d(
            '-----------------------------------------------------------------------------------');
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        return handler.next(e);
      },
    );
  }
}
