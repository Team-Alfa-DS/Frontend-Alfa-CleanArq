import 'dart:core';

import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/blog/blog_detailed.dart';

import '../../widgets/navegation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/sidebarmenu.dart';


class Blogs_Screen extends StatelessWidget {


  //esto es un mimic o mock de como un item me va dar el backend como response:
  final List<Map<String, String>> MockBlogs = [
    { 'id': 'asdasd',
      'title': 'Blog 1',
      'image': 'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-trainer-in-gym-royalty-free-image-1584723855.jpg',
      'date' : '20/04/23',
      'category' : 'Category 1',
      'trainer' : '12345'
    },
  ];

  //mientras tanto ando usando estos otros mocks pero la idea es ponerlo como funciona en el anterior arriba para que ya sea compatible con el JSON del Response completo.
  List<String> ids = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  List<String> imageUrls = [
    'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-trainer-in-gym-royalty-free-image-1584723855.jpg',
    'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2018/12/Personal-Trainer-Training-Partner-GettyImages-654427364.jpg?quality=86&strip=all',
    'https://serviceninjas.in/wp-content/uploads/2021/12/yoga-2.jpg',
    'https://www.doyou.com/wp-content/uploads/2021/01/Kathryn-Budig-Yoga.jpg',
    'https://production-next-images-cdn.thumbtack.com/i/440633394583134208/desktop/standard/400square-legacy',
  ];
  List<String> imageTitles = [
    'Tip 1',
    'Tip 2',
    'Tip 3',
    'Tip 4',
    'Tip 5',
  ];
  List<String> imageSubtitles = [
    'Subtitle 1',
    'Subtitle 2',
    'Subtitle 3',
    'Subtitle 4',
    'Subtitle 5',
  ];

  List<String> Categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];

  List<String> descriptions = [
    'Descripcion del Tip 1 . Descripcion del Tip 1 .Descripcion del Tip 1 .',
    'Descripcion del Tip 2 . Descripcion del Tip 2 .Descripcion del Tip 2 .',
    'Descripcion del Tip 3 . Descripcion del Tip 3 .Descripcion del Tip 3 .',
    'Descripcion del Tip 4 . Descripcion del Tip 4 .Descripcion del Tip 4 .',
    'Descripcion del Tip 5 . Descripcion del Tip 5 .Descripcion del Tip 5 .',
  ];
  List<String> dates = [
    '20/04/23',
    '15/03/21',
    '12/04/22',
    '01/12/23',
    '02/10/23',
  ];

  int currentIndex = 0;

  Blogs_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Blogs_appbar(
        title: "Tips & Topics (Blogs)",
        onCategoryTapped: (index) {
          // Handle category tapping based on the index
          switch (index) {
            case 0:
              break;
            case 1:
              // Handle Strength Training category tapping
              break;
            // Add cases for the rest of the categories
            default:
              break;
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
          child: Image.asset('assets/icons/rayo.png',
              color: Colors.white, width: 35.0, height: 35.0),
        ),
      ),
      body: Tips_n_Topics_body(
        ids: ids,
        imageUrls: imageUrls,
        titles: imageTitles,
        categories: Categories,
        dates: dates,
        subtitles: imageSubtitles,
        description: descriptions,
      ),
      bottomNavigationBar: const BarraNavegacion(),
      drawer: const SideBarMenu(),
    );
  }
}

class Tips_n_Topics_body extends StatelessWidget {

  final List<String> ids;
  final List<String> imageUrls;
  final List<String> titles;
  final List<String> categories;
  final List<String> dates;
  final List<String> subtitles;
  final List<String> description;

  const Tips_n_Topics_body({
    super.key,
    required this.ids,
    required this.imageUrls,
    required this.titles,
    required this.categories,
    required this.dates,
    required this.subtitles,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(
          height: 240,
          child: HorizontalCarousel(
            ids: ids,
            imageUrls: imageUrls,
            titles: titles,
            categories: categories,
            dates: dates,
            description: description,
          ),
        ),
        SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Post", style: TextStyle(fontSize: 24)),
                ElevatedButton(
                  onPressed: /* navigate a una pantalla */ null,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: const Text(
                    'See All >',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: NewYogaClassesPanelGrid(
                newImageUrls: imageUrls,
                newImageTitles: titles,
                newImageSubtitles: subtitles))
      ],
    );
  }
}

class NewYogaClassesPanelGrid extends StatelessWidget {
  final List<String> newImageUrls;
  final List<String> newImageTitles;
  final List<String> newImageSubtitles;

  const NewYogaClassesPanelGrid({
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
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
            ),
            itemCount: newImageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9.0),
                      child: Image.network(
                        newImageUrls[index],
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
                            newImageTitles[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            newImageSubtitles[index],
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
              );
            },
          ),
        ),
      ],
    );
  }
}

class HorizontalCarousel extends StatefulWidget {

  final List<String> ids;
  final List<String> imageUrls;
  final List<String> titles;
  final List<String> categories;
  final List<String> dates;
  final List<String> description;

  const HorizontalCarousel({
    super.key,
    required this.imageUrls,
    required this.titles,
    required this.categories,
    required this.dates,
    required this.description,
    required this.ids,
  });

  @override
  _HorizontalCarouselState createState() => _HorizontalCarouselState();
}

class _HorizontalCarouselState extends State<HorizontalCarousel> {
  late CarouselController _carouselController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent)),
                                onPressed: () => { },
                                child: Text(
                                  widget.titles[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.categories[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    widget.dates[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
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
              );
            },
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 0.6,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imageUrls.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 5.0,
                    backgroundColor: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            )),
      ],
    );
  }

 /* void navigateToDetailed(
      BuildContext context) {

    //busca en el repositorio un bloc detallado dado el id que llega del parametro de esta funcion y luego se lo pones al la llamada del widget

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  Blog_Detailed_Widget(item : )));
  }*/
}

class Blogs_appbar extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);

  final String title;
  final List<String> categories = [
    'Yoga',
    'Strength Training',
    'Cardio',
    'Pilates',
    'Cycling',
    'Running',
  ];

  final void Function(int) onCategoryTapped;

  Blogs_appbar({
    super.key,
    required this.title,
    required this.onCategoryTapped,
  });

  @override
  _Tips_n_Topics_appbarState createState() => _Tips_n_Topics_appbarState();
}

class _Tips_n_Topics_appbarState extends State<Blogs_appbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(50),
      ),
      child: AppBar(
        title: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
            child: SizedBox(
              height: 20.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      widget.onCategoryTapped(index);
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        IntrinsicWidth(
                          child: Container(
                            decoration: BoxDecoration(
                              color: index == _selectedIndex
                                  ? Colors.deepPurple
                                  : Colors.deepPurple.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8.0,
                                  height: 14.0,
                                  decoration: BoxDecoration(
                                    color: index == _selectedIndex
                                        ? Colors.white
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Text(
                                    widget.categories[index],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: index == _selectedIndex
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 16.0),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white),
      ),
    );
  }
}
