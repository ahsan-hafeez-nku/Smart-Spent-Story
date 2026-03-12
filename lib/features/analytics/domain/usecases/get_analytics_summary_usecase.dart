import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/analytics_summary_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/repositories/analytics_repository.dart';

class GetAnalyticsSummaryUseCase
    extends UseCase<AnalyticsSummaryEntity, NoParams> {
  final AnalyticsRepository repository;

  GetAnalyticsSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, AnalyticsSummaryEntity>> call(NoParams params) {
    return repository.getAnalyticsSummary();
  }
}
