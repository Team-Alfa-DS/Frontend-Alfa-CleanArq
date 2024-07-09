import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carrusel_h.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_event.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/course_details.dart';

class PopularCoursesCarousel extends StatelessWidget {
  const PopularCoursesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseListBloc(GetIt.instance<GetCourseDataUseCase>())
            ..add(const LoadCourseList(page: 1, perPage: 4, filter: 'POPULAR')),
      child: BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
          if (state is CourseListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseListLoaded) {
            final courses = state.courses.take(3).toList();
            return SizedBox(
              height: 195,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: courses.map((course) {
                  return GestureDetector(
                    onTap: () {
                      if (course.id != null) {
                        print('Navigating to course with id: ${course.id}');
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailedScreen(courseId: course.id!),
                          ),
                        );
                      } else {
                        print('Error: course.id is null');
                        // Manejar caso donde course.id es nulo
                      }
                    },
                    child: ScrollH<Map<String, dynamic>>(
                      item: {
                        'titulo': course.title,
                        'descripcion': course.description,
                        'categoria': course.category,
                        'fecha': course.date.toString(),
                        'fotoUrl': course.image,
                        'isNew': true,
                        'conexion': "/videos",
                      },
                      disposicion: 1,
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (state is CourseListFailed) {
            return Center(child: Text('Error: ${state.failure}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
