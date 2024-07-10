import 'package:alpha_gymnastic_center/infraestructure/presentation/navegation/navigate_videoplayer.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses_h.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail/course_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail/course_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail/course_detail_state.dart';

import '../../widgets/comments_container.dart';

class CourseDetailedScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailedScreen({super.key, required this.courseId});

  @override
  _CourseDetailedScreenState createState() => _CourseDetailedScreenState();
}

class _CourseDetailedScreenState extends State<CourseDetailedScreen> {
  late CourseDetailBloc _courseDetailBloc;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    _courseDetailBloc =
        CourseDetailBloc(GetIt.instance<GetSingleCourseUseCase>());
    _courseDetailBloc.add(LoadCourseDetail(courseId: widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _courseDetailBloc,
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
                  builder: (context, state) {
                    if (state is CourseDetailLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CourseDetailLoaded) {
                      final course = state.course;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(course.image),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Entrenador: ${course.trainer.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Categoría: ${course.category}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 16,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isFollowing
                                        ? Colors.deepPurple
                                        : Colors.deepPurpleAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFollowing = !isFollowing;
                                    });
                                    // Dejo esto para que se implemente la logica de seguir al entrenador
                                  },
                                  child: Text(
                                    isFollowing ? 'Following' : 'Follow',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16.0),
                                Text(
                                  course.description,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 16.0),
                                if (course.tags.isNotEmpty)
                                  Text(
                                    'Tags: ${course.tags.take(4).join(', ')}',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                const SizedBox(height: 16.0),
                                const Divider(
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          Color(0xFF4F14A0),
                                          Color(0xFF8066FF),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds),
                                      child: const Icon(Icons.star,
                                          size: 30, color: Colors.white),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Nivel',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            course.level,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 24.0),
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          Color(0xFF4F14A0),
                                          Color(0xFF8066FF),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds),
                                      child: const Icon(Icons.calendar_today,
                                          size: 30, color: Colors.white),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Semanas',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${course.durationWeeks}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 24.0),
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          Color(0xFF4F14A0),
                                          Color(0xFF8066FF),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds),
                                      child: const Icon(Icons.access_time,
                                          size: 30, color: Colors.white),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Minutos',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${course.durationMinutes}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                const Divider(
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Lecciones:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: course.lessons.length,
                                  itemBuilder: (context, index) {
                                    final lesson = course.lessons[index];
                                    return TextButton(
                                      onPressed: () {
                                        print("context");
                                        print("context title");
                                        print(lesson.title);
                                        print("Video url");
                                        print(lesson.video);

                                        // navigateToComments(context, lesson.id,
                                        //     "LESSON", lesson.title);
                                        navigateToVideoPlayer(
                                          context,
                                          lesson.video!,
                                          course.id!,
                                          lesson.id,
                                          lesson.title,
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(8.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          lesson.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(lesson.content),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 12.0),
                                const Divider(
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 8.0),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: PopularCoursesCarousel(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is CourseDetailFailed) {
                      return Center(child: Text('Error: ${state.failure}'));
                    } else {
                      return const Center(child: Text('Estado desconocido'));
                    }
                  },
                ),
              ),
            ),
            ClipPath(
              clipper: AppBarClipper(),
              child: Container(
                height: 85,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Curso Detallado',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // Texto en negritas
                    ),
                  ),
                  centerTitle: false,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _courseDetailBloc.close();
    super.dispose();
  }

  void navigateToComments(
      BuildContext context, String lessonid, String type, String title) {
    //aqui la llamada del fectch del os comentarios request hacia el backend

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Widgets_Comments(id: lessonid, type: type, title: title)));

    return;
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // Línea izquierda del clip
    path.lineTo(size.width - 40,
        size.height); // Línea inferior hasta la esquina inferior derecha
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - 40); // Esquina inferior derecha
    path.lineTo(size.width, 0); // Línea derecha
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
