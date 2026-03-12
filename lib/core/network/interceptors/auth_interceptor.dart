import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = GetIt.instance<SharedPreferences>();
    final token = prefs.getString(ApiConstants.accessTokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] =
          '${ApiConstants.authorizationPrefix} $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired — trigger refresh or logout
    }
    handler.next(err);
  }
}
