import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class GetLessonsByCourseUseCaseInput extends IUseCaseInput {
  final String courseId;

  GetLessonsByCourseUseCaseInput({
    required this.courseId,
  });
}

class GetLessonsByCourseUseCase
    implements IUseCase<GetLessonsByCourseUseCaseInput, Result<List<Lesson>>> {
  final CourseRepository courseRepository;

  GetLessonsByCourseUseCase({required this.courseRepository});

  @override
  Future<Result<Result<List<Lesson>>>> execute(
      GetLessonsByCourseUseCaseInput params) async {
    Result<List<Course>> courseResult =
        await courseRepository.getSingleCourse(id: params.courseId);
    if (courseResult.hasValue()) {
      Course course = courseResult.value!.first;
      return Result<Result<List<Lesson>>>(
          value: Result<List<Lesson>>(value: course.lessons));
    } else {
      return Result<Result<List<Lesson>>>(failure: courseResult.failure);
    }
  }
}
