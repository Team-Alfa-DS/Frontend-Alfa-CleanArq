import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/login_in_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/get_current_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UserBloc userBloc;

  LoginBloc({
    required this.loginUseCase,
    required this.getCurrentUserUseCase,
    required this.userBloc,
  }) : super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final loginResult = await loginUseCase.execute(
      LogInUseCaseInput(email: event.email, password: event.password),
    );

    if (loginResult.hasValue()) {
      final loginUser = loginResult.value!;
      final currentUserResult = await getCurrentUserUseCase.execute(
        GetCurrentUserUseCaseInput(),
      );

      if (currentUserResult.hasValue()) {
        final currentUser = currentUserResult.value;
        final user = User(
            id: currentUser!.id,
            email: currentUser.email,
            imagenPerfil: currentUser.image,
            name: currentUser.name,
            phone: currentUser.phone,
            token: loginUser.token,
            type: loginUser.type);
        userBloc.add(LoadUser(user: user));
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginFailure(failure: currentUserResult.failure!));
      }
    } else {
      emit(LoginFailure(failure: loginResult.failure!));
    }
  }
}
