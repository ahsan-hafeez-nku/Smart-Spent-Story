import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/features/authentication/data/models/user_model.dart';

const String _cachedUserKey = 'cached_user';
const String _accessTokenKey = 'access_token';

abstract class AuthLocalDatasource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getCachedUser();
  Future<void> clearCache();
  Future<void> cacheToken(String token);
  Future<String?> getToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;

  const AuthLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = json.encode(user.toJson());
    await sharedPreferences.setString(_cachedUserKey, jsonString);
  }

  @override
  Future<UserModel> getCachedUser() {
    final jsonString = sharedPreferences.getString(_cachedUserKey);
    if (jsonString == null) {
      throw const CacheException('No cached user found');
    }
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return Future.value(UserModel.fromJson(jsonMap));
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(_cachedUserKey);
    await sharedPreferences.remove(_accessTokenKey);
  }

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(_accessTokenKey, token);
  }

  @override
  Future<String?> getToken() {
    return Future.value(sharedPreferences.getString(_accessTokenKey));
  }
}
