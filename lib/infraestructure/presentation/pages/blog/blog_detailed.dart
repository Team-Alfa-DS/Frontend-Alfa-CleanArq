import 'package:alpha_gymnastic_center/aplication/BLoC/blog/blog_one/blog_one_event.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/blog/get_blog_one_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: BlocBuilder<blogOneBloc, BlogOneState>(
        builder: (context, state) {
          if (state is BlogOneLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogOneFailed) {
            return Center(child: Text('Error: ${state.failure}'));
          } else if (state is BlogOneLoaded) {
            final blogitem = state.blog;
            return Column(
              children: [
                YogaAppBar(title: blogitem.title),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  blogitem.description!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'All the Images!',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromRGBO(255, 255, 255, 0.0),
                                ),
                              ),
                              onPressed: () {
                                navigateToComments(context, blog.id, "BLOG", blogitem.title);
                              },
                              child: const Text(
                                'Check Comments',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: bottomInset, left: 8, right: 8),
                          child: ListView.builder(
                            itemCount: blogitem.images!.length,
                            itemBuilder: (context, index) {
                              final panel = blogitem.images![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        panel,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
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
              ],
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
}
