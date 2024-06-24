import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/progress_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';

class ProgressRepositoryImpl extends ProgressRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  ProgressRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _setAuthHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<void>> markEndProgress(MarkEndProgressRequest request) async {
    await _setAuthHeader();
    final response = await _apiRequestManager.request<void>(
      '/progress/mark/end',
      'POST',
      (data) {},
      body: {
        'courseId': request.courseId,
        'markAsCompleted': request.markAsCompleted,
        'lessonId': request.lessonId,
        if (request.time != null) 'time': request.time,
      },
    );

    return response;
  }

  @override
  Future<Result<ProgressOneResponse>> getProgressOne(String courseId) async {
    await _setAuthHeader();
    final response = await _apiRequestManager.request<ProgressOneResponse>(
      '/progress/one/$courseId',
      'GET',
      (data) {
        return ProgressOneResponse(
          percent: data['Percent'],
          lessons: (data['Lessons'] as List)
              .map((lesson) => LessonProgress(
                    lessonId: lesson['lessonId'],
                    time: lesson['Time'],
                    percent: lesson['Percent'],
                  ))
              .toList(),
        );
      },
    );

    return response;
  }

  @override
  Future<Result<TrendingProgressResponse>> getTrendingProgress() async {
    await _setAuthHeader();

    final response = await _apiRequestManager.request<TrendingProgressResponse>(
      '/progress/trending',
      'GET',
      (data) {
        print("la dataaaa");
        print("data$data");
        return TrendingProgressResponse(
          percent: data['percent'].toDouble(),
          courseTitle: data['courseTitle'],
          courseId: data['courseId'],
          lastTime: DateTime.parse(data['lastTime']),
        );
      },
    );

    return response;
  }

  @override
  Future<Result<ProfileProgressResponse>> getProfileProgress() async {
    await _setAuthHeader();
    final response = await _apiRequestManager.request<ProfileProgressResponse>(
      '/progress/profile',
      'GET',
      (data) {
        print("AJSDJASDJASJD progres profileee");
        print(data.toString());
        return ProfileProgressResponse(
          percent: data['percent'].toDouble(),
          time: data['time'] ?? 0,
        );
      },
    );

    return response;
  }

  @override
  Future<Result<CoursesProgressResponse>> getCoursesProgress(
      int page, int perPage) async {
    await _setAuthHeader();
    final response = await _apiRequestManager.request<CoursesProgressResponse>(
      '/progress/courses?page=$page&perpage=$perPage',
      'GET',
      (data) {
        return CoursesProgressResponse(
          courses: (data as List).map((course) {
            return CourseProgress(
              id: course['Id'],
              title: course['Title'],
              image: course['Image'],
              date: DateTime.parse(course['Date']),
              category: course['Category'],
              trainer: course['Trainer'],
              percent: course['Percent'],
            );
          }).toList(),
        );
      },
    );

    return response;
  }
}
