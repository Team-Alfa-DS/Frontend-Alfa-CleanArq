import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/blog/blog_detailed.dart';

class blogItem extends StatelessWidget {

  String id;
  String imageUrl;
  String title;
  String description;
  String date;
  String category;

  blogItem({super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.transparent)),
                      onPressed: () => {
                          /*navigateToDetailed(
                              context,
                              id,
                              title,
                              description,
                              imageUrl
                          )*/ },
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
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
    );
  }

  /*
  void navigateToDetailed(BuildContext context, String id_, String title,
      String description, String url_) {
    //busca en el repositorio un blog detallado dado el id que llega del parametro de esta funcion y luego se lo pones al la llamada del widget

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Blog_Detailed_Widget(id: id_,
                  Title: title,
                  Description: description,
                  Images: images,
                  Tags: tags,
                  date: date_,
                )));
  }
   */
}