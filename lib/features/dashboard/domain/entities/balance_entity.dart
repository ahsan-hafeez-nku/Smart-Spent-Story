import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;

  const BalanceEntity({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
  });

  @override
  List<Object?> get props => [totalBalance, totalIncome, totalExpenses];
}
