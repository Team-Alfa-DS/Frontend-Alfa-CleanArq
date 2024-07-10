import 'package:alpha_gymnastic_center/aplication/BLoC/blog/blog_one/blog_one_event.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/blog/get_blog_one_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../aplication/BLoC/blog/blog_one/blog_one_bloc.dart';
import '../../../../aplication/BLoC/blog/blog_one/blog_one_state.dart';
import '../../../../domain/entities/blog.dart';
import '../../widgets/comments_container.dart';
import '../../widgets/navegation.dart';

class Blog_Detailed_Widget extends StatelessWidget {
  final Blog item;

  const Blog_Detailed_Widget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => blogOneBloc(GetIt.instance<
      GetSingleBlogUseCase>())..add(LoadBlogOne(blogId: item.id)),
      child: Blog_Detailed(blog: item),
    );
  }
}

class Blog_Detailed extends StatelessWidget {
  final Blog blog;

  const Blog_Detailed({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: YogaAppBar(title: blog.title),
      body: BlocBuilder<blogOneBloc, BlogOneState>(
        builder: (context, state) {
          if (state is BlogOneLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogOneFailed) {
            return Center(child: Text('Error: ${state.failure}'));
          } else if (state is BlogOneLoaded) {
            final blogitem = state.blog;
            return Stack(
              children: [
            SafeArea(
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                        child: getImage(blog.image)
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blogitem.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Entrenador: ${blogitem.trainer?.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Categoría: ${blogitem.category}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        blogitem.description!,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      if (blogitem.tags!.isNotEmpty)
                        Text(
                          'Tags: ${blogitem.tags?.take(4).join(', ')}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Imagenes:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: blogitem.images?.length,
                        itemBuilder: (context, index) {
                          final image = blogitem.images?[index];
                          return  Container(
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const Divider(
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
          ),
          ]
        );
          } else {
            return const Center(child: Text('No data'));
          }
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

  void navigateToComments(BuildContext context, String id, String type, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widgets_Comments(id: id, type: type, title: title),
      ),
    );
  }

  Widget getImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      // Return a default asset image if the imageUrl is null or empty
      return Image.asset(
        'assets/images/placeholder_image.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 280,
      );
    } else {
      // Return a network image if the imageUrl is not null
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 280,
        errorBuilder: (context, error, stackTrace) {
          // Return the default asset image if there's an error loading the network image
          return Image.asset(
            'assets/images/placeholder_image.png',
            fit: BoxFit.cover,
            height: 280,
          );
        },
      );
    }
  }
}
