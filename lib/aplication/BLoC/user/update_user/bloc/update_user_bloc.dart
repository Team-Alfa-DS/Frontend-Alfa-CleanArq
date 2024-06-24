import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../common/failure.dart';

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
        name: (event.name == 'None') ? null : event.name,
        email: (event.email == 'None') ? null : event.email,
        password: (event.password == 'None') ? null : event.password,
        phone: (event.phone == 'None') ? null : event.phone,
        image: (event.image == 'None') ? null : event.phone,
      ),
    );
    emit(UpdateUserSuccess(updateUserResponse: result.hasValue()));
    /*if (result.hasValue()) {
      //emit(UpdateUserSuccess(updateUserResponse: result.value!));
    } else {
      emit(UpdateUserFailure(failure: result.failure!));
    }*/
  }
}
