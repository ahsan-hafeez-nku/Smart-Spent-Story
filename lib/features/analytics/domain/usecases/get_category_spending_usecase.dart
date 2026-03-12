import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/analytics/domain/entities/category_spending_entity.dart';
import 'package:smart_spent_story/features/analytics/domain/repositories/analytics_repository.dart';

class GetCategorySpendingUseCase
    extends UseCase<List<CategorySpendingEntity>, NoParams> {
  final AnalyticsRepository repository;

  GetCategorySpendingUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategorySpendingEntity>>> call(NoParams params) {
    return repository.getCategorySpending();
  }
}
