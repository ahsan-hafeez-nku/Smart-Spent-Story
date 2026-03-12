import 'package:smart_spent_story/features/analytics/domain/entities/analytics_summary_entity.dart';

class AnalyticsSummaryModel extends AnalyticsSummaryEntity {
  const AnalyticsSummaryModel({
    required super.avgMonthlyIncome,
    required super.avgMonthlyExpense,
    required super.incomeChangePercent,
    required super.expenseChangePercent,
  });

  factory AnalyticsSummaryModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsSummaryModel(
      avgMonthlyIncome: (json['avg_monthly_income'] as num).toDouble(),
      avgMonthlyExpense: (json['avg_monthly_expense'] as num).toDouble(),
      incomeChangePercent: (json['income_change_percent'] as num).toDouble(),
      expenseChangePercent: (json['expense_change_percent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avg_monthly_income': avgMonthlyIncome,
      'avg_monthly_expense': avgMonthlyExpense,
      'income_change_percent': incomeChangePercent,
      'expense_change_percent': expenseChangePercent,
    };
  }

  AnalyticsSummaryEntity toEntity() {
    return AnalyticsSummaryEntity(
      avgMonthlyIncome: avgMonthlyIncome,
      avgMonthlyExpense: avgMonthlyExpense,
      incomeChangePercent: incomeChangePercent,
      expenseChangePercent: expenseChangePercent,
    );
  }
}
