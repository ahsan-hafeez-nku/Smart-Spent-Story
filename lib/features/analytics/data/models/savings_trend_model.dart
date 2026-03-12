import 'package:smart_spent_story/features/analytics/domain/entities/savings_trend_entity.dart';

class SavingsTrendModel extends SavingsTrendEntity {
  const SavingsTrendModel({
    required super.month,
    required super.amount,
  });

  factory SavingsTrendModel.fromJson(Map<String, dynamic> json) {
    return SavingsTrendModel(
      month: json['month'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'amount': amount,
    };
  }

  SavingsTrendEntity toEntity() {
    return SavingsTrendEntity(
      month: month,
      amount: amount,
    );
  }
}
