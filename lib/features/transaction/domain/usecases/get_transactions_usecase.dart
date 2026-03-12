import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';
import 'package:smart_spent_story/features/transaction/domain/repositories/transaction_repository.dart';

class GetTransactionsUseCase
    implements UseCase<List<TransactionEntity>, GetTransactionsParams> {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(
      GetTransactionsParams params) {
    return repository.getTransactions(
      limit: params.limit,
      offset: params.offset,
      category: params.category,
      type: params.type,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetTransactionsParams extends Equatable {
  final int? limit;
  final int? offset;
  final String? category;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetTransactionsParams({
    this.limit,
    this.offset,
    this.category,
    this.type,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props =>
      [limit, offset, category, type, startDate, endDate];
}
