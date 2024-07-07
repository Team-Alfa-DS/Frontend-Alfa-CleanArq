/*import 'package:alpha_gymnastic_center/aplication/BLoC/course/courses_subscribed/courses_subscribed_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/courses_subscribed/courses_subscribed_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/courses_subscribed/courses_subscribed_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/trainer/get_many_trainers_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carruselh.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_state.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course_details.dart';

class MyTrainingCarrousel extends StatelessWidget {
  const MyTrainingCarrousel({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesSubscribedBloc(
          GetIt.instance<GetCourseDataUseCase>(),
          GetIt.instance<GetManyTrainersUseCase>())
        ..add(const LoadCoursesSubscribed(page: 1, perPage: 7)),
      child: BlocBuilder<CoursesSubscribedBloc, CoursesSubscribedState>(
        builder: (context, state) {
          if (state is CoursesSubscribedLoading) {
            return const CircularProgressIndicator();
          } else if (state is CoursesSubscribedLoaded) {
            final courses = state.courses.sublist(0, 4);
            return SizedBox(
              height: 195,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: courses.map((course) {
                  return ScrollH<Map<String, dynamic>>(
                    item: {
                      'titulo': course.trainer.name,
                      'descripcion': course.title,
                      'categoria': course.category,
                      'fecha': course.date.toString(),
                      'fotoUrl': course.image,
                      'isNew':
                          true, // Asegúrate de que isNew esté aquí como un parámetro
                      'conexion': "/videos",
                    },
                    disposicion: 1,
                    onTap: (item) {
                      var selectedCourse = Course(
                        id: course.id,
                        title: course.title,
                        description: course.description,
                        category: course.category,
                        image: course.image,
                        trainer: course.trainer,
                        level: course.level,
                        DurationWeeks: course.DurationWeeks,
                        DurationMinutes: course.DurationMinutes,
                        tags: course.tags,
                        date: course.date,
                        lessons: course.lessons,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailedScreen(
                            course: selectedCourse,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          } else if (state is CoursesSubscribedFailed) {
            return Text('Error: ${state.failure}');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}*/
