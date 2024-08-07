import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/blog/blog_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../aplication/BLoC/blog/blog_many/blog_many_bloc.dart';
import '../../../aplication/BLoC/blog/blog_many/blog_many_event.dart';
import '../../../aplication/BLoC/blog/blog_many/blog_many_state.dart';
import '../../../aplication/use_cases/blog/get_blog_many_use_case.dart';
import 'carrusel_h.dart';

class blogsCarousel extends StatelessWidget {
  final String? filter;

  const blogsCarousel({super.key, this.filter});

  @override
  Widget build(BuildContext context) {
    String currentFilter;

    if (filter == null) {
      currentFilter = '';
    } else {
      currentFilter = filter!;
    }

    print("CREATING BLOG CARROUSEL with FILTER: {$currentFilter}");

    return
        //ok ahora aca cuando construya esto hay que poner el trainer para probar y la categoria cuando se toca en el homescreen se refresca esta llamada
        BlocProvider(
      create: (context) => BlogListBloc(GetIt.instance<GetBlogDataUseCase>())
        ..add(LoadBlogList(
            page: 1,
            perPage: 10,
            filter: currentFilter,
            trainer: '',
            category: '')),
      child: BlocBuilder<BlogListBloc, BlogListState>(
        builder: (context, state) {
          if (state is BlogListLoading) {
            return const CircularProgressIndicator.adaptive();
          } else if (state is BlogListLoaded) {
            final blogs = state.blogs.sublist(0, 5);
            return SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: blogs.map((blog) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Blog_Detailed_Widget(
                              blogId: blog.id,
                            ),
                          ),
                        );
                      },
                      child: ScrollH<Map<String, dynamic>>(
                        item: {
                          'titulo': blog.title,
                          'descripcion': blog.title,
                          'categoria': blog.category,
                          'fecha': blog.date.toString(),
                          'fotoUrl': blog.image,
                          'isNew':
                              true, // Asegúrate de que isNew esté aquí como un parámetro
                          'conexion': "/blogs",
                        },
                        disposicion: 2,
                      ));
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
    );
  }
}
