import 'package:get_it/get_it.dart';
import 'package:smart_spent_story/features/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:smart_spent_story/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:smart_spent_story/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:smart_spent_story/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/get_transactions_usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:smart_spent_story/features/transaction/presentation/bloc/transaction_bloc.dart';

void initTransactionInjection(GetIt sl) {
  // Bloc
  sl.registerFactory(
    () => TransactionBloc(
      getTransactions: sl(),
      addTransaction: sl(),
      updateTransaction: sl(),
      deleteTransaction: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTransactionsUseCase(sl()));
  sl.registerLazySingleton(() => AddTransactionUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTransactionUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTransactionUseCase(sl()));

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
