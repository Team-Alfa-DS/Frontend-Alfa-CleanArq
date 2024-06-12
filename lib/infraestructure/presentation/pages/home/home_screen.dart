import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/progressbar.dart';

import '../../../../domain/entities/blog.dart';
import '../../../../domain/entities/course.dart';
import '../../widgets/blogitem.dart';
import '../../widgets/categoryItem.dart';
import '../../widgets/courseitem.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Course> courses;
  List<Blog>? blogs;

  List<String> categories = [
    "assets/icons/cycling.png",
    "assets/icons/running.png",
    "assets/icons/streching.png",
    "assets/icons/swimming.png",
    "assets/icons/yoga.png",
  ];

  List<String> categoriesUnpicked = [
    "assets/icons/cycling_unpicked.png",
    "assets/icons/running_unpicked.png",
    "assets/icons/streching_unpicked.png",
    "assets/icons/swimming_unpicked.png",
    "assets/icons/yoga_unpicked.png",
  ];

  HomeScreen({
    super.key,
    required this.courses,
    this.blogs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: MiScaffold(
        body: ListView(
          children: <Widget>[
            const ProgressSection(),
            SizedBox(
              height: 160,
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 3.0, top: 3.0, left: 10),
                      child: Text(
                        'Categorías',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryItem(
                          imageUrlPicked: categories[index],
                          imageUrlUnpicked: categoriesUnpicked[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 3.0, top: 0.0, left: 10),
                      child: Text(
                        'Procesos Populares',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int index = 0; index < courses.length; index++)
                          courseItem(
                            imageUrl: courses[index].trainer.name,
                            imageSubtitle: courses[index].title,
                            imageTitle: courses[index].title,
                          ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.5, top: 0.0, left: 10),
                      child: Text(
                        'Videos de Cursos',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const <Widget>[
                        // Insert your video course items here
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.5, top: 0.0, left: 10),
                      child: Text(
                        'Nuestros últimos Blogs',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: blogs != null
                          ? [
                              for (int index = 0;
                                  index < blogs!.length;
                                  index++)
                                blogItem(
                                  id: blogs![index].id,
                                  imageUrl: blogs![index].images.first,
                                  title: blogs![index].title,
                                  description: blogs![index].description,
                                  date: blogs![index].date.toString(),
                                  category: blogs![index].category,
                                ),
                            ]
                          : [const SizedBox()],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const SideBarMenu(),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(210);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String name = 'Nombre de Usuario';
  String uuid = 'ID de Usuario';
  int? _selectedDayIndex = 1; // Por defecto, 'Hoy' está seleccionado
  final List<String> _days = ['Mañana', 'Hoy', 'Ayer'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Nombre de Usuario';
      uuid = prefs.getString('uuid') ?? 'ID de Usuario';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const Placeholder(), // Replace with actual profile page
              ),
            );
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text('ID: ${uuid.substring(0, 8)}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: TextField(
                    onTap: () {
                      Navigator.pushNamed(context, '/popularSearch');
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Buscar...',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _days.map((day) {
                  int index = _days.indexOf(day);
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 17,
                        color: _selectedDayIndex == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        fontWeight: _selectedDayIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
