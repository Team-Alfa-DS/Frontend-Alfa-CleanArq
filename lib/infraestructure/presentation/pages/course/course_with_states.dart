import 'dart:math';
import 'Course_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_state.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';

class YogaBasics extends StatelessWidget {
  final String courseId;

  const YogaBasics({required this.courseId, super.key});

  @override
  Widget build(BuildContext context) {
    return YogaHomePage(courseId: courseId);
  }
}

class YogaHomePage extends StatefulWidget {
  final String courseId;

  const YogaHomePage({required this.courseId, super.key});

  @override
  State<YogaHomePage> createState() => _YogaHomePageState();
}

class _YogaHomePageState extends State<YogaHomePage> {
  late CourseDetailBloc _courseDetailBloc;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _courseDetailBloc = BlocProvider.of<CourseDetailBloc>(context);
    _courseDetailBloc
        .add(LoadCourseDetail(courseId: widget.courseId, page: 1, perPage: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Courses Proceses"),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseDetailLoaded) {
            return YogaBody(
              courseId: state.courses[currentIndex].id,
              image: state.courses.map((course) => course.image).toList(),
              titles: state.courses.map((course) => course.title).toList(),
              currentIndex: currentIndex,
              onPageChanged: (index, _) {
                setState(() {
                  currentIndex = index;
                });
              },
              description:
                  state.courses.map((course) => course.description).toList(),
            );
          } else {
            return const Center(child: Text('Failed to load courses'));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Image.asset('assets/icons/rayo.png',
              color: Colors.white, width: 35.0, height: 35.0),
        ),
      ),
      bottomNavigationBar: const BarraNavegacion(),
      drawer: const SideBarMenu(),
    );
  }
}

class YogaAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;

  const YogaAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(50),
      )),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
      leading: const BackButton(color: Colors.white),
    );
  }
}

class YogaBody extends StatelessWidget {
  final String courseId;
  final List<String> image;
  final List<String> titles;
  final int currentIndex;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final List<String> description;

  const YogaBody({
    super.key,
    required this.courseId,
    required this.image,
    required this.titles,
    required this.currentIndex,
    required this.onPageChanged,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailState>(
      builder: (context, state) {
        if (state is CourseDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseDetailLoaded) {
          var course =
              state.courses.firstWhere((course) => course.id == courseId);
          int currentIndex = 0;
          return Flex(
            direction: Axis.vertical,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(45),
                ),
                child: GestureDetector(
                  onDoubleTap: () {
                    redirectToCourseDetails(context, course);
                  },
                  child: SizedBox(
                    height: 290,
                    child: Stack(
                      children: [
                        ClipRect(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 290,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                currentIndex = index;
                              },
                              scrollDirection:
                                  Axis.vertical, // Slide up and down
                            ),
                            items: [course.image].map((url) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              'New',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              '${currentIndex + 1} / 1',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      course.description,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Text(
                          course.description,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[800]),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.blue),
                              SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Weeks',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('4'),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer, color: Colors.green),
                              SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mins',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('30'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      NewYogaClassesCarousel(
                        newImageUrls: [course.image],
                        newImageTitles: [course.title],
                        newImageSubtitles: [course.description],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Failed to load courses'));
        }
      },
    );
  }

  void redirectToCourseDetails(BuildContext context, Course course) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Course_Detailed(course: course)));
  }
}

class NewYogaClassesCarousel extends StatelessWidget {
  final List<String> newImageUrls;
  final List<String> newImageTitles;
  final List<String> newImageSubtitles;

  const NewYogaClassesCarousel({
    super.key,
    required this.newImageUrls,
    required this.newImageTitles,
    required this.newImageSubtitles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'More Most Popular Courses',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180.0,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              scrollDirection: Axis.vertical,
              viewportFraction: 1.0,
            ),
            items: List.generate(
              (newImageUrls.length + 1) ~/ 2,
              (index) {
                final startIndex = index * 2;
                final endIndex = min(startIndex + 2, newImageUrls.length);
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 180.0,
                          child: Row(
                            children: [
                              for (int i = startIndex; i < endIndex; i++)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        // Replace this with your desired action
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${newImageTitles[i]} double-tapped!'),
                                          ),
                                        );
                                      },
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            child: Image.network(
                                              newImageUrls[i],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 12.0,
                                            right: 12.0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 6.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: const Text(
                                                'New',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.3),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 12.0,
                                            left: 12.0,
                                            right: 12.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newImageTitles[i],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 4.0),
                                                Text(
                                                  newImageSubtitles[i],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
