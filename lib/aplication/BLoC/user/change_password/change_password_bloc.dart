import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordBloc({required this.changePasswordUseCase})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      ChangePasswordSubmitted event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());

    print("codigo");
    print(event.code);
    print("email");
    print(event.email);
    print("new pass");
    print(event.newPassword);

    final result = await changePasswordUseCase.execute(
      ChangePasswordUseCaseInput(
        email: event.email,
        code: event.code,
        newPassword: event.newPassword,
      ),
    );
    print(result.statusCode);
    if (result.statusCode == "200") {
      print("exito");
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordFailure(failure: result.failure!));
    }
  }
}
