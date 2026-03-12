import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionsLoaded extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionActionSuccess extends TransactionState {
  final String message;

  const TransactionActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TransactionFailure extends TransactionState {
  final String message;

  const TransactionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
