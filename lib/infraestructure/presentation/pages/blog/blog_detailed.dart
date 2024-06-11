import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';

import '../../widgets/comments_container.dart';

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
        required this.date
      });

  @override
  Blog_Detailed createState() =>
      Blog_Detailed(id: id, Title: Title, Description: Description, Images: Images, Tags:Tags, date: date);
}

class Blog_Detailed extends State<Blog_Detailed_Widget> {
  final List<Map<String, String>> MockImages = [
    {
      'image': 'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2018/12/Personal-Trainer-Training-Partner-GettyImages-654427364.jpg?quality=86&strip=all'
    },
    {
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png'
    },
    {
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png'
    },
    {
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png'
    },
    {
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/991px-Placeholder_view_vector.svg.png'
    },
  ];



  final String id;
  final String Title;
  final String Description;
  final List<String> Images; //el primero es el que se usa como flagship

  //final Trainer Trainer;

  final List<String> Tags;
  final String date;


  Blog_Detailed({
      required this.id,
      required this.Title,
      required this.Description,
      required this.Images,
      required this.Tags,
      required this.date
  });
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Flexible(
                            child: Image.network(
                              MockImages.first.values as String,
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
                        "Steps to Follow",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(255, 255, 255, 0.0),
                          ),
                        ),
                        onPressed: () {
                            navigateToComments(context, id, "LESSON", this.Title);
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
                      itemCount: MockImages.length,
                      itemBuilder: (context, index) {
                        if(index != 0 || index != 1) {
                          final panel = MockImages[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    panel['image']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                              ],
                            ),
                          );
                        }
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

  void navigateToComments(BuildContext context, String id, String type, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Widgets_Comments(id: id, Type: type, title: title,)));
  }
}
