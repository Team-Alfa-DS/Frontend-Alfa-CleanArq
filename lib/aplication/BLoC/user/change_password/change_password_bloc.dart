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

    final result = await changePasswordUseCase.execute(
      ChangePasswordUseCaseInput(
        email: event.email,
        code: event.code,
        newPassword: event.newPassword,
      ),
    );

    if (result.hasValue()) {
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordFailure(failure: result.failure!));
    }
  }
}
