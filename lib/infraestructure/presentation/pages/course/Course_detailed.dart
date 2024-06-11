import 'package:flutter/material.dart';
import '../../../../domain/entities/course.dart';
import '../../widgets/comments_container.dart';
import '../../widgets/sidebarmenu.dart';
import 'Course.dart';

class Course_Detailed extends StatelessWidget {
  final Course course;
  const Course_Detailed({super.key, required this.course});
  @override
  Widget build(BuildContext context) {
    var panels = course.lessons;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Column(
        children: [
          YogaAppBar(title: course.title),
          Expanded(
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Flexible(
                            child: Image.network(
                              course.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${course.description} ${course.category} ${course.date} ${course.trainer.id} ${course.trainer.name} ${course.tags} ${course.durationMinutes} ${course.durationWeeks} ${course.level}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Lessons To Follow",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(255, 255, 255, 0.0),
                          ),
                        ),
                        onPressed: () {
                          //post donde se subscribe va aqui;
                        },
                        child: const Text(
                          "Subscribe!",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: bottomInset, left: 8, right: 8),
                    child: ListView.builder(
                      itemCount: panels.length,
                      itemBuilder: (context, index) {
                        final panel = panels[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              if (panel.image!.isNotEmpty &&
                                  panel.video!.isEmpty)
                                Expanded(
                                  child: Image.network(
                                    panel.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (panel.video!.isNotEmpty &&
                                  panel.image!.isEmpty)
                                Expanded(
                                  child: Image.network(
                                    panel.video!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(width: 16.0),
                              Column(children: [
                                Text(
                                  panel.content,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateToComments(context, panel.id,
                                          "LESSON", course.title);
                                    },
                                    child: const Text(
                                      "Check Comments",
                                      style: TextStyle(
                                        fontSize: 8.0,
                                      ),
                                    ))
                              ]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const SideBarMenu(),
    );
  }

  void navigateToComments(
      BuildContext context, String id, String type, String title) {
    //aqui la llamada del fectch del os comentarios request hacia el backend

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Widgets_Comments(id: id, Type: type, title: title)));

    return;
  }
}
