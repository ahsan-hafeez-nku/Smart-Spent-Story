import 'package:equatable/equatable.dart';

class UpcomingBillEntity extends Equatable {
  final String id;
  final String name;
  final double amount;
  final DateTime dueDate;
  final String icon;

  const UpcomingBillEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, name, amount, dueDate, icon];
}
