import 'package:alpha_gymnastic_center/aplication/BLoC/comment/comment_list_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/comment/get_comment_data_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../aplication/BLoC/comment/comment_list_bloc.dart';
import '../../../aplication/BLoC/comment/comment_list_event.dart';
import '../pages/course/Course.dart';
import 'navegation.dart';

class Widgets_Comments extends StatelessWidget {
  final String id;
  final String type;
  final String title;

  const Widgets_Comments({
    Key? key,
    required this.id,
    required this.type,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(type == "LESSON") {
      return BlocProvider(
        create: (context) => CommentListBloc(
          GetIt.instance<GetCommentDataUseCase>(),
        )..add(LoadCommentList(page: 1, perpage: 15, lesson: id, blog: '')),
        child: Comments(id: id, type: type, title: title),
      );
    }else {
      return BlocProvider(
        create: (context) => CommentListBloc(
          GetIt.instance<GetCommentDataUseCase>(),
        )..add(LoadCommentList(page: 1, perpage: 15, lesson: '', blog: id)),
        child: Comments(id: id, type: type, title: title),
      );
    }
  }
}

class Comments extends StatefulWidget {
  final String id;
  final String type;
  final String title;

  const Comments({
    Key? key,
    required this.id,
    required this.type,
    required this.title,
  }) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController _commentController = TextEditingController();
  bool _showComments = true;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: YogaAppBar(title: "Comentarios de ${widget.title}"),
      body: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentListFailed) {
            return Center(child: Text('Error: ${state.failure}'));
          } else if (state is CommentListLoaded) {
            final comments = state.comments;
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (_showComments)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: bottomInset, left: 8, right: 8),
                        child: ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4.0),
                                  Text(
                                    comment.body,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        comment.countLikes.toString(),
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.thumb_up),
                                        onPressed: () {
                                          // Like logic
                                        },
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        comment.countDislikes.toString(),
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
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
            );
          }
          return const SizedBox.shrink();
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
          child: Image.asset(
            'assets/icons/rayo.png',
            color: Colors.white,
            width: 35.0,
            height: 35.0,
          ),
        ),
      ),
      bottomNavigationBar: const BarraNavegacion(),
      drawer: const SideBarMenu(),
    );
  }
}
