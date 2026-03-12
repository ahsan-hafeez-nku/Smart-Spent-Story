import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/ai_insight_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/balance_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/spending_category_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/upcoming_bill_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, BalanceEntity>> getBalance();
  Future<Either<Failure, List<SpendingCategoryEntity>>> getSpendingCategories();
  Future<Either<Failure, List<UpcomingBillEntity>>> getUpcomingBills();
  Future<Either<Failure, List<AiInsightEntity>>> getAiInsights();
}
