import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';

import '../../widgets/comments_container.dart';
import '../../widgets/navegation.dart';

class Blog_Detailed_Widget extends StatefulWidget {
  final String id;
  final String Title;
  final String Description;
  final List<String> Images; // el primero es el que se usa como flagship
  //final Trainer Trainer;
  final List<String> Tags;
  final String date;

  const Blog_Detailed_Widget(
      {super.key,
      required this.id,
      required this.Title,
      required this.Description,
      required this.Images,
      required this.Tags,
      required this.date});

  @override
  Blog_Detailed createState() => Blog_Detailed(
      id: id,
      Title: Title,
      Description: Description,
      Images: Images,
      Tags: Tags,
      date: date);
}

class Blog_Detailed extends State<Blog_Detailed_Widget> {
  List<String> MockImage = [
    'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2018/12/Personal-Trainer-Training-Partner-GettyImages-654427364.jpg?quality=86&strip',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png',
  ];

  final String id;
  final String Title;
  final String Description;
  final List<String> Images; //el primero es el que se usa como flagship

  //final Trainer Trainer;

  final List<String> Tags;
  final String date;

  Blog_Detailed(
      {required this.id,
      required this.Title,
      required this.Description,
      required this.Images,
      required this.Tags,
      required this.date});
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Column(
        children: [
          YogaAppBar(title: Title),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Flexible(
                            child: Image.network(
                              MockImage[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            Description,
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
                        "All the Images!",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(255, 255, 255, 0.0),
                          ),
                        ),
                        onPressed: () {
                          navigateToComments(context, id, "LESSON", Title);
                        },
                        child: const Text(
                          "Check Comments",
                          style: TextStyle(fontSize: 16),
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
                      itemCount: MockImage.length,
                      itemBuilder: (context, index) {
                        final panel = MockImage[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.network(
                                  panel,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
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

  void navigateToComments(
      BuildContext context, String id, String type, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Widgets_Comments(
                  id: id,
                  Type: type,
                  title: title,
                )));
  }
}
