import 'package:equatable/equatable.dart';

class AiInsightEntity extends Equatable {
  final String id;
  final String message;
  final String type;
  final DateTime createdAt;

  const AiInsightEntity({
    required this.id,
    required this.message,
    required this.type,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, message, type, createdAt];
}
