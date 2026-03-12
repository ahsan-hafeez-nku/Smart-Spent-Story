import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/get_transactions_usecase.dart';
import 'package:smart_spent_story/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:smart_spent_story/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:smart_spent_story/features/transaction/presentation/bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUseCase getTransactions;
  final AddTransactionUseCase addTransaction;
  final UpdateTransactionUseCase updateTransaction;
  final DeleteTransactionUseCase deleteTransaction;

  TransactionBloc({
    required this.getTransactions,
    required this.addTransaction,
    required this.updateTransaction,
    required this.deleteTransaction,
  }) : super(const TransactionInitial()) {
    on<TransactionsLoadRequested>(_onLoadRequested);
    on<TransactionAddRequested>(_onAddRequested);
    on<TransactionUpdateRequested>(_onUpdateRequested);
    on<TransactionDeleteRequested>(_onDeleteRequested);
  }

  Future<void> _onLoadRequested(
    TransactionsLoadRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await getTransactions(GetTransactionsParams(
      limit: event.limit,
      category: event.category,
      type: event.type,
    ));

    result.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> _onAddRequested(
    TransactionAddRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await addTransaction(AddTransactionParams(
      title: event.title,
      amount: event.amount,
      category: event.category,
      type: event.type,
      date: event.date,
      note: event.note,
    ));

    await result.fold(
      (failure) async => emit(TransactionFailure(failure.message)),
      (_) async {
        emit(const TransactionActionSuccess('Transaction added successfully'));
        await _refreshTransactions(emit);
      },
    );
  }

  Future<void> _onUpdateRequested(
    TransactionUpdateRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await updateTransaction(event.transaction);

    await result.fold(
      (failure) async => emit(TransactionFailure(failure.message)),
      (_) async {
        emit(const TransactionActionSuccess(
            'Transaction updated successfully'));
        await _refreshTransactions(emit);
      },
    );
  }

  Future<void> _onDeleteRequested(
    TransactionDeleteRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result =
        await deleteTransaction(DeleteTransactionParams(id: event.id));

    await result.fold(
      (failure) async => emit(TransactionFailure(failure.message)),
      (_) async {
        emit(const TransactionActionSuccess(
            'Transaction deleted successfully'));
        await _refreshTransactions(emit);
      },
    );
  }

  Future<void> _refreshTransactions(Emitter<TransactionState> emit) async {
    final result =
        await getTransactions(const GetTransactionsParams());

    result.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }
}
