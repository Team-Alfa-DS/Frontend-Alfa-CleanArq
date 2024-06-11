import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/repositories/lesson_repository.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class GetLessonsByCourseUseCaseInput extends IUseCaseInput {
  final String courseId;
  final int page;
  final int perPage;

  GetLessonsByCourseUseCaseInput({
    required this.courseId,
    required this.page,
    required this.perPage,
  });
}

class GetLessonsByCourseUseCase
    implements IUseCase<GetLessonsByCourseUseCaseInput, List<Lesson>> {
  final LessonRepository _lessonRepository;

  GetLessonsByCourseUseCase(this._lessonRepository);

  @override
  Future<Result<List<Lesson>>> execute(
      GetLessonsByCourseUseCaseInput params) async {
    return await _lessonRepository.getLessons(
      courseId: params.courseId,
      page: params.page,
      perPage: params.perPage,
    );
  }
}
