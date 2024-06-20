import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/searchbar.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:flutter/material.dart';

import '../../widgets/navegation.dart';
import '../../widgets/sidebarmenu.dart';

class PopularSearch extends StatefulWidget {
  const PopularSearch({super.key});

  @override
  _PopularSearch createState() => _PopularSearch();
}

class _PopularSearch extends State<PopularSearch> {
  String? categoriaSeleccionada;

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
      drawer: const SideBarMenu(),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo/Fondo Morado.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
              ),
            ),
            height: 100.0,
          ),
          Card(
            elevation: 20.0,
            margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 70.0),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              children: [
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: Colors.white,
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0.0,
                          left: 0,
                          right: 0,
                        ),
                        child: BarraBusqueda(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 20.0,
            margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 140.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                categoriasBotones(),
                const SizedBox(height: 30),
                const Text(
                  'Popular Courses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 195,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ScrollHorizontal(
                        titulo:
                            "15 Minutes yoga practice the beginner in 30 days",
                        descripcion: "Descripcion",
                        categoria: "Trainning",
                        fecha: "Feb 17, 2020",
                        foto: "assets/images/Yoga Ejemplo 1.png",
                        disposicion: 2,
                        isNew: false,
                        conexion: "/videos",
                      ),
                      ScrollHorizontal(
                        titulo:
                            "23 Minutes yoga practice the beginner in 30 days",
                        descripcion: "Descripcion",
                        categoria: "Morning",
                        fecha: "Feb 18, 2020",
                        foto: "assets/images/Yoga Ejemplo 2.png",
                        disposicion: 2,
                        isNew: false,
                        conexion: "/videos",
                      ),
                      ScrollHorizontal(
                        titulo:
                            "30 Minutes yoga practice the beginner in 30 days",
                        descripcion: "Descripcion",
                        categoria: "For Women",
                        fecha: "Feb 20, 2020",
                        foto: "assets/images/Yoga Ejemplo 3.png",
                        disposicion: 2,
                        isNew: false,
                        conexion: "/videos",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Programs Master',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                programsMaster(
                  '30 day yoga challenge',
                  'Ralph Edwards',
                  'Level 5',
                  'assets/images/Yoga Ejemplo 4.png',
                ),
                programsMaster(
                  '30 day yoga challenge',
                  'Ralph Edwards',
                  'Level 5',
                  'assets/images/Yoga Ejemplo 5.png',
                ),
                programsMaster(
                  '30 day yoga challenge',
                  'Ralph Edwards',
                  'Level 5',
                  'assets/images/Yoga Ejemplo 6.png',
                ),
                programsMaster(
                  '30 day yoga challenge',
                  'Ralph Edwards',
                  'Level 5',
                  'assets/images/Yoga Ejemplo 7.png',
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              titleSpacing: 0.0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Row(
                children: [
                  Text(
                    'Popular Search',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriasBotones() {
    List<String> categorias = [
      'Prenatal',
      'For Women',
      'Trainning',
      'Courses',
      'Videos',
      'Morning',
      'Yoga',
      'Restorative',
      'Recent Post',
      'Most Popular',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 15.0,
          runSpacing: 5.0,
          children: categorias.map((categoria) {
            bool isSelected = categoria == categoriaSeleccionada;

            return ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    categoriaSeleccionada = null;
                  } else {
                    categoriaSeleccionada = categoria;
                  }
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 18.0,
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return isSelected
                        ? Colors.deepPurple
                        : Colors.deepPurple[100]!;
                  },
                ),
              ),
              child: Text(
                categoria,
                style: TextStyle(
                  fontSize: 14.0,
                  color:
                      isSelected ? Colors.deepPurple[100]! : Colors.deepPurple,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget PopularCourses(
      String title, String category, String date, String imagePath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200.0,
        margin: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 200.0,
                      height: 100.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget programsMaster(
      String title, String instructor, String difficulty, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  instructor,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  difficulty,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
