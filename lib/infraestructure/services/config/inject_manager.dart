import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/lessons/get_lessons_by_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_profile_progress_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_trending_progress_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/search/searchTags_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/search/search_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/forgot_password_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/login_in_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/register_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/validate_code_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/category/get_category_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/localStorage/loca_storage_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/course/course_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/progress/progress_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/search/search_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/user/user_repository_impl.dart';
import 'package:alpha_gymnastic_center/infraestructure/repositories/category/category_repository_impl.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../aplication/use_cases/blog/get_blog_many_use_case.dart';
import '../../../aplication/use_cases/blog/get_blog_one_use_case.dart';
import '../../../aplication/use_cases/comment/get_comment_data_use_case.dart';
import '../../repositories/blog/blog_repository_impl.dart';
import '../../repositories/comments/comment_repository_impl.dart';

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
        apiRequestManager: apiRequestManagerImpl, localStorage: localStorage);

    final blogRepository = BlogRepositoryImpl(
        apiRequestManager: apiRequestManagerImpl, localStorage: localStorage);

    final commentRepository = CommentRepositoryImpl(
        apiRequestManager: apiRequestManagerImpl, localStorage: localStorage);

    final courseRepository = CourseRepositoryImpl(
        apiRequestManager: apiRequestManagerImpl, localStorage: localStorage);

    final categoryRepository = CategoryRepositoryImpl(
        apiRequestManager: apiRequestManagerImpl, localStorage: localStorage);

    // Register repositories with GetIt
    getIt.registerSingleton<UserRepository>(userRepository);
    getIt.registerSingleton<CourseRepository>(courseRepository);

    final searchRepository = SearchRepositoryImpl(
        apiRequestManager: apiRequestManagerImpl, localStorage: localStorage);

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

    //! Courses
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
    final getTrendingProgressUseCase = GetTrendingProgressUseCase(
      progressRepository: progressRepository,
    );

    final getProfileProgressUseCase = GetProfileProgressUseCase(
      progressRepository: progressRepository,
    );

    //!Blogs

    final getBlogDataUseCase = GetBlogDataUseCase(
      blogRepository: blogRepository,
    );

    final getSingleBlogUseCase =
        GetSingleBlogUseCase(blogRepository: blogRepository);

    //!Comments

    final getCommentDataUseCase =
        GetCommentDataUseCase(commentRepository: commentRepository);

    //! Search
    final searchUseCase = SearchUseCase(searchRepository: searchRepository);

    final searchTagsUseCase =
        SearchTagsUseCase(searchRepository: searchRepository);

    //! Category

    final categoryUseCase = GetCategoryDataUseCase(categoryRepository);

    // Registering singletons

    //!users
    getIt.registerSingleton<UpdateUserUseCase>(updateUserUseCase);
    getIt.registerSingleton<LogInUseCase>(logInUseCase);
    getIt.registerSingleton<RegisterUseCase>(registerUserCase);
    getIt.registerSingleton<ForgotPasswordUseCase>(forgotPasswordUseCase);
    getIt.registerSingleton<ValidateCodeUseCase>(validateCodeUseCase);
    getIt.registerSingleton<ChangePasswordUseCase>(changePasswordUseCase);
    getIt.registerSingleton<GetCourseDataUseCase>(getCourseDataUseCase);
    getIt.registerSingleton<GetSingleCourseUseCase>(getSingleCourseUseCase);
    getIt.registerSingleton<GetLessonsByCourseUseCase>(
        getLessonsByCourseUseCase);
    //!Progress
    getIt.registerSingleton<GetTrendingProgressUseCase>(
        getTrendingProgressUseCase);
    getIt.registerSingleton<GetProfileProgressUseCase>(
        getProfileProgressUseCase);

    //!Blogs
    getIt.registerSingleton<GetBlogDataUseCase>(getBlogDataUseCase);
    getIt.registerSingleton<GetSingleBlogUseCase>(getSingleBlogUseCase);

    //!Comments
    getIt.registerSingleton<GetCommentDataUseCase>(getCommentDataUseCase);

    //!Search
    getIt.registerSingleton<SearchUseCase>(searchUseCase);
    getIt.registerSingleton<SearchTagsUseCase>(searchTagsUseCase);

    //!Category
    getIt.registerSingleton<GetCategoryDataUseCase>(categoryUseCase);
  }
}
