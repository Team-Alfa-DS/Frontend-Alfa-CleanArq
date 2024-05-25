import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/Course.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';

class Widgets_Tips_Detailed extends StatefulWidget {
  final String title;
  final String desc;
  final String urlTitleImage;

  const Widgets_Tips_Detailed(
      {super.key,
        required this.title,
        required this.desc,
        required this.urlTitleImage});

  @override
  _tips_detail createState() =>
      _tips_detail(title: title, desc: desc, urlTitleImage: urlTitleImage);
}

class _tips_detail extends State<Widgets_Tips_Detailed> {
  final List<Map<String, String>> Comments = [


  ];

  final String title;
  final String desc;
  final String urlTitleImage;

  _tips_detail(
      {required this.title, required this.desc, required this.urlTitleImage});

  final TextEditingController _commentController = TextEditingController();

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
                    padding:
                    EdgeInsets.only(bottom: bottomInset, left: 8, right: 8),
                    child: ListView.builder(
                      itemCount: Comments.length,
                      itemBuilder: (context, index) {
                        final panel = Comments[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  panel['comment']!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
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
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                    },
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
}