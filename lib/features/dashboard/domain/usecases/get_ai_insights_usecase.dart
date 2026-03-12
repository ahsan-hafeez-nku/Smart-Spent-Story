import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/ai_insight_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetAiInsightsUseCase
    implements UseCase<List<AiInsightEntity>, NoParams> {
  final DashboardRepository repository;

  GetAiInsightsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AiInsightEntity>>> call(NoParams params) {
    return repository.getAiInsights();
  }
}
