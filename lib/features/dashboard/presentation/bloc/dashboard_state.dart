import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/ai_insight_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/balance_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/spending_category_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/upcoming_bill_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final BalanceEntity balance;
  final List<SpendingCategoryEntity> categories;
  final List<UpcomingBillEntity> bills;
  final List<AiInsightEntity> insights;

  const DashboardLoaded({
    required this.balance,
    required this.categories,
    required this.bills,
    required this.insights,
  });

  @override
  List<Object?> get props => [balance, categories, bills, insights];
}

class DashboardFailure extends DashboardState {
  final String message;

  const DashboardFailure(this.message);

  @override
  List<Object?> get props => [message];
}
