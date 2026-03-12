import 'package:equatable/equatable.dart';

class AnalyticsSummaryEntity extends Equatable {
  final double avgMonthlyIncome;
  final double avgMonthlyExpense;
  final double incomeChangePercent;
  final double expenseChangePercent;

  const AnalyticsSummaryEntity({
    required this.avgMonthlyIncome,
    required this.avgMonthlyExpense,
    required this.incomeChangePercent,
    required this.expenseChangePercent,
  });

  @override
  List<Object?> get props => [
        avgMonthlyIncome,
        avgMonthlyExpense,
        incomeChangePercent,
        expenseChangePercent,
      ];
}
