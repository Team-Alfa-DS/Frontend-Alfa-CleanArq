import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/lessons/get_lessons_by_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/notification/get_notification_data_use_case.dart';
//import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_profile_progress_use_case.dart';
//import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_trending_progress_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/forgot_password_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/login_in_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/register_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/validate_code_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/localStorage/loca_storage_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/course/course_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/notification/notification_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/progress/progress_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/user/user_repository_impl.dart';
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

    final progressRepository = ProgressRepositoryImpl(
      apiRequestManager: apiRequestManagerImpl,
      localStorage: localStorage,
    );

    final courseRepository = CourseRepositoryImpl(
      apiRequestManager: apiRequestManagerImpl,
      localStorage: localStorage,
    );

    final notificationRepository = NotificationRepositoryImpl(
      apiRequestManager: apiRequestManagerImpl,
      localStorage: localStorage,
    );

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
        userRepository: userRepository, localStorage: localStorage);

    final validateCodeUseCase = ValidateCodeUseCase(
      userRepository: userRepository,
      localStorage: localStorage,
    );

    final getCourseDataUseCase = GetCourseDataUseCase(
      courseRepository: courseRepository,
    );

    final getSingleCourseUseCase = GetSingleCourseUseCase(
      courseRepository: courseRepository,
    );

    final getLessonsByCourseUseCase = GetLessonsByCourseUseCase(
      courseRepository: courseRepository,
    );

    //!Progress
    //final getTrendingProgressUseCase = GetTrendingProgressUseCase(
    //  progressRepository: progressRepository,
    //);

    //final getProfileProgressUseCase = GetProfileProgressUseCase(
    //  progressRepository: progressRepository,
    //);

    //!Notification
    final getNotificationDataUseCase = GetNotificationDataUseCase(
      notificationRepository: notificationRepository,
    );

    // Registering singletons
    getIt.registerSingleton<UpdateUserUseCase>(updateUserUseCase);
    getIt.registerSingleton<LogInUseCase>(logInUseCase);
    getIt.registerSingleton<RegisterUseCase>(registerUserCase);
    getIt.registerSingleton<ForgotPasswordUseCase>(forgotPasswordUseCase);
    getIt.registerSingleton<ValidateCodeUseCase>(validateCodeUseCase);
    getIt.registerSingleton<GetCourseDataUseCase>(getCourseDataUseCase);
    getIt.registerSingleton<GetSingleCourseUseCase>(getSingleCourseUseCase);
    getIt.registerSingleton<GetLessonsByCourseUseCase>(
        getLessonsByCourseUseCase);
    //!Progress
    //getIt.registerSingleton<GetTrendingProgressUseCase>(
    //    getTrendingProgressUseCase);
    //getIt.registerSingleton<GetProfileProgressUseCase>(
    //    getProfileProgressUseCase);
    //!Notification
    getIt.registerSingleton<GetNotificationDataUseCase>(
        getNotificationDataUseCase);
  }
}
