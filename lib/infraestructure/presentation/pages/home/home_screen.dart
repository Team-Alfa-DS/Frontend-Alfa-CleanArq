import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/progressbar.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/profilescreen/profile.dart'
    as profile;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              height: 230,
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 3.0, top: 3.0),
                      child: Text(
                        'Categoría de Yoga',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const <Widget>[
                        ScrollHorizontal(
                          titulo: 'Ciclismo',
                          descripcion: '',
                          categoria: 'Ciclismo',
                          fecha: '',
                          foto: 'assets/icons/ciclismo.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '',
                        ),
                        ScrollHorizontal(
                          titulo: 'Yoga',
                          descripcion: '',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/icons/meditacion.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '',
                        ),
                        ScrollHorizontal(
                          titulo: 'Natación',
                          descripcion: '',
                          categoria: 'Natación',
                          fecha: '',
                          foto: 'assets/icons/nadador.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '',
                        ),
                        ScrollHorizontal(
                          titulo: 'Trote',
                          descripcion: '',
                          categoria: 'Trote',
                          fecha: '',
                          foto: 'assets/icons/correr.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '',
                        ),
                        ScrollHorizontal(
                          titulo: 'Estiramiento',
                          descripcion: '',
                          categoria: 'Estiramiento',
                          fecha: '',
                          foto: 'assets/icons/Estirar.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 3.0, top: 0.0, left: 8),
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
                      children: const <Widget>[
                        ScrollHorizontal(
                          titulo: 'Tadasana Yaga',
                          descripcion: 'Yoga App',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/Yoga Ejemplo 1.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '/Courses',
                        ),
                        ScrollHorizontal(
                          titulo: 'Marvin McKinny',
                          descripcion: 'Yoga App',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/Yoga Ejemplo 2.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '/Courses',
                        ),
                        ScrollHorizontal(
                          titulo: 'Carlos Alonso',
                          descripcion: 'Yogga App',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/Yoga Ejemplo 4.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '/Courses',
                        ),
                        ScrollHorizontal(
                          titulo: 'Ralph Tobirson',
                          descripcion: 'Yoga App',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/Yoga Ejemplo 6.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '/Courses',
                        ),
                        ScrollHorizontal(
                          titulo: 'Maria Galvis',
                          descripcion: 'Yoga App',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/Yoga Ejemplo 5.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '/Courses',
                        ),
                        ScrollHorizontal(
                          titulo: 'Haily Bieber',
                          descripcion: 'Yoga App',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/Yoga Ejemplo 7.png',
                          disposicion: 2,
                          isNew: false,
                          conexion: '/Courses',
                        ),
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
                      padding: EdgeInsets.only(bottom: 0.5, top: 0.0),
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
                        ScrollHorizontal(
                          titulo: '',
                          descripcion: '',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/yoga_video_1.png',
                          disposicion: 3,
                          isNew: true,
                          conexion: '/videos',
                        ),
                        ScrollHorizontal(
                          titulo: '',
                          descripcion: '',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/yoga_video_2.png',
                          disposicion: 3,
                          isNew: true,
                          conexion: '/videos',
                        ),
                        ScrollHorizontal(
                          titulo: '',
                          descripcion: '',
                          categoria: 'Yoga',
                          fecha: '',
                          foto: 'assets/images/yoga_video_3.png',
                          disposicion: 3,
                          isNew: false,
                          conexion: '/videos',
                        ),
                        ScrollHorizontal(
                          titulo: '',
                          descripcion: '',
                          categoria: 'Estiramiento',
                          fecha: '',
                          foto: 'assets/images/yoga_video_4.png',
                          disposicion: 3,
                          isNew: true,
                          conexion: '/videos',
                        ),
                        ScrollHorizontal(
                          titulo: '',
                          descripcion: '',
                          categoria: 'Estiramiento',
                          fecha: '',
                          foto: 'assets/images/yoga_video_5.png',
                          disposicion: 3,
                          isNew: false,
                          conexion: '/videos',
                        ),
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
                      padding: EdgeInsets.only(bottom: 0.5, top: 0.0),
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
                      children: const <Widget>[
                        ScrollHorizontal(
                          titulo: 'Nuevo estilo de Yoga para este 2024',
                          descripcion:
                              'Expertos han desarrollado un efectivo tipo de Yoga...',
                          categoria: 'Yoga',
                          fecha: 'May 10, 2024',
                          foto: 'assets/images/yoga_blog_1.png',
                          disposicion: 1,
                          isNew: false,
                          conexion: '/blogs',
                        ),
                        ScrollHorizontal(
                          titulo: 'Beneficios del Yoga para la tercera edad',
                          descripcion:
                              'Estudios medicos te hablan de las ventajas...',
                          categoria: 'Yoga',
                          fecha: 'May 11, 2024',
                          foto: 'assets/images/yoga_blog_2.png',
                          disposicion: 1,
                          isNew: true,
                          conexion: '/blogs',
                        ),
                        ScrollHorizontal(
                          titulo: 'Herramientas para comenzar en Yoga',
                          descripcion:
                              'Te hablamos de lo indispensable para que...',
                          categoria: 'Yoga',
                          fecha: 'May 11, 2024',
                          foto: 'assets/images/yoga_blog_3.png',
                          disposicion: 1,
                          isNew: true,
                          conexion: '/blogs',
                        ),
                        ScrollHorizontal(
                          titulo: 'Amistades en el Yoga',
                          descripcion: 'Conoce cómo puedes relacionarte...',
                          categoria: 'Yoga',
                          fecha: 'May 12, 2024',
                          foto: 'assets/images/yoga_blog_4.png',
                          disposicion: 1,
                          isNew: true,
                          conexion: '/blogs',
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
    return WillPopScope(
      onWillPop: () async => false,
      child: AppBar(
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
                  builder: (context) => const profile.PerfilUsuario(),
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
              bottomRight: Radius.circular(30.0), // Redondea la esquina aquí
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0), // Aumenta el padding vertical aquí
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
                          Text(
                              'ID: ${uuid.substring(0, 8)}', // Muestra solo los primeros 8 caracteres del ID aquí
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _days.map((day) {
                      int index = _days.indexOf(day);
                      return FilterChip(
                        label: Text(day),
                        selected: _selectedDayIndex == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedDayIndex = selected ? index : null;
                          });
                        },
                        selectedColor: Colors.transparent,
                        checkmarkColor: Colors.black,
                        backgroundColor: Colors.transparent,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
