import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';
import 'package:smart_spent_story/features/transaction/domain/repositories/transaction_repository.dart';

class AddTransactionUseCase
    implements UseCase<TransactionEntity, AddTransactionParams> {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionEntity>> call(
      AddTransactionParams params) {
    final entity = TransactionEntity(
      id: '',
      title: params.title,
      amount: params.amount,
      category: params.category,
      type: params.type,
      date: params.date,
      note: params.note,
    );
    return repository.addTransaction(entity);
  }
}

class AddTransactionParams extends Equatable {
  final String title;
  final double amount;
  final String category;
  final String type;
  final DateTime date;
  final String? note;

  const AddTransactionParams({
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [title, amount, category, type, date, note];
}
