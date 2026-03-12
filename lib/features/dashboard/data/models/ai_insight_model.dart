import 'package:smart_spent_story/features/dashboard/domain/entities/ai_insight_entity.dart';

class AiInsightModel extends AiInsightEntity {
  const AiInsightModel({
    required super.id,
    required super.message,
    required super.type,
    required super.createdAt,
  });

  factory AiInsightModel.fromJson(Map<String, dynamic> json) {
    return AiInsightModel(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type,
      'created_at': createdAt.toIso8601String(),
    };
  }

  AiInsightEntity toEntity() {
    return AiInsightEntity(
      id: id,
      message: message,
      type: type,
      createdAt: createdAt,
    );
  }
}
