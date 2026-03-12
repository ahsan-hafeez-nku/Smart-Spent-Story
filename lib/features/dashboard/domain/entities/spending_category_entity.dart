import 'package:equatable/equatable.dart';

class SpendingCategoryEntity extends Equatable {
  final String name;
  final double amount;
  final String color;

  const SpendingCategoryEntity({
    required this.name,
    required this.amount,
    required this.color,
  });

  @override
  List<Object?> get props => [name, amount, color];
}
