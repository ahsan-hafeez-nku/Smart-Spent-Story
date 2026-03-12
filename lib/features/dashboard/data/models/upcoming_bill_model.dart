import 'package:smart_spent_story/features/dashboard/domain/entities/upcoming_bill_entity.dart';

class UpcomingBillModel extends UpcomingBillEntity {
  const UpcomingBillModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.dueDate,
    required super.icon,
  });

  factory UpcomingBillModel.fromJson(Map<String, dynamic> json) {
    return UpcomingBillModel(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['due_date'] as String),
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'due_date': dueDate.toIso8601String(),
      'icon': icon,
    };
  }

  UpcomingBillEntity toEntity() {
    return UpcomingBillEntity(
      id: id,
      name: name,
      amount: amount,
      dueDate: dueDate,
      icon: icon,
    );
  }
}
