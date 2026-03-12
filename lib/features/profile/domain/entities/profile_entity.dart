import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final bool isPremium;
  final int monthsTracked;
  final int totalTransactions;
  final double totalSaved;
  final DateTime createdAt;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    required this.isPremium,
    required this.monthsTracked,
    required this.totalTransactions,
    required this.totalSaved,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        avatarUrl,
        isPremium,
        monthsTracked,
        totalTransactions,
        totalSaved,
        createdAt,
      ];
}
