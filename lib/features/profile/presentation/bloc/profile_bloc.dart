import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:smart_spent_story/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:smart_spent_story/features/profile/presentation/bloc/profile_event.dart';
import 'package:smart_spent_story/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
  }) : super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileUpdateRequested>(_onUpdateRequested);
  }

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await getProfile(const NoParams());

    result.fold(
      (failure) => emit(ProfileFailure(message: failure.message)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await updateProfile(UpdateProfileParams(
      name: event.name,
      email: event.email,
      phone: event.phone,
    ));

    result.fold(
      (failure) => emit(ProfileFailure(message: failure.message)),
      (profile) => emit(ProfileUpdateSuccess(profile: profile)),
    );
  }
}
