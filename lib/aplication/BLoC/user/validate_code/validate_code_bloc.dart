import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/validate_code_use_case.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
part 'validate_code_event.dart';
part 'validate_code_state.dart';

class ValidateCodeBloc extends Bloc<ValidateCodeEvent, ValidateCodeState> {
  final ValidateCodeUseCase validateCodeUseCase;

  ValidateCodeBloc({required this.validateCodeUseCase})
      : super(ValidateCodeInitial()) {
    on<ValidateCodeSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      ValidateCodeSubmitted event, Emitter<ValidateCodeState> emit) async {
    emit(ValidateCodeLoading());

    final result = await validateCodeUseCase.execute(
      ValidateCodeUseCaseInput(email: event.email, code: event.code),
    );
    print("critofer");
    print(result.statusCode);
    if (result.statusCode == "201") {
      emit(ValidateCodeSuccess());
    } else {
      emit(ValidateCodeFailure(failure: result.failure!));
    }
  }
}
