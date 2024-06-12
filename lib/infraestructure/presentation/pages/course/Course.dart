import 'dart:math';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../domain/entities/course.dart';
import '../../../mappers/course/course_mapper.dart';
import '../../widgets/navegation.dart';
import 'Course_detailed.dart';

class Yoga_basics extends StatelessWidget {
  const Yoga_basics({super.key});

  @override
  Widget build(BuildContext context) {
    return const YogaHomePage(); // Directly return the page without wrapping it in another MaterialApp
  }
}

class YogaHomePage extends StatefulWidget {
  const YogaHomePage({super.key});

  @override
  _YogaHomePageState createState() => _YogaHomePageState();
}

class _YogaHomePageState extends State<YogaHomePage> {
  List<String> imageUrls = [
    'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-trainer-in-gym-royalty-free-image-1584723855.jpg',
    'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2018/12/Personal-Trainer-Training-Partner-GettyImages-654427364.jpg?quality=86&strip=all',
    'https://serviceninjas.in/wp-content/uploads/2021/12/yoga-2.jpg',
    'https://www.doyou.com/wp-content/uploads/2021/01/Kathryn-Budig-Yoga.jpg',
    'https://production-next-images-cdn.thumbtack.com/i/440633394583134208/desktop/standard/400square-legacy',
  ];
  List<String> imageTitles = [
    'Image 1',
    'Crossfit Inicial',
    'Image 3',
    'Image 4',
    'Image 5',
  ];
  List<String> imageSubtitles = [
    'Subtitle 1',
    'Subtitle 2',
    'Subtitle 3',
    'Subtitle 4',
    'Subtitle 5',
  ];

  List<String> descriptions = [
    'Descripcion 1',
    'Descripcion 2',
    'Descripcion 3',
    'Descripcion 4',
    'Descripcion 5',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Courses Proceses"),
      body: YogaBody(
        imageUrls: imageUrls,
        imageTitles: imageTitles,
        imageSubtitles: imageSubtitles,
        currentIndex: currentIndex,
        onPageChanged: (index, _) {
          setState(() {
            currentIndex = index;
          });
        },
        imageDescriptions: descriptions,
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
      drawer: const SideBarMenu(),
    );
  }
}

class YogaAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;

  const YogaAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(50),
      )),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
      leading: const BackButton(color: Colors.white),
    );
  }
}

class YogaBody extends StatelessWidget {
  final List<String> imageUrls;
  final List<String> imageTitles;
  final List<String> imageSubtitles;
  final int currentIndex;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final List<String> imageDescriptions;

  const YogaBody({
    super.key,
    required this.imageUrls,
    required this.imageTitles,
    required this.imageSubtitles,
    required this.currentIndex,
    required this.onPageChanged,
    required this.imageDescriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(45),
          ),
          child: GestureDetector(
            onDoubleTap: () {

              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YogaDetailScreen(
                    imageUrl: imageUrls[currentIndex],
                    title: imageTitles[currentIndex],
                    subtitle: imageSubtitles[currentIndex],
                    description: imageDescriptions[currentIndex],
                  ),
                ),
              );
              */
              var jsonResponse = {
                "title": "Sample Title",
                "description": "Sample Description",
                "category": "Fitness",
                "image": "https://serviceninjas.in/wp-content/uploads/2021/12/yoga-2.jpg",
                "trainer": {
                  "id": "trainer001",
                  "name": "John Doe"
                },
                "level": "intermediate",
                "durationWeeks": 4,
                "durationMinutes": 60,
                "tags": ["Workout", "Cardio", "Strength"],
                "date": "2024-06-11T00:00:00Z",
                "lessons": [
                  {
                    "id": "lesson001",
                    "title": "Lesson 1",
                    "content": "Introduction to the workout",
                    "video": "https://example.com/video1.mp4"
                  },
                  {
                    "id": "lesson002",
                    "title": "Lesson 2",
                    "content": "Cardio session",
                    "image": "https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-trainer-in-gym-royalty-free-image-1584723855.jpg"
                  }
                ]
              };

              print(jsonResponse);

              var course =  CourseMapper.fromJson(jsonResponse);

              redirectToCourseDetails(context,course);

            },
            child: SizedBox(
              height: 290,
              child: Stack(
                children: [
                  ClipRect(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 290,
                        autoPlay: true,
                        onPageChanged: onPageChanged,
                        scrollDirection: Axis.vertical, // Slide up and down
                      ),
                      items: imageUrls.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 16,
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
                  Positioned(
                    top: 10,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        '${currentIndex + 1} / ${imageUrls.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                imageTitles[currentIndex],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                imageSubtitles[currentIndex],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Text(
                    imageDescriptions[currentIndex],
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Level',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Beginner'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Weeks',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('4'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.green),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mins',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('30'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        NewYogaClassesCarousel(
          newImageUrls: imageUrls,
          newImageTitles: imageTitles,
          newImageSubtitles: imageSubtitles,
        ),
      ],
    );
  }

  void redirectToCourseDetails(BuildContext context,Course course) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Course_Detailed(course: course)));
  }

}

class NewYogaClassesCarousel extends StatelessWidget {
  final List<String> newImageUrls;
  final List<String> newImageTitles;
  final List<String> newImageSubtitles;

  const NewYogaClassesCarousel({
    super.key,
    required this.newImageUrls,
    required this.newImageTitles,
    required this.newImageSubtitles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'More Most Popular Courses',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180.0, // Adjust the height to accommodate two items per slide
          child: CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              // Adjust the height of each item
              aspectRatio: 2.0,
              // Adjust the aspect ratio to fit two items
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              scrollDirection: Axis.vertical,
              // Change to vertical scrolling
              viewportFraction: 1.0, // Show two items per slide
            ),
            items: List.generate(
              (newImageUrls.length + 1) ~/
                  2, // Divide the length by 2 to get the number of slides
                  (index) {
                final startIndex = index * 2;
                final endIndex = min(startIndex + 2, newImageUrls.length);
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 180.0,
                          child: Row(
                            children: [
                              for (int i = startIndex; i < endIndex; i++)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        // Replace this with your desired action
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${newImageTitles[i]} double-tapped!'),
                                          ),
                                        );
                                      },
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(9.0),
                                            child: Image.network(
                                              newImageUrls[i],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 12.0,
                                            right: 12.0,
                                            child: Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 12.0,
                                                vertical: 6.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                BorderRadius.circular(20.0),
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
                                                  begin:
                                                  Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.3),
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
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newImageTitles[i],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 4.0),
                                                Text(
                                                  newImageSubtitles[i],
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
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
