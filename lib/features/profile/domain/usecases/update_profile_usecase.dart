import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/profile/domain/entities/profile_entity.dart';
import 'package:smart_spent_story/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase extends UseCase<ProfileEntity, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      name: params.name,
      email: params.email,
      phone: params.phone,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String? name;
  final String? email;
  final String? phone;

  const UpdateProfileParams({
    this.name,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [name, email, phone];
}
