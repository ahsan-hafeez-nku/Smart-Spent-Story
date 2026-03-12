import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/profile/domain/entities/profile_entity.dart';
import 'package:smart_spent_story/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return repository.getProfile();
  }
}
