import 'package:alpha_gymnastic_center/aplication/use_cases/comment/get_comment_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/comment/post_new_comment_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../aplication/BLoC/comment/listcomments/comment_list_bloc.dart';
import '../../../aplication/BLoC/comment/listcomments/comment_list_event.dart';
import '../../../aplication/BLoC/comment/listcomments/comment_list_state.dart';
import '../../../aplication/BLoC/comment/post/comment_post_bloc.dart';
import '../../../aplication/BLoC/comment/post/comment_post_event.dart';
import '../../../aplication/BLoC/comment/post/comment_post_state.dart';
import '../pages/course/Course.dart';
import 'navegation.dart';

class Widgets_Comments extends StatelessWidget {
  final String id;
  final String type;
  final String title;

  const Widgets_Comments({
    super.key,
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommentListBloc(
            GetIt.instance<GetCommentDataUseCase>(),
          )..add(type == "LESSON"
              ? LoadCommentList(page: 1, perpage: 15, lesson: id, blog: '')
              : LoadCommentList(page: 1, perpage: 15, lesson: '', blog: id)),
        ),
        BlocProvider(
          create: (context) => CommentPostBloc(
            GetIt.instance<PostNewCommentUseCase>(),
          ),
        ),
      ],
      child: Comments(id: id, type: type, title: title),
    );
  }
}

class Comments extends StatefulWidget {
  final String id;
  final String type;
  final String title;

  const Comments({
    super.key,
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController _commentController = TextEditingController();
  final bool _showComments = true;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: YogaAppBar(title: "Comentarios de ${widget.title}"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CommentListBloc, CommentListState>(
            listener: (context, state) {
              if (state is CommentListFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.failure.message}')),
                );
              }
            },
          ),
          BlocListener<CommentPostBloc, CommentPostState>(
            listener: (context, state) {
              if (state is CommentPostLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comentario enviado con éxito')),
                );
                context.read<CommentListBloc>().add(widget.type == "LESSON"
                    ? LoadCommentList(
                        page: 1, perpage: 15, lesson: widget.id, blog: '')
                    : LoadCommentList(
                        page: 1, perpage: 15, lesson: '', blog: widget.id));
              } else if (state is CommentPostFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Error al enviar comentario: ${state.failure.message}')),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (context, state) {
            if (state is CommentListLoading) {
              return const Center(child: CircularProgressIndicator());
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
                                    const SizedBox(height: 6.0),
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
                                hintText: 'Enviar comentario',
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
                                context.read<CommentPostBloc>().add(
                                      LoadCommentPost(
                                        body: _commentController.text,
                                        targetid: widget.id,
                                        targetType: widget.type,
                                      ),
                                    );
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
            return const Center(child: Text('Comentarios no encontrados!'));
          },
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
