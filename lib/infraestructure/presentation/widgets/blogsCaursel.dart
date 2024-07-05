import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/blog/blog_detailed.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../aplication/BLoC/blog/blog_many/blog_many_bloc.dart';
import '../../../aplication/BLoC/blog/blog_many/blog_many_event.dart';
import '../../../aplication/BLoC/blog/blog_many/blog_many_state.dart';
import '../../../aplication/use_cases/blog/get_blog_many_use_case.dart';
import '../../../domain/entities/blog.dart';
import 'carrusel_h.dart';

class blogsCarousel extends StatelessWidget {
  const blogsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //ok ahora aca cuando construya esto hay que poner el trainer para probar y la categoria cuando se toca en el homescreen se refresca esta llamada
        BlocProvider(create: (context) => BlogListBloc(GetIt.instance<GetBlogDataUseCase>())
        ..add(const LoadBlogList(page: 1, perPage: 7, filter: "POPULAR", trainer: '', category: 'Yoga')),
            child: BlocBuilder<BlogListBloc, BlogListState>(
              builder: (context, state) {
                if (state is BlogListLoading) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is BlogListLoaded) {
                  final blogs = state.blogs.sublist(0, 3);
                  return SizedBox(
                    height: 195,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: blogs.map((blogs) {
                        return ScrollH<Map<String, dynamic>>(
                          item: {
                            'titulo': blogs.title,
                            'descripcion': blogs.title,
                            'categoria': blogs.category,
                            'fecha': blogs.date.toString(),
                            'fotoUrl': blogs.image,
                            'isNew':
                            true, // Asegúrate de que isNew esté aquí como un parámetro
                            'conexion': "/blogs",
                          },
                          disposicion: 2,
                          onTap: (item) {
                            var selectedBlog = Blog(
                                id: blogs.id,
                                title: blogs.title,
                                image: blogs.image,
                                images: blogs.images,
                                category: blogs.category,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Blog_Detailed_Widget(
                                  item: selectedBlog,
                                ),
                              ),
                            );
                          },
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
        );

  }
}