import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/videoplayer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _body(BuildContext context) {
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
          itemCount: 8,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            String imagePath = 'assets/images/Yoga Ejemplo ${index + 1}.png';
            String videoUrl =
                'https://res.cloudinary.com/dy2fub3tg/video/upload/v1718068963/wc0ow0kqqsgsi7wkofjw.mp4'; // URL del video en Cloudinary
            String courseId =
                'courseId_${index + 1}'; // ID del curso, cambiar según sea necesario
            String lessonId =
                'lessonId_${index + 1}'; // ID de la lección, cambiar según sea necesario
            return cajaVideo(context, imagePath, videoUrl, courseId, lessonId);
          },
        ),
      ],
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
      String courseId, String lessonId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              videoPath: videoPath,
              courseId: courseId,
              lessonId: lessonId,
            ),
          ),
        );
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
                  child: Image.asset(
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
