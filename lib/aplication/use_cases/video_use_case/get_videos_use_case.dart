import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';

class GetVideosUseCaseInput extends IUseCaseInput {}

class GetVideosUseCase extends IUseCase<GetVideosUseCaseInput, List<Course>> {
  final CourseRepository courseRepository;

  GetVideosUseCase({required this.courseRepository});

  @override
  Future<Result<List<Course>>> execute(GetVideosUseCaseInput params) async {
    final result =
        await courseRepository.getCourseMany(page: 1, perPage: 10, filter: "");
    if (result.hasValue()) {
      List<Course> courses = [];
      for (var course in result.value!) {
        final courseResult =
            await courseRepository.getSingleCourse(id: course.id!);
        if (courseResult.hasValue()) {
          courses.add(courseResult.value!);
        }
      }
      return Result(value: courses);
    }
    return result;
  }
}
