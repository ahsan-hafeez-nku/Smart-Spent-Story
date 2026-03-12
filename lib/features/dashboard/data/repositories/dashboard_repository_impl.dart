import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:smart_spent_story/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/ai_insight_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/balance_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/spending_category_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/upcoming_bill_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, BalanceEntity>> getBalance() async {
    try {
      final remoteBalance = await remoteDataSource.getBalance();
      await localDataSource.cacheBalance(remoteBalance);
      return Right(remoteBalance.toEntity());
    } on ServerException catch (e) {
      return _getBalanceFromCache(e.message);
    } on NetworkException catch (e) {
      return _getBalanceFromCache(e.message);
    }
  }

  Future<Either<Failure, BalanceEntity>> _getBalanceFromCache(
      String originalError) async {
    try {
      final cachedBalance = await localDataSource.getCachedBalance();
      return Right(cachedBalance.toEntity());
    } on CacheException {
      return Left(ServerFailure(originalError));
    }
  }

  @override
  Future<Either<Failure, List<SpendingCategoryEntity>>>
      getSpendingCategories() async {
    try {
      final remoteCategories =
          await remoteDataSource.getSpendingCategories();
      await localDataSource.cacheSpendingCategories(remoteCategories);
      return Right(remoteCategories.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return _getCategoriesFromCache(e.message);
    } on NetworkException catch (e) {
      return _getCategoriesFromCache(e.message);
    }
  }

  Future<Either<Failure, List<SpendingCategoryEntity>>>
      _getCategoriesFromCache(String originalError) async {
    try {
      final cachedCategories =
          await localDataSource.getCachedSpendingCategories();
      return Right(cachedCategories.map((m) => m.toEntity()).toList());
    } on CacheException {
      return Left(ServerFailure(originalError));
    }
  }

  @override
  Future<Either<Failure, List<UpcomingBillEntity>>> getUpcomingBills() async {
    try {
      final remoteBills = await remoteDataSource.getUpcomingBills();
      return Right(remoteBills.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AiInsightEntity>>> getAiInsights() async {
    try {
      final remoteInsights = await remoteDataSource.getAiInsights();
      return Right(remoteInsights.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
