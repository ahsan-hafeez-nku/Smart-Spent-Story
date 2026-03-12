import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/savings_trend_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/repositories/analytics_repository.dart';

class GetSavingsTrendUseCase
    extends UseCase<List<SavingsTrendEntity>, NoParams> {
  final AnalyticsRepository repository;

  GetSavingsTrendUseCase(this.repository);

  @override
  Future<Either<Failure, List<SavingsTrendEntity>>> call(NoParams params) {
    return repository.getSavingsTrend();
  }
}
