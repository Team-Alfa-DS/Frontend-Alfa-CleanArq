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
  Future<Result<List<TrendingProgressResponse>>> getTrendingProgress() async {
    await _setAuthHeader();
    final response =
        await _apiRequestManager.request<List<TrendingProgressResponse>>(
      '/progress/trending',
      'GET',
      (data) {
        return (data as List).map((progress) {
          return TrendingProgressResponse(
            percent: progress['Percent'],
            courseTitle: progress['courseTitle'],
            courseId: progress['courseId'],
            lastTime: DateTime.parse(progress['lastTime']),
          );
        }).toList();
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
        return ProfileProgressResponse(
          percent: data['Percent'],
          time: data['Time'],
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
