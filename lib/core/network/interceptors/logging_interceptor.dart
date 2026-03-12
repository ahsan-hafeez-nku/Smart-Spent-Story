import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      'REQUEST[${options.method}] => PATH: ${options.uri}\n'
      'Headers: ${options.headers}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}\n'
      'Data: ${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}\n'
      'Message: ${err.message}',
    );
    handler.next(err);
  }
}
