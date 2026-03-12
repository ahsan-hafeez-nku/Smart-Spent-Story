import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/analytics_summary_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/category_spending_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/savings_trend_entity.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

class AnalyticsLoaded extends AnalyticsState {
  final AnalyticsSummaryEntity summary;
  final List<CategorySpendingEntity> categorySpending;
  final List<SavingsTrendEntity> savingsTrend;

  const AnalyticsLoaded({
    required this.summary,
    required this.categorySpending,
    required this.savingsTrend,
  });

  @override
  List<Object?> get props => [summary, categorySpending, savingsTrend];
}

class AnalyticsFailure extends AnalyticsState {
  final String message;

  const AnalyticsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
