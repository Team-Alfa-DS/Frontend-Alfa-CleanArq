import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class GetSingleCourseUseCaseInput extends IUseCaseInput {
  final String courseId;

  GetSingleCourseUseCaseInput({required this.courseId});
}

class GetSingleCourseUseCase
    implements IUseCase<GetSingleCourseUseCaseInput, Course> {
  final CourseRepository courseRepository;

  GetSingleCourseUseCase({required this.courseRepository});

  @override
  Future<Result<Course>> execute(GetSingleCourseUseCaseInput params) async {
    final result = await courseRepository.getSingleCourse(id: params.courseId);
    print("Result usecase");
    print(result.value);
    if (result.hasValue()) {
      final course = result.value!;
      print('Course ID: ${course.id}');
      print('Course Title : ${course.title}');
    }
    return result;
  }
}
