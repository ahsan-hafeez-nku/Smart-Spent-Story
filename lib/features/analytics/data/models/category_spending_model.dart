import 'package:smart_spent_story/features/analytics/domain/entities/category_spending_entity.dart';

class CategorySpendingModel extends CategorySpendingEntity {
  const CategorySpendingModel({
    required super.category,
    required super.amount,
    required super.percentage,
    required super.color,
  });

  factory CategorySpendingModel.fromJson(Map<String, dynamic> json) {
    return CategorySpendingModel(
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'percentage': percentage,
      'color': color,
    };
  }

  CategorySpendingEntity toEntity() {
    return CategorySpendingEntity(
      category: category,
      amount: amount,
      percentage: percentage,
      color: color,
    );
  }
}
