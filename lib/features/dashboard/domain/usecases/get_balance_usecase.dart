import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/balance_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetBalanceUseCase implements UseCase<BalanceEntity, NoParams> {
  final DashboardRepository repository;

  GetBalanceUseCase(this.repository);

  @override
  Future<Either<Failure, BalanceEntity>> call(NoParams params) {
    return repository.getBalance();
  }
}
