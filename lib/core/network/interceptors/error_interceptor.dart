import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const NetworkException('Connection timed out. Please try again.');
      case DioExceptionType.connectionError:
        throw const NetworkException('No internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;
        final message = data is Map ? data['message'] as String? : null;

        throw ServerException(
          message ?? 'Something went wrong.',
          statusCode: statusCode,
        );
      default:
        throw ServerException(
          err.message ?? 'An unexpected error occurred.',
        );
    }
  }
}
