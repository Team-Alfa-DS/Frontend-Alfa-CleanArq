// lib/aplication/BLoC/progress/profile_progress_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_profile_progress_use_case.dart';

part 'profile_progress_event.dart';
part 'profile_progress_state.dart';

class ProfileProgressBloc
    extends Bloc<ProfileProgressEvent, ProfileProgressState> {
  final GetProfileProgressUseCase getProfileProgressUseCase;

  ProfileProgressBloc({required this.getProfileProgressUseCase})
      : super(ProfileProgressInitial()) {
    on<LoadProfileProgress>(_onLoadProfileProgress);
  }

  Future<void> _onLoadProfileProgress(
      LoadProfileProgress event, Emitter<ProfileProgressState> emit) async {
    emit(ProfileProgressLoading());
    final result = await getProfileProgressUseCase
        .execute(GetProfileProgressUseCaseInput());
    if (result.hasValue()) {
      emit(ProfileProgressLoaded(
          percent: result.value!.percent, time: result.value!.time));
    } else {
      emit(ProfileProgressError(message: result.failure!.message));
    }
  }
}
