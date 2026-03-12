import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class TransactionsLoadRequested extends TransactionEvent {
  final int? limit;
  final String? category;
  final String? type;

  const TransactionsLoadRequested({
    this.limit,
    this.category,
    this.type,
  });

  @override
  List<Object?> get props => [limit, category, type];
}

class TransactionAddRequested extends TransactionEvent {
  final String title;
  final double amount;
  final String category;
  final String type;
  final DateTime date;
  final String? note;

  const TransactionAddRequested({
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

class TransactionUpdateRequested extends TransactionEvent {
  final TransactionEntity transaction;

  const TransactionUpdateRequested(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionDeleteRequested extends TransactionEvent {
  final String id;

  const TransactionDeleteRequested(this.id);

  @override
  List<Object?> get props => [id];
}
