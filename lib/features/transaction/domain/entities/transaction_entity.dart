import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String type;
  final DateTime date;
  final String? note;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [id, title, amount, category, type, date, note];
}
