// user_bloc.dart
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) {
      print("agregando al usuario");
      print("user");
      print('XD User ID: ${event.user.id}');
      print('XD User Name: ${event.user.name}');
      print('XD User Email: ${event.user.email}');
      print('XD User Phone: ${event.user.phone}');
      print('XD User Image: ${event.user.imagenPerfil}');
      print('XD User Type: ${event.user.type}');
      print('XD User Token : ${event.user.token}');
      emit(UserLoaded(user: event.user));
    });

    on<ClearUser>((event, emit) {
      emit(UserNotLoaded());
    });
  }
}
