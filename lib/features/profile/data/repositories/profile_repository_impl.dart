import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:smart_spent_story/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:smart_spent_story/features/profile/domain/entities/profile_entity.dart';
import 'package:smart_spent_story/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final ProfileLocalDatasource localDatasource;

  const ProfileRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final remoteProfile = await remoteDatasource.getProfile();
      await localDatasource.cacheProfile(remoteProfile);
      return Right(remoteProfile.toEntity());
    } on ServerException {
      try {
        final cachedProfile = await localDatasource.getCachedProfile();
        return Right(cachedProfile.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    } on NetworkException {
      try {
        final cachedProfile = await localDatasource.getCachedProfile();
        return Right(cachedProfile.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (phone != null) data['phone'] = phone;

      final updatedProfile = await remoteDatasource.updateProfile(data);
      await localDatasource.cacheProfile(updatedProfile);
      return Right(updatedProfile.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
