import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_event.dart';

class PopularProcessesCarousel extends StatelessWidget {
  const PopularProcessesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailBloc(
          GetIt.instance<GetSingleCourseUseCase>())
        ..add(
            const LoadCourseDetail(courseId: 'courseId', page: 1, perPage: 5)),
      child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailLoading) {
            return const CircularProgressIndicator();
          } else if (state is CourseListLoaded) {
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
                        durationWeeks: course.durationWeeks,
                        durationMinutes: course.durationMinutes,
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
          } else if (state is CourseListFailed) {
            return Text('Error: ${state.failure}');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
