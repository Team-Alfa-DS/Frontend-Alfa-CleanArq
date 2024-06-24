import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carrusel_v.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_event.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course_details.dart';

class PopularProcessesVerticalScroll extends StatelessWidget {
  const PopularProcessesVerticalScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseListBloc(GetIt.instance<GetCourseDataUseCase>())
            ..add(const LoadCourseList(page: 1, perPage: 7)),
      child: BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
          if (state is CourseListLoading) {
            return const CircularProgressIndicator();
          } else if (state is CourseListLoaded) {
            final courses = state.courses.sublist(0, 4);
            return SizedBox(
              width: double.infinity, // Asegura que el ancho sea infinito
              height: 400, // Define una altura fija
              child: ListView(
                scrollDirection: Axis.vertical, // Cambio a scroll vertical
                children: courses.map((course) {
                  return ScrollV<Map<String, dynamic>>(
                    item: {
                      'titulo': course.trainer.name,
                      'descripcion': course.title,
                      'categoria': course.category,
                      'fecha': course.date.toString(),
                      'fotoUrl': course.image,
                      'isNew': true,
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
