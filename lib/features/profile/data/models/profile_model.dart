import 'package:smart_spent_story/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.avatarUrl,
    required super.isPremium,
    required super.monthsTracked,
    required super.totalTransactions,
    required super.totalSaved,
    required super.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isPremium: json['is_premium'] as bool,
      monthsTracked: json['months_tracked'] as int,
      totalTransactions: json['total_transactions'] as int,
      totalSaved: (json['total_saved'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'is_premium': isPremium,
      'months_tracked': monthsTracked,
      'total_transactions': totalTransactions,
      'total_saved': totalSaved,
      'created_at': createdAt.toIso8601String(),
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      monthsTracked: monthsTracked,
      totalTransactions: totalTransactions,
      totalSaved: totalSaved,
      createdAt: createdAt,
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      avatarUrl: entity.avatarUrl,
      isPremium: entity.isPremium,
      monthsTracked: entity.monthsTracked,
      totalTransactions: entity.totalTransactions,
      totalSaved: entity.totalSaved,
      createdAt: entity.createdAt,
    );
  }
}
