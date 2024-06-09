import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateUserUseCase updateUserUseCase;

  UpdateUserBloc({required this.updateUserUseCase})
      : super(UpdateUserInitial()) {
    on<UpdateUserSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      UpdateUserSubmitted event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());

    final result = await updateUserUseCase.execute(UpdateUserUseCaseInput(
      token: event.token,
      email: event.email,
      name: event.name,
      password: event.password,
      phone: event.phone,
      image: event.image,
    ));

    if (result.hasValue()) {
      emit(UpdateUserSuccess());
    } else {
      emit(UpdateUserFailure(failure: result.failure!));
    }
  }
}
