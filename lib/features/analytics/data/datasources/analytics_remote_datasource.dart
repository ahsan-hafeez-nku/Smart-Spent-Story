import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/network/api_endpoints.dart';
import 'package:smart_spent_story/features/analytics/data/models/analytics_summary_model.dart';
import 'package:smart_spent_story/features/analytics/data/models/category_spending_model.dart';
import 'package:smart_spent_story/features/analytics/data/models/savings_trend_model.dart';

abstract class AnalyticsRemoteDatasource {
  Future<AnalyticsSummaryModel> getAnalyticsSummary();
  Future<List<CategorySpendingModel>> getCategorySpending();
  Future<List<SavingsTrendModel>> getSavingsTrend();
}

class AnalyticsRemoteDatasourceImpl implements AnalyticsRemoteDatasource {
  final Dio dio;

  const AnalyticsRemoteDatasourceImpl({required this.dio});

  @override
  Future<AnalyticsSummaryModel> getAnalyticsSummary() async {
    try {
      final response = await dio.get(ApiEndpoints.analyticsSummary);
      return AnalyticsSummaryModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch analytics summary');
    }
  }

  @override
  Future<List<CategorySpendingModel>> getCategorySpending() async {
    try {
      final response = await dio.get(ApiEndpoints.categorySpending);
      final list = response.data['data'] as List<dynamic>;
      return list
          .map((e) =>
              CategorySpendingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch category spending');
    }
  }

  @override
  Future<List<SavingsTrendModel>> getSavingsTrend() async {
    try {
      final response = await dio.get(ApiEndpoints.savingsTrend);
      final list = response.data['data'] as List<dynamic>;
      return list
          .map((e) => SavingsTrendModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch savings trend');
    }
  }
}
