import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/register_use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
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
      emit(RegisterSuccess(user: result.value!));
    } else {
      emit(RegisterFailure(failure: result.failure!));
    }
  }
}
