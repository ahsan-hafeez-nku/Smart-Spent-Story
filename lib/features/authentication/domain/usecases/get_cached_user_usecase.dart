import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase extends UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GetCachedUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getCachedUser();
  }
}
