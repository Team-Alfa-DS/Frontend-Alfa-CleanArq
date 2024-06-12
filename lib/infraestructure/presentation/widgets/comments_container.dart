import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:flutter/material.dart';

import '../pages/course/Course.dart';

class Widgets_Comments extends StatefulWidget {

  final String id;
  final String Type;
  final String title;

  const Widgets_Comments({super.key, 
    required this.id,
    required this.Type,
    required this.title,
   });

  @override
  Comments createState() => Comments(id: id, Type: Type, title: title);
}

class Comments extends State<Widgets_Comments> {
  final List<Map<String, String>> panels = [
    {
      'id': '1',
      'User': 'User1',
      'countLikes': '10',
      'countDislikes': '2',
      'Body': 'This is a sample comment 1 This is a sample comment 1 This is a sample comment 1',
      'userLiked': 'true',
      'userDisliked': 'false',
      'Date': '2024-06-08'
    },
    {
      'id': '2',
      'User': 'User2',
      'countLikes': '5',
      'countDislikes': '1',
      'Body': 'This is a sample comment 2 This is a sample comment 2 This is a sample comment 2',
      'userLiked': 'false',
      'userDisliked': 'true',
      'Date': '2024-06-08'
    },
    {
      'id': '3',
      'User': 'User3',
      'countLikes': '8',
      'countDislikes': '0',
      'Body': 'This is a sample comment 3 This is a sample comment 3 This is a sample comment 3',
      'userLiked': 'true',
      'userDisliked': 'false',
      'Date': '2024-06-08'
    },
    {
      'id': '4',
      'User': 'User4',
      'countLikes': '2',
      'countDislikes': '0',
      'Body': 'This is a sample comment 4 This is a sample comment 4 This is a sample comment 4',
      'userLiked': 'true',
      'userDisliked': 'false',
      'Date': '2024-06-08'
    },
  ];

  final String id;
  final String Type;
  final String title;

  Comments({
    required this.title,
    required this.id,
    required this.Type,
    });

  final TextEditingController _commentController = TextEditingController();
  bool _showComments = true;


  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const YogaAppBar(title: "Comentarios"),
            if (_showComments)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset, left: 8, right: 8),
                  child: ListView.builder(
                    itemCount: panels.length,
                    itemBuilder: (context, index) {
                      final panel = panels[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              panel['User']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              panel['Body']!,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.thumb_up),
                                  onPressed: () {
                                    // Like logic
                                  },
                                ),
                                const SizedBox(width: 8.0),
                                IconButton(
                                  icon: const Icon(Icons.thumb_down),
                                  onPressed: () {
                                    // Dislike logic
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 13,
                      onTap: () {
                        setState(() {
                          _showComments = false;
                        });
                      },
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Send comment',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  CircleAvatar(
                    radius: 24.0,
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Handle send comment logic here
                        print('Sent comment: ${_commentController.text}');
                        _commentController.clear();
                        setState(() {
                          _showComments = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const SideBarMenu(),
    );
  }
}
