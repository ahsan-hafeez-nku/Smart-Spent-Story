import 'package:smart_spent_story/features/dashboard/domain/entities/spending_category_entity.dart';

class SpendingCategoryModel extends SpendingCategoryEntity {
  const SpendingCategoryModel({
    required super.name,
    required super.amount,
    required super.color,
  });

  factory SpendingCategoryModel.fromJson(Map<String, dynamic> json) {
    return SpendingCategoryModel(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'color': color,
    };
  }

  SpendingCategoryEntity toEntity() {
    return SpendingCategoryEntity(
      name: name,
      amount: amount,
      color: color,
    );
  }
}
