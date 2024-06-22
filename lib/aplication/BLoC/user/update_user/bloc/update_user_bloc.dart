import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/failure.dart';
import '../../../../../domain/interfaces/user_interfaces.dart';
import '../../register/register_bloc.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateUserUseCase updateUseCase;

  UpdateUserBloc({required this.updateUseCase}) : super(UpdateUserInitial()) {
    on<UpdateUserSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      UpdateUserSubmitted event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());

    final result = await updateUseCase.execute(
      UpdateUserUseCaseInput(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
      ),
    );

    if (result.hasValue()) {
      /*emit(UpdateUserSuccess(updateUserResponse: result.value!));*/
    } else {
      emit(UpdateUserFailure(failure: result.failure!));
    }
  }

  /*Future<void> _onSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    final result = await registerUseCase.execute(
      RegisterUseCaseInput(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
      ),
    );

    if (result.hasValue()) {
      emit(RegisterSuccess(registerUserResponse: result.value!));
    } else {
      emit(RegisterFailure(failure: result.failure!));
    }
  }*/
}
