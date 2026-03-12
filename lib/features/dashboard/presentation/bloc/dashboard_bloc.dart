import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_ai_insights_usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_balance_usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_spending_categories_usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_upcoming_bills_usecase.dart';
import 'package:smart_spent_story/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:smart_spent_story/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetBalanceUseCase getBalance;
  final GetSpendingCategoriesUseCase getSpendingCategories;
  final GetUpcomingBillsUseCase getUpcomingBills;
  final GetAiInsightsUseCase getAiInsights;

  DashboardBloc({
    required this.getBalance,
    required this.getSpendingCategories,
    required this.getUpcomingBills,
    required this.getAiInsights,
  }) : super(const DashboardInitial()) {
    on<DashboardLoadRequested>(_onLoadRequested);
    on<DashboardRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onLoadRequested(
    DashboardLoadRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    await _loadDashboard(emit);
  }

  Future<void> _onRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadDashboard(emit);
  }

  Future<void> _loadDashboard(Emitter<DashboardState> emit) async {
    const params = NoParams();

    final balanceFuture = getBalance(params);
    final categoriesFuture = getSpendingCategories(params);
    final billsFuture = getUpcomingBills(params);
    final insightsFuture = getAiInsights(params);

    final balanceResult = await balanceFuture;
    final categoriesResult = await categoriesFuture;
    final billsResult = await billsFuture;
    final insightsResult = await insightsFuture;

    final balanceError = balanceResult.fold((f) => f.message, (_) => null);
    final categoriesError =
        categoriesResult.fold((f) => f.message, (_) => null);
    final billsError = billsResult.fold((f) => f.message, (_) => null);
    final insightsError = insightsResult.fold((f) => f.message, (_) => null);

    final firstError =
        balanceError ?? categoriesError ?? billsError ?? insightsError;

    if (firstError != null) {
      emit(DashboardFailure(firstError));
      return;
    }

    emit(DashboardLoaded(
      balance: balanceResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
      categories: categoriesResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
      bills: billsResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
      insights: insightsResult.getOrElse(
        () => throw StateError('unreachable'),
      ),
    ));
  }
}
