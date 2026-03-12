import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/upcoming_bill_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetUpcomingBillsUseCase
    implements UseCase<List<UpcomingBillEntity>, NoParams> {
  final DashboardRepository repository;

  GetUpcomingBillsUseCase(this.repository);

  @override
  Future<Either<Failure, List<UpcomingBillEntity>>> call(NoParams params) {
    return repository.getUpcomingBills();
  }
}
