import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/forgot_password_use_case.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc({required this.forgotPasswordUseCase})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    final result = await forgotPasswordUseCase.execute(
      ForgotPasswordUseCaseInput(email: event.email),
    );

    print("HOlaaa");
    print(result.hasValue());
    if (result.hasValue()) {
      print(result.value?.date);
      emit(ForgotPasswordSuccess());
    } else {
      emit(ForgotPasswordFailure(failure: result.failure!));
    }
  }
}
