import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/features/profile/data/models/profile_model.dart';

abstract class ProfileLocalDatasource {
  Future<void> cacheProfile(ProfileModel profile);
  Future<ProfileModel> getCachedProfile();
  Future<void> clearProfileCache();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final SharedPreferences sharedPreferences;

  static const String _cachedProfileKey = 'CACHED_PROFILE';

  const ProfileLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProfile(ProfileModel profile) async {
    await sharedPreferences.setString(
      _cachedProfileKey,
      jsonEncode(profile.toJson()),
    );
  }

  @override
  Future<ProfileModel> getCachedProfile() async {
    final jsonString = sharedPreferences.getString(_cachedProfileKey);
    if (jsonString == null) {
      throw const CacheException('No cached profile found');
    }
    return ProfileModel.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> clearProfileCache() async {
    await sharedPreferences.remove(_cachedProfileKey);
  }
}
