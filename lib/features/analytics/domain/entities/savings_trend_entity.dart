import 'package:equatable/equatable.dart';

class SavingsTrendEntity extends Equatable {
  final String month;
  final double amount;

  const SavingsTrendEntity({
    required this.month,
    required this.amount,
  });

  @override
  List<Object?> get props => [month, amount];
}
