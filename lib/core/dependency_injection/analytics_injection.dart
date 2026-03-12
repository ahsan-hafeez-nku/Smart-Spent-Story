import 'package:get_it/get_it.dart';
import 'package:smart_spent_story/features/analytics/data/datasources/analytics_remote_datasource.dart';
import 'package:smart_spent_story/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:smart_spent_story/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:smart_spent_story/features/analytics/domain/usecases/get_analytics_summary_usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/usecases/get_category_spending_usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/usecases/get_savings_trend_usecase.dart';
import 'package:smart_spent_story/features/analytics/presentation/bloc/analytics_bloc.dart';

void initAnalyticsInjection(GetIt sl) {
  // Bloc
  sl.registerFactory(
    () => AnalyticsBloc(
      getAnalyticsSummary: sl(),
      getCategorySpending: sl(),
      getSavingsTrend: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAnalyticsSummaryUseCase(sl()));
  sl.registerLazySingleton(() => GetCategorySpendingUseCase(sl()));
  sl.registerLazySingleton(() => GetSavingsTrendUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(remoteDatasource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AnalyticsRemoteDatasource>(
    () => AnalyticsRemoteDatasourceImpl(dio: sl()),
  );
}
