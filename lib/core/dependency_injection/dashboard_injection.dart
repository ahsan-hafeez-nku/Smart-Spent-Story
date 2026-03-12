import 'package:get_it/get_it.dart';
import 'package:smart_spent_story/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:smart_spent_story/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:smart_spent_story/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:smart_spent_story/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_ai_insights_usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_balance_usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_spending_categories_usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/usecases/get_upcoming_bills_usecase.dart';
import 'package:smart_spent_story/features/dashboard/presentation/bloc/dashboard_bloc.dart';

void initDashboardInjection(GetIt sl) {
  // Bloc
  sl.registerFactory(
    () => DashboardBloc(
      getBalance: sl(),
      getSpendingCategories: sl(),
      getUpcomingBills: sl(),
      getAiInsights: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetBalanceUseCase(sl()));
  sl.registerLazySingleton(() => GetSpendingCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingBillsUseCase(sl()));
  sl.registerLazySingleton(() => GetAiInsightsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
