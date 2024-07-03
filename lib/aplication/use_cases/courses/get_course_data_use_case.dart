import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class GetCourseDataUseCaseInput extends IUseCaseInput {
  final int page;
  final int perPage;
  final String filter;

  GetCourseDataUseCaseInput({
    required this.page,
    required this.perPage,
    required this.filter,
  });
}

class GetCourseDataUseCase {
  final CourseRepository _courseRepository;

  GetCourseDataUseCase({required CourseRepository courseRepository})
      : _courseRepository = courseRepository;

  Future<Result<List<Course>>> execute(GetCourseDataUseCaseInput input) {
    return _courseRepository.getCourseMany(
      page: input.page,
      perPage: input.perPage,
      filter: input.filter,
    );
  }
}
