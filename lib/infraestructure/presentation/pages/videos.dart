import 'package:alpha_gymnastic_center/aplication/BLoC/videos/videos_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/video_use_case/get_videos_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:alpha_gymnastic_center/infraestructure/presentation/navegation/navigate_videoplayer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // Ahora la inicialización del Bloc y la carga de videos se realiza en la jerarquía de widgets correcta.
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VideosBloc(getVideosUseCase: GetIt.instance<GetVideosUseCase>())
            ..add(LoadVideos()),
      child: Scaffold(
        body: SafeArea(
          child: _body(context),
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
            child: Image.asset('assets/icons/rayo.png',
                color: Colors.white, width: 35.0, height: 35.0),
          ),
        ),
        bottomNavigationBar: const BarraNavegacion(),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
      builder: (context, state) {
        if (state is VideoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VideoLoaded) {
          return ListView(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      image: DecorationImage(
                        image: AssetImage('assets/logo/Fondo Morado.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                    height: 110.0,
                  ),
                  Positioned(
                    top: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: AppBar(
                      titleSpacing: 0.0,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      title: const Row(
                        children: [
                          Text(
                            'Videos',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70.0,
                    left: 0.0,
                    right: 0.0,
                    child: Column(
                      children: [
                        Categorias(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Video Course',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.courses.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final course = state.courses[index];
                  final lesson =
                      course.lessons.isNotEmpty ? course.lessons[0] : null;
                  if (lesson == null) {
                    return Container();
                  }
                  return cajaVideo(
                    context,
                    course.image,
                    lesson.video!,
                    course.id!,
                    lesson.id,
                    lesson.title,
                  );
                },
              ),
            ],
          );
        } else if (state is VideoError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  Widget Categorias() {
    List<String> categories = [
      'Most Popular',
      'Nutrition',
      'Training',
      'Weight Loss',
      'For Women',
    ];

    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String categoryName = categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                    height: 20,
                    child: Icon(
                      Icons.circle,
                      size: 10,
                      color: index == _selectedCategoryIndex
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 12,
                      color: index == _selectedCategoryIndex
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cajaVideo(BuildContext context, String coverImage, String videoPath,
      String courseId, String lessonId, String videoTitle) {
    return GestureDetector(
      onTap: () {
        navigateToVideoPlayer(
            context, // Pasar el contexto desde Videos
            videoPath,
            courseId,
            lessonId,
            videoTitle);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 8,
          right: 8,
          bottom: 20,
        ),
        child: SizedBox(
          height: 80.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    coverImage,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  size: 60.0,
                  color: Colors.grey.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
