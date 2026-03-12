import 'package:equatable/equatable.dart';

class CategorySpendingEntity extends Equatable {
  final String category;
  final double amount;
  final double percentage;
  final String color;

  const CategorySpendingEntity({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });

  @override
  List<Object?> get props => [category, amount, percentage, color];
}
