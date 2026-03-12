import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:smart_spent_story/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:smart_spent_story/features/transaction/data/models/transaction_model.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';
import 'package:smart_spent_story/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions({
    int? limit,
    int? offset,
    String? category,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final remoteTransactions = await remoteDataSource.getTransactions(
        limit: limit,
        offset: offset,
        category: category,
        type: type,
        startDate: startDate,
        endDate: endDate,
      );
      await localDataSource.cacheTransactions(remoteTransactions);
      return Right(remoteTransactions.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return _getTransactionsFromCache(e.message);
    } on NetworkException catch (e) {
      return _getTransactionsFromCache(e.message);
    }
  }

  Future<Either<Failure, List<TransactionEntity>>> _getTransactionsFromCache(
      String originalError) async {
    try {
      final cachedTransactions =
          await localDataSource.getCachedTransactions();
      return Right(cachedTransactions.map((m) => m.toEntity()).toList());
    } on CacheException {
      return Left(ServerFailure(originalError));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> addTransaction(
      TransactionEntity transaction) async {
    try {
      final model = TransactionModel.fromEntity(transaction);
      final result = await remoteDataSource.addTransaction(model);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> updateTransaction(
      TransactionEntity transaction) async {
    try {
      final model = TransactionModel.fromEntity(transaction);
      final result = await remoteDataSource.updateTransaction(model);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      await remoteDataSource.deleteTransaction(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
