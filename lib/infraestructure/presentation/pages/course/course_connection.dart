import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/lessons/get_lessons_by_course_use_case.dart';
//import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
//import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:get_it/get_it.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final getCourseDataUseCase = getIt.get<GetCourseDataUseCase>();
    final getLessonsByCourseUseCase = getIt.get<GetLessonsByCourseUseCase>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CourseDetailBloc>(
          create: (context) => CourseDetailBloc(getCourseDataUseCase),
        ),
        BlocProvider<LessonBloc>(
          create: (context) => LessonBloc(getLessonsByCourseUseCase),
        ),
      ],
      child: _CourseDetail(),
    );
  }
}

class _CourseDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtén el bloc desde el contexto
    final courseDetailBloc = BlocProvider.of<CourseDetailBloc>(context);
    final lessonBloc = BlocProvider.of<LessonBloc>(context);

    // Carga los detalles del curso
    courseDetailBloc
        .add(const LoadCourseDetail(courseId: '1', page: 1, perPage: 10));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Curso'),
      ),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseDetailLoaded) {
            final course = state.courses.first;

            // Carga las lecciones del curso
            lessonBloc.add(LoadLessonDetailEvent(
              courseId: course.id,
              lessonId: '', // Asegúrate de tener un id de lección válido aquí
              page: 1,
              perPage: 10,
            ));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Título: ${course.title}'),
                Text('Descripción: ${course.description}'),
                Text('Categoría: ${course.category}'),
                Text('Entrenador: ${course.trainer.name}'),
                Text('Duración: ${course.durationWeeks} semanas'),
                const Text('Lecciones:'),
                BlocBuilder<LessonBloc, LessonDetailState>(
                  builder: (context, lessonState) {
                    if (lessonState is LessonDetailLoading) {
                      return const CircularProgressIndicator();
                    } else if (lessonState is LessonDetailLoaded) {
                      if (lessonState.lesson.isEmpty) {
                        return const Text('No hay lecciones asociadas aún.');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: lessonState.lesson.length,
                          itemBuilder: (context, index) {
                            final lesson = lessonState.lesson[index];
                            return ListTile(
                              title: Text(lesson.title),
                              subtitle: Text(lesson.content),
                            );
                          },
                        );
                      }
                    } else {
                      return const Text('Error al cargar las lecciones');
                    }
                  },
                ),
              ],
            );
          } else {
            return const Text('Error al cargar los detalles del curso');
          }
        },
      ),
    );
  }
}
