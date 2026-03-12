import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/usecases/get_analytics_summary_usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/usecases/get_category_spending_usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/usecases/get_savings_trend_usecase.dart';
import 'package:smart_spent_story/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:smart_spent_story/features/analytics/presentation/bloc/analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetAnalyticsSummaryUseCase getAnalyticsSummary;
  final GetCategorySpendingUseCase getCategorySpending;
  final GetSavingsTrendUseCase getSavingsTrend;

  AnalyticsBloc({
    required this.getAnalyticsSummary,
    required this.getCategorySpending,
    required this.getSavingsTrend,
  }) : super(const AnalyticsInitial()) {
    on<AnalyticsLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    AnalyticsLoadRequested event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(const AnalyticsLoading());

    const params = NoParams();

    final summaryFuture = getAnalyticsSummary(params);
    final categoryFuture = getCategorySpending(params);
    final trendFuture = getSavingsTrend(params);

    final summaryResult = await summaryFuture;
    final categoryResult = await categoryFuture;
    final trendResult = await trendFuture;

    final summaryError = summaryResult.fold((f) => f.message, (_) => null);
    final categoryError = categoryResult.fold((f) => f.message, (_) => null);
    final trendError = trendResult.fold((f) => f.message, (_) => null);

    final firstError = summaryError ?? categoryError ?? trendError;
    if (firstError != null) {
      emit(AnalyticsFailure(message: firstError));
      return;
    }

    emit(AnalyticsLoaded(
      summary: summaryResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
      categorySpending: categoryResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
      savingsTrend: trendResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
    ));
  }
}
