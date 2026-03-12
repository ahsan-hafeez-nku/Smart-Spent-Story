import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spent_story/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:smart_spent_story/features/onboarding/presentation/bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static const int totalPages = 3;

  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingNextPressed>(_onNextPressed);
    on<OnboardingSkipPressed>(_onSkipPressed);
    on<OnboardingPageChanged>(_onPageChanged);
  }

  void _onNextPressed(
    OnboardingNextPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.isLastPage) {
      emit(state.copyWith(isCompleted: true));
    } else {
      final nextPage = state.currentPage + 1;
      emit(state.copyWith(
        currentPage: nextPage,
        isLastPage: nextPage == totalPages - 1,
      ));
    }
  }

  void _onSkipPressed(
    OnboardingSkipPressed event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(isCompleted: true));
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(
      currentPage: event.pageIndex,
      isLastPage: event.pageIndex == totalPages - 1,
    ));
  }
}
