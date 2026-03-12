import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/features/dashboard/data/models/balance_model.dart';
import 'package:smart_spent_story/features/dashboard/data/models/spending_category_model.dart';

abstract class DashboardLocalDataSource {
  Future<void> cacheBalance(BalanceModel balance);
  Future<BalanceModel> getCachedBalance();
  Future<void> cacheSpendingCategories(List<SpendingCategoryModel> categories);
  Future<List<SpendingCategoryModel>> getCachedSpendingCategories();
}

const String cachedBalanceKey = 'CACHED_BALANCE';
const String cachedSpendingCategoriesKey = 'CACHED_SPENDING_CATEGORIES';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final SharedPreferences sharedPreferences;

  DashboardLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheBalance(BalanceModel balance) async {
    final jsonString = json.encode(balance.toJson());
    await sharedPreferences.setString(cachedBalanceKey, jsonString);
  }

  @override
  Future<BalanceModel> getCachedBalance() async {
    final jsonString = sharedPreferences.getString(cachedBalanceKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return BalanceModel.fromJson(jsonMap);
    }
    throw const CacheException('No cached balance found');
  }

  @override
  Future<void> cacheSpendingCategories(
      List<SpendingCategoryModel> categories) async {
    final jsonList = categories.map((c) => c.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cachedSpendingCategoriesKey, jsonString);
  }

  @override
  Future<List<SpendingCategoryModel>> getCachedSpendingCategories() async {
    final jsonString =
        sharedPreferences.getString(cachedSpendingCategoriesKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) =>
              SpendingCategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    throw const CacheException('No cached spending categories found');
  }
}
