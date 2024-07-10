import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../aplication/BLoC/comment/listcomments/comment_list_state.dart';
import '../../../aplication/BLoC/comment/post/comment_post_bloc.dart';
import '../../../aplication/BLoC/comment/post/comment_post_event.dart';
import '../../../aplication/BLoC/comment/post/comment_post_state.dart';
import '../../../aplication/use_cases/comment/post_new_comment_use_case.dart';

class snackbarComment extends StatelessWidget {

  final String id;
  final String type;
  final String text;

  snackbarComment({
    Key? key,
    required this.id,
    required this.type,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Id del POST comentario: $id");
    print("TYpe del POST comentario: $type");
    print("Body del POST comentario: $text");

    return BlocProvider(
      create: (context) => CommentPostBloc(
        GetIt.instance<PostNewCommentUseCase>(),
      )..add(LoadCommentPost(body: text, targetid: id, targetType: type)),
      child: BlocBuilder<CommentPostBloc, CommentPostState>(
          builder: (context, state) {
            if (state is CommentListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommentPostFailed) {
              return Center(child: Text('Error: ${state.failure}'));
            } else if (state is CommentPostLoaded) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                      'Mensaje enviado!'),
                ),
              );
            }
            return const SizedBox.shrink();
          }
      ),
    );

  }
}