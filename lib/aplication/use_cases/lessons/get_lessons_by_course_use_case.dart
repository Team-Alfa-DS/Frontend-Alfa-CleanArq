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
  final CourseRepository _courseRepository;

  GetLessonsByCourseUseCase(this._courseRepository);

  @override
  Future<Result<Result<List<Lesson>>>> execute(
      GetLessonsByCourseUseCaseInput params) async {
    // Primero obtenemos el curso
    Result<List<Course>> courseResult =
        await _courseRepository.getSingleCourse(id: params.courseId);

    // Verificamos si la operación fue exitosa
    if (courseResult.hasValue()) {
      // Si el curso se obtuvo correctamente, retornamos las lecciones del curso
      Course course = courseResult.value!.first;
      return Result<Result<List<Lesson>>>(
          value: Result<List<Lesson>>(value: course.lessons));
    } else {
      // Si hubo un error al obtener el curso, retornamos el error
      return Result<Result<List<Lesson>>>(failure: courseResult.failure);
    }
  }
}
