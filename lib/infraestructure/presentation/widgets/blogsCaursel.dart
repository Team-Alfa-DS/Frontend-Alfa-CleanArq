import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../aplication/BLoC/blog/blog_many/blog_many_bloc.dart';
import '../../../aplication/BLoC/blog/blog_many/blog_many_event.dart';
import '../../../aplication/BLoC/blog/blog_many/blog_many_state.dart';
import '../../../aplication/use_cases/blog/get_blog_many_use_case.dart';

class blogsCarousel extends StatelessWidget {
  const blogsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        //ok ahora aca cuando construya esto hay que poner el trainer para probar y la categoria cuando se toca en el homescreen se refresca esta llamada
        BlocProvider(create: (context) => BlogListBloc(GetIt.instance<GetBlogDataUseCase>())
        ..add(const LoadBlogList(page: 1, perPage: 7, filter: "POPULAR", trainer: '', category: 'Yoga')),
            child: BlocBuilder<BlogListBloc, BlogListState>(
              builder: (context, state) {
                if (state is BlogListLoading) {
                  return const CircularProgressIndicator();
                } else if (state is BlogListLoaded) {
                  final blogs = state.blogs.sublist(0, 3);
                  return SizedBox(
                    height: 195,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: blogs.map((blogs) {
                        return ScrollHorizontal(
                          titulo: blogs.trainer.name,
                          descripcion: blogs.title,
                          categoria: blogs.category,
                          fecha: blogs.date.toString(),
                          foto: blogs.images!.first.toString(),
                          disposicion: 2,
                          isNew: false,
                          conexion: "/blogs",
                        );
                      }).toList(),
                    ),
                  );
                } else if (state is BlogListFailed) {
                  return Text('Error: ${state.failure}');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
        ),

      ],
       child: SizedBox.fromSize(),
    );
  }
}