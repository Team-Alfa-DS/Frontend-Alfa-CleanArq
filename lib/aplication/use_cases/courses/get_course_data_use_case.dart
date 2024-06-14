import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class GetCourseDataUseCaseInput extends IUseCaseInput {
  final int courseId;
  final int page;
  final int perPage;

  GetCourseDataUseCaseInput(
      {required this.courseId, required this.page, required this.perPage});
}

class GetCourseDataUseCase
    implements IUseCase<GetCourseDataUseCaseInput, List<Course>> {
  final CourseRepository courseRepository;

  GetCourseDataUseCase({required this.courseRepository});

  @override
  Future<Result<List<Course>>> execute(GetCourseDataUseCaseInput params) async {
    return await courseRepository.getCourseMany(
        page: params.page, perPage: params.perPage);
  }
}
