import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/login_in_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInUseCase loginUseCase;
  final UserBloc userBloc;

  LoginBloc({required this.loginUseCase, required this.userBloc})
      : super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final result = await loginUseCase.execute(
      LogInUseCaseInput(email: event.email, password: event.password),
    );
    print("aksmdjnasdjnasdja");
    print(result.value);
    if (result.hasValue()) {
      userBloc.add(LoadUser(user: result.value!));
      emit(LoginSuccess(user: result.value!));
    } else {
      emit(LoginFailure(failure: result.failure!));
    }
  }
}
