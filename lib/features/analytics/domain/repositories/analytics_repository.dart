import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/analytics_summary_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/category_spending_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/savings_trend_entity.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, AnalyticsSummaryEntity>> getAnalyticsSummary();
  Future<Either<Failure, List<CategorySpendingEntity>>> getCategorySpending();
  Future<Either<Failure, List<SavingsTrendEntity>>> getSavingsTrend();
}
