import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/forgot_password_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/login_in_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/register_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/validate_code_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/localStorage/loca_storage_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/course/course_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/user/user_repository_impl.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InjectManager {
  static Future<void> setUpInjections() async {
    final getIt = GetIt.instance;
    await dotenv.load(fileName: ".env");
    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorage = LocalStorageImpl(prefs: sharedPreferences);
    final apiRequestManagerImpl = ApiRequestManagerImpl(
      baseUrl: dotenv.env['API_URL']!,
    );

    // Repositories

    final userRepository =
        UserRepositoryImpl(apiRequestManager: apiRequestManagerImpl);

    final courseRepository = CourseRepositoryImpl(
      apiRequestManager: apiRequestManagerImpl,
      localStorage: localStorage,
    );

    // Register repositories with GetIt
    getIt.registerSingleton<UserRepository>(userRepository);
    getIt.registerSingleton<CourseRepository>(courseRepository);

    // UseCases

    final updateUserUseCase = UpdateUserUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final logInUseCase = LogInUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final registerUserCase = RegisterUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final forgotPasswordUseCase = ForgotPasswordUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final validateCodeUseCase = ValidateCodeUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final changePasswordUseCase = ChangePasswordUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final getCourseDataUseCase = GetCourseDataUseCase(
      courseRepository: courseRepository,
    );

    final getSingleCourseUseCase = GetSingleCourseUseCase(
      courseRepository: courseRepository,
    );

    // Register use cases with GetIt
    getIt.registerSingleton<UpdateUserUseCase>(updateUserUseCase);
    getIt.registerSingleton<LogInUseCase>(logInUseCase);
    getIt.registerSingleton<RegisterUseCase>(registerUserCase);
    getIt.registerSingleton<ForgotPasswordUseCase>(forgotPasswordUseCase);
    getIt.registerSingleton<ValidateCodeUseCase>(validateCodeUseCase);
    getIt.registerSingleton<ChangePasswordUseCase>(changePasswordUseCase);
    getIt.registerSingleton<GetCourseDataUseCase>(getCourseDataUseCase);
    getIt.registerSingleton<GetSingleCourseUseCase>(getSingleCourseUseCase);
  }
}
