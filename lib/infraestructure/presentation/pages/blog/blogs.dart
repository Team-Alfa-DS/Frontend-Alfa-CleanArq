import 'dart:core';

import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/blog/blog_detailed.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/blogsCaursel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../aplication/BLoC/blog/blog_many/blog_many_bloc.dart';
import '../../../../aplication/BLoC/blog/blog_many/blog_many_event.dart';
import '../../../../aplication/BLoC/blog/blog_many/blog_many_state.dart';
import '../../../../aplication/use_cases/blog/get_blog_many_use_case.dart';
import '../../../../domain/entities/blog.dart';
import '../../widgets/navegation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/sidebarmenu.dart';

class Blogs_Screen extends StatelessWidget {
  const Blogs_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: 'Tips & Topics in Blogs'),
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
          child: Image.asset('assets/icons/rayo.png',
              color: Colors.white, width: 35.0, height: 35.0),
        ),
      ),
      body: const Blogs_body(),
      bottomNavigationBar: const BarraNavegacion(),
      drawer: const SideBarMenu(),
    );
  }
}

class Blogs_body extends StatelessWidget {
  const Blogs_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      const SizedBox(height: 240, child: blogsCarousel(filter: "POPULAR")),
      const SizedBox(
        height: 40,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Posts", style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
      Expanded(
        child: BlocProvider(
            create: (context) =>
                BlogListBloc(GetIt.instance<GetBlogDataUseCase>())
                  ..add(const LoadBlogList(
                      page: 1,
                      perPage: 20,
                      filter: '',
                      trainer: '',
                      category: '')),
            child: BlocBuilder<BlogListBloc, BlogListState>(
              builder: (context, state) {
                if (state is BlogListLoading) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is BlogListLoaded) {
                  final blogs = state.blogs.sublist(0, 20);
                  return BlogGrid(blogs: blogs);
                }
                return const SizedBox();
              },
            )),
      ),
    ]);
  }
}

class BlogGrid extends StatelessWidget {
  final List<Blog> blogs;

  const BlogGrid({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
            ),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    print('Tapped on blog: ${blogs[index].title}');
                    //Navigator.push(context,
                    //  MaterialPageRoute(builder: (context) => Blog_Detailed_Widget(item: blogs[index]),
                    //  ),
                    //);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9.0),
                          child: Image.network(
                            blogs[index].images!.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 12.0,
                          right: 12.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              'New',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12.0,
                          left: 12.0,
                          right: 12.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blogs[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                blogs[index].category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
