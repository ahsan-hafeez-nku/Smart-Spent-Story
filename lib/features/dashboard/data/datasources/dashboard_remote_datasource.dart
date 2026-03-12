import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/network/api_endpoints.dart';
import 'package:smart_spent_story/features/dashboard/data/models/ai_insight_model.dart';
import 'package:smart_spent_story/features/dashboard/data/models/balance_model.dart';
import 'package:smart_spent_story/features/dashboard/data/models/spending_category_model.dart';
import 'package:smart_spent_story/features/dashboard/data/models/upcoming_bill_model.dart';

abstract class DashboardRemoteDataSource {
  Future<BalanceModel> getBalance();
  Future<List<SpendingCategoryModel>> getSpendingCategories();
  Future<List<UpcomingBillModel>> getUpcomingBills();
  Future<List<AiInsightModel>> getAiInsights();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl({required this.dio});

  @override
  Future<BalanceModel> getBalance() async {
    try {
      final response = await dio.get(ApiEndpoints.balance);
      if (response.statusCode == 200) {
        return BalanceModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw ServerException('Failed to fetch balance');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<List<SpendingCategoryModel>> getSpendingCategories() async {
    try {
      final response = await dio.get(ApiEndpoints.spendingCategories);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) =>
                SpendingCategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw ServerException('Failed to fetch spending categories');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<List<UpcomingBillModel>> getUpcomingBills() async {
    try {
      final response = await dio.get(ApiEndpoints.upcomingBills);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) =>
                UpcomingBillModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw ServerException('Failed to fetch upcoming bills');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<List<AiInsightModel>> getAiInsights() async {
    try {
      final response = await dio.get(ApiEndpoints.aiInsights);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) =>
                AiInsightModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw ServerException('Failed to fetch AI insights');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    }
  }
}
