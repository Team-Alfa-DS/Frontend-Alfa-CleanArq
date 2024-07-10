import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/get_current_user_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../common/failure.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateUserUseCase updateUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UserBloc userBloc;

  UpdateUserBloc(
      {required this.updateUseCase,
      required this.getCurrentUserUseCase,
      required this.userBloc})
      : super(UpdateUserInitial()) {
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
        image: (event.image == 'None') ? null : event.image,
      ),
    );
    if (result.statusCode == '200') {
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
        );
        userBloc.add(LoadUser(user: user));
        emit(UpdateUserSuccess(updateUserResponse: result.hasValue()));
      }
    } else {
      emit(UpdateUserFailure(failure: result.failure!));
    }
  }
}
