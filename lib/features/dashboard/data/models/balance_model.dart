import 'package:smart_spent_story/features/dashboard/domain/entities/balance_entity.dart';

class BalanceModel extends BalanceEntity {
  const BalanceModel({
    required super.totalBalance,
    required super.totalIncome,
    required super.totalExpenses,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      totalBalance: (json['total_balance'] as num).toDouble(),
      totalIncome: (json['total_income'] as num).toDouble(),
      totalExpenses: (json['total_expenses'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_balance': totalBalance,
      'total_income': totalIncome,
      'total_expenses': totalExpenses,
    };
  }

  BalanceEntity toEntity() {
    return BalanceEntity(
      totalBalance: totalBalance,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
    );
  }
}
