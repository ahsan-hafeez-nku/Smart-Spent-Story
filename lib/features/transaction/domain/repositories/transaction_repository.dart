import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransactions({
    int? limit,
    int? offset,
    String? category,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, TransactionEntity>> addTransaction(
      TransactionEntity transaction);

  Future<Either<Failure, TransactionEntity>> updateTransaction(
      TransactionEntity transaction);

  Future<Either<Failure, void>> deleteTransaction(String id);
}
