import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/configs/env_config.dart';
import 'package:smart_spent_story/core/constants/api_constants.dart';
import 'package:smart_spent_story/core/network/interceptors/auth_interceptor.dart';
import 'package:smart_spent_story/core/network/interceptors/logging_interceptor.dart';
import 'package:smart_spent_story/core/network/interceptors/error_interceptor.dart';

class DioProvider {
  static Dio createDio({EnvConfig config = EnvConfig.development}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  }
}
