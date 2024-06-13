import 'package:flutter/material.dart';
import '../../../../domain/entities/course.dart';
import '../../../../domain/entities/lesson.dart';
import '../../widgets/comments_container.dart';
import '../../widgets/navegation.dart';
import '../../widgets/sidebarmenu.dart';
import '../../widgets/videoplayer.dart';
import 'Course.dart';

class CourseDetailedScreen extends StatefulWidget {
  Course course;

  CourseDetailedScreen({Key? key, required this.course})
      : super(key: key);

  @override
  _CourseDetailedScreenState createState() => _CourseDetailedScreenState(course: this.course);
}

class _CourseDetailedScreenState extends State<CourseDetailedScreen> {
  bool _isSubscribed = false;
  Course course;

  void _toggleSubscription() {
    setState(() {
      _isSubscribed = !_isSubscribed;
      // Implement your subscribe/unsubscribe logic here
    });
  }

  _CourseDetailedScreenState({
    required this.course
  });

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: YogaAppBar(
        title: course.title,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    course.image,
                    fit: BoxFit.cover,
                    height: 190,
                    width: double.infinity,
                  ),
                ),
              ),
              ClipPath(
                clipper: RoundedTopCornerClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 10,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              course.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: ElevatedButton(
                                onPressed: _toggleSubscription,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isSubscribed ? Colors.deepPurple : null,
                                ),
                                child: Text(
                                  _isSubscribed ? 'Unsubscribe' : 'Subscribe',
                                  style: TextStyle(
                                    color: _isSubscribed ? Colors.white : Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Level', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(course.level),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Colors.blue),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Weeks', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(course.durationWeeks.toString()),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.timer, color: Colors.green),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Mins per Lesson', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(course.durationMinutes.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        for (int index = 0; index < course.lessons.length; index++)
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      course.lessons[index].title,
                                      style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.black),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 0.4,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                course.lessons[index].content,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  navigateToComments(context, course.id!, "LESSON", course.title);
                                                },
                                                child: const Text(
                                                  'View Comments',
                                                  style: TextStyle(color: Colors.deepPurple),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Column(
                                            children: [
                                              if (course.lessons[index].video != null)
                                                GestureDetector(
                                                  onTap: () {
                                                    navigateToPlayer(context, course.id!, course.lessons[index].id, course.lessons[index].video!);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: SizedBox(
                                                      height: 120,
                                                      child: Stack(
                                                        children: [
                                                          Image.network(
                                                            course.image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Center(
                                                            child: Icon(
                                                              Icons.play_circle_filled,
                                                              size: 60.0,
                                                              color: Colors.grey.withOpacity(0.8),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (course.lessons[index].image != null)
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .only(left: 8.0),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(8.0),
                                                      child: Stack(
                                                        children: [
                                                          Image.network(
                                                            course.lessons[index].image!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Center(
                                                            heightFactor: 2,
                                                            child: Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              size: 60.0,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                  0.5),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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


  void navigateToComments(BuildContext context, String courseid, String type,
      String title) {
    //aqui la llamada del fectch del os comentarios request hacia el backend

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Widgets_Comments(id: courseid, Type: type, title: title)));

    return;
  }

  void navigateToPlayer(BuildContext context, String courseid, String lessonid,
      String urlPath) {

    /* aqui va hacer fetch

      /progress/one/:courseId [GET]
      Headers:
      Authorization: string Bearer token
      Response {
        Percent: number
        Lessons: [{
          lessonId: string
          Time?: number //segundos
          Percent: number
        }]
      }
  */

    List<Lesson> lessonIdIterator = course.lessons;
    String lessonIdFound = "";

    lessonIdIterator.forEach((lesson) {
      if (lesson.id != lessonid) {
        return;
      }
      lessonIdFound = lesson.id;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VideoPlayerScreen(
                    courseId: courseid,
                    lessonId: lessonIdFound,
                    videoPath: urlPath)));


    return;
  }
}

class RoundedTopCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at the top-left corner
    path.lineTo(size.width, 0); // Draw a straight line across the top edge
    path.lineTo(size.width, size.height); // Draw a straight line down the right edge
    path.lineTo(0, size.height); // Draw a straight line along the bottom edge
    path.close(); // Close the path by connecting the end point to the start point
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}