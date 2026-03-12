import 'package:get_it/get_it.dart';
import 'package:smart_spent_story/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:smart_spent_story/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:smart_spent_story/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:smart_spent_story/features/profile/domain/repositories/profile_repository.dart';
import 'package:smart_spent_story/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:smart_spent_story/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:smart_spent_story/features/profile/presentation/bloc/profile_bloc.dart';

void initProfileInjection(GetIt sl) {
  // Bloc
  sl.registerFactory(
    () => ProfileBloc(
      getProfile: sl(),
      updateProfile: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ProfileLocalDatasource>(
    () => ProfileLocalDatasourceImpl(sharedPreferences: sl()),
  );
}
