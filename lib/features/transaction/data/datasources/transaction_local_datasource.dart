import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/features/transaction/data/models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<void> cacheTransactions(List<TransactionModel> transactions);
  Future<List<TransactionModel>> getCachedTransactions();
  Future<void> clearTransactionCache();
}

const String cachedTransactionsKey = 'CACHED_TRANSACTIONS';

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final SharedPreferences sharedPreferences;

  TransactionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheTransactions(List<TransactionModel> transactions) async {
    final jsonList = transactions.map((t) => t.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cachedTransactionsKey, jsonString);
  }

  @override
  Future<List<TransactionModel>> getCachedTransactions() async {
    final jsonString = sharedPreferences.getString(cachedTransactionsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) =>
              TransactionModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    throw const CacheException('No cached transactions found');
  }

  @override
  Future<void> clearTransactionCache() async {
    await sharedPreferences.remove(cachedTransactionsKey);
  }
}
