import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/dashboard/domain/entities/spending_category_entity.dart';
import 'package:smart_spent_story/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetSpendingCategoriesUseCase
    implements UseCase<List<SpendingCategoryEntity>, NoParams> {
  final DashboardRepository repository;

  GetSpendingCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<SpendingCategoryEntity>>> call(
      NoParams params) {
    return repository.getSpendingCategories();
  }
}
