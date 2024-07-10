import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/get_current_user_use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UserBloc userBloc;

  SplashBloc({
    required this.getCurrentUserUseCase,
    required this.userBloc,
  }) : super(SplashInitial()) {
    on<CheckForTokenEvent>(_onCheckForTokenEvent);
  }

  Future<void> _onCheckForTokenEvent(
      CheckForTokenEvent event, Emitter<SplashState> emit) async {
    final result =
        await getCurrentUserUseCase.execute(GetCurrentUserUseCaseInput());
    print("El resultado es senorrrr");
    print(result.value.toString());
    if (result.hasValue()) {
      final currentUser = result.value;
      final user = User(
        id: currentUser!.id,
        email: currentUser.email,
        imagenPerfil: currentUser.image,
        name: currentUser.name,
        phone: currentUser.phone,
      );
      userBloc.add(LoadUser(user: user));
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
