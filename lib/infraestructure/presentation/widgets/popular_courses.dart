import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail/course_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail/course_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail/course_detail_event.dart';

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
          } else if (state is CourseDetailLoaded) {
            var course = state.course;
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ScrollHorizontal(
                  titulo: course.trainer.name,
                  descripcion: course.title,
                  categoria: course.category,
                  fecha: course.date.toString(),
                  foto: course.image,
                  disposicion: 1,
                  isNew: false,
                  conexion: "/videos",
                ),
              ],
            );
          } else if (state is CourseDetailFailed) {
            return Text('Error: ${state.failure}');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
