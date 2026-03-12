import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/dependency_injection/analytics_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/auth_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/dashboard_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/profile_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/transaction_injection.dart';
import 'package:smart_spent_story/core/network/dio_provider.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Dio>(() => DioProvider.createDio());

  // Features
  initAuthInjection(sl);
  initDashboardInjection(sl);
  initTransactionInjection(sl);
  initAnalyticsInjection(sl);
  initProfileInjection(sl);
}
