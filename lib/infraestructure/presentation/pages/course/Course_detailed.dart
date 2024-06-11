import 'dart:html';

import 'package:flutter/material.dart';

import '../../widgets/comments_container.dart';
import '../../widgets/sidebarmenu.dart';
import 'Course.dart';


class Course_Detailed extends StatelessWidget {

    var jsonResponse = {
    "Title": "Sample Title",
    "Description": "Sample Description",
    "Category": "Fitness",
    "Image": "https://example.com/sample.jpg",
    "Trainer": {
      "Id": "trainer001",
      "Name": "John Doe"
    },
    "Level": "Intermediate",
    "DurationWeeks": 4,
    "DurationMinutes": 60,
    "Tags": ["Workout", "Cardio", "Strength"],
    "Date": "2024-06-11T00:00:00Z",
    "Lessons": [
      {
        "Id": "lesson001",
        "Title": "Lesson 1",
        "Content": "Introduction to the workout",
        "Video": "https://example.com/video1.mp4"
      },
      {
        "Id": "lesson002",
        "Title": "Lesson 2",
        "Content": "Cardio session",
        "Image": "https://example.com/image2.jpg"
      }
    ]
  };

  final String Course;

  /*
  Title: string
  Description: string
  Category: string
  Image: string
  Trainer: {
      Id: string
      Name: string
  }
  Level: string
  DurationWeeks: number
  DurationMinutes: number
  Tags: string[]
  Date: Date
  Lessons: [{
      Id: string
      Title: string
      Content: string
      Video?: string
      Image?: string
  }]
  */

    Course_Detailed({Key? key, required this.Course}) : super(key: key);

    /*

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Column(
        children: [
          YogaAppBar(title: title),
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
                              urlTitleImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            desc,
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                              Expanded(
                                child: Image.network(
                                  panel['item']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Column(
                                children: [
                                  Text(
                                  panel['description']!,
                                       style: const TextStyle(
                                       fontSize: 16.0,
                                       ),
                                  ),
                                  TextButton(
                                      onPressed: () {navigateToComments(context, id, "LESSON", this.title);}
                                      ,
                                      child: const Text(
                                         "Check Comments",
                                        style: TextStyle(
                                        fontSize: 8.0,
                                        ),
                                    )
                                  )
                                ]
                              ),
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
  }*/

  void navigateToComments(BuildContext context, String id, String type, String title) {

    //aqui la llamada del fectch del os comentarios request hacia el backend

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Widgets_Comments(id: id, Type: type, title: title)));

    return;
  }
}
