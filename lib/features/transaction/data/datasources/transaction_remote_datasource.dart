import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/network/api_endpoints.dart';
import 'package:smart_spent_story/features/transaction/data/models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions({
    int? limit,
    int? offset,
    String? category,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<TransactionModel> addTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TransactionModel>> getTransactions({
    int? limit,
    int? offset,
    String? category,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;
      if (category != null) queryParams['category'] = category;
      if (type != null) queryParams['type'] = type;
      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String();
      }

      final response = await dio.get(
        ApiEndpoints.transactions,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) =>
                TransactionModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw ServerException('Failed to fetch transactions');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<TransactionModel> addTransaction(TransactionModel transaction) async {
    try {
      final response = await dio.post(
        ApiEndpoints.transactions,
        data: transaction.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TransactionModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw ServerException('Failed to add transaction');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<TransactionModel> updateTransaction(
      TransactionModel transaction) async {
    try {
      final response = await dio.put(
        ApiEndpoints.transactionById(transaction.id),
        data: transaction.toJson(),
      );

      if (response.statusCode == 200) {
        return TransactionModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw ServerException('Failed to update transaction');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      final response = await dio.delete(ApiEndpoints.transactionById(id));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException('Failed to delete transaction');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }
}
