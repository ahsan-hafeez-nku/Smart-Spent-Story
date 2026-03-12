import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';
import 'package:smart_spent_story/features/transaction/domain/repositories/transaction_repository.dart';

class UpdateTransactionUseCase
    implements UseCase<TransactionEntity, TransactionEntity> {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionEntity>> call(
      TransactionEntity params) {
    return repository.updateTransaction(params);
  }
}
