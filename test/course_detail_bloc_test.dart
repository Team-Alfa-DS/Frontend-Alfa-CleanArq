import 'package:flutter_test/flutter_test.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

void main() {
  group('CourseDetailBloc', () {
    late CourseDetailBloc courseDetailBloc;
    late GetCourseDataUseCase getCourseDataUseCase;
    late CourseRepository courseRepository;

    setUp(() {
      courseRepository = CourseRepository();
      getCourseDataUseCase = GetCourseDataUseCase(courseRepository);
      courseDetailBloc = CourseDetailBloc(getCourseDataUseCase);
    });

    tearDown(() {
      courseDetailBloc.close();
    });

    test('initial state is CourseDetailInitial', () {
      expect(courseDetailBloc.state, CourseDetailInitial());
    });

    test(
        'emits [CourseDetailLoading, CourseDetailLoaded] when LoadCourseDetail succeeds',
        () async {
      // Añade el evento
      courseDetailBloc
          .add(LoadCourseDetail(courseId: '1', page: 1, perPage: 10));

      // Espera a que el estado cambie
      await expectLater(
        courseDetailBloc.stream,
        emitsInOrder(<CourseDetailState>[
          CourseDetailLoading(),
          CourseDetailLoaded([
            Course(
                id: '1',
                title: 'Course 1',
                description: 'This is the description of Course 1',
                category: 'Category 1',
                image: 'https://example.com/image1.jpg',
                trainer: Trainer(
                    id: '1',
                    name: 'Trainer 1',
                    followers: 100,
                    userFollow: true,
                    location: 'Location 1'),
                level: CourseLevel.beginner,
                durationWeeks: 4,
                durationMinutes: 60,
                tags: ['tag1', 'tag2'],
                date: DateTime.parse('2022-01-01T00:00:00.000Z'),
                lessons: [
                  Lesson(
                      id: '1',
                      title: 'Lesson 1',
                      content: 'This is the content of Lesson 1',
                      video: 'https://example.com/video1.mp4')
                ])
          ]) // Aquí puedes poner los datos de prueba que esperas recibir
        ]),
      );
    });

    test(
        'emits [CourseDetailLoading, CourseDetailFailed] when LoadCourseDetail fails',
        () async {
      // Añade el evento
      courseDetailBloc
          .add(LoadCourseDetail(courseId: '2', page: 1, perPage: 10));

      await expectLater(
        courseDetailBloc.stream,
        emitsInOrder(<CourseDetailState>[
          CourseDetailLoading(),
          CourseDetailFailed(Failure('Test Failure'))
        ]),
      );
    });
  });
}
