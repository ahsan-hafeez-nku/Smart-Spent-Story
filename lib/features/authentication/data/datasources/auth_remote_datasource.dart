import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/network/api_endpoints.dart';
import 'package:smart_spent_story/features/authentication/data/models/auth_response_model.dart';
import 'package:smart_spent_story/features/authentication/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  const AuthRemoteDatasourceImpl({required this.dio});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      final authResponse =
          AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
      return authResponse.user;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] as String? ?? 'Login failed',
      );
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      final authResponse =
          AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
      return authResponse.user;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] as String? ?? 'Registration failed',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] as String? ?? 'Logout failed',
      );
    }
  }
}
