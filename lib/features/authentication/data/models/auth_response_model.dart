import 'package:smart_spent_story/features/authentication/data/models/user_model.dart';

class AuthResponseModel {
  final String token;
  final String? refreshToken;
  final UserModel user;

  const AuthResponseModel({
    required this.token,
    this.refreshToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
