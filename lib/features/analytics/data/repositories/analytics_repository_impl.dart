import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/analytics/data/datasources/analytics_remote_datasource.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/analytics_summary_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/category_spending_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/savings_trend_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsRemoteDatasource remoteDatasource;

  const AnalyticsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, AnalyticsSummaryEntity>> getAnalyticsSummary() async {
    try {
      final result = await remoteDatasource.getAnalyticsSummary();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategorySpendingEntity>>>
      getCategorySpending() async {
    try {
      final result = await remoteDatasource.getCategorySpending();
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<SavingsTrendEntity>>> getSavingsTrend() async {
    try {
      final result = await remoteDatasource.getSavingsTrend();
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
