import 'package:alpha_gymnastic_center/aplication/BLoC/progress/trending/trending_progress_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_trending_progress_use_case.dart';
import 'package:alpha_gymnastic_center/common/utils/string_utils.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/no_progress_section.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/progressbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import '../../../../domain/entities/blog.dart';
import '../../widgets/categoryItem.dart';
import '../../widgets/scrollHorizontal.dart';
// Importar el nuevo componente

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  List<String> Blog_images = [
    "https://www.bupasalud.com/sites/default/files/styles/640_x_400/public/articulos/2023-09/fotos/mujeres-practicando-yoga-en-el-gimnasio.jpg",
    "https://www.theclassyoga.com/wp-content/uploads/2021/08/yoga-1024x576.jpeg",
    "https://awtsuprints.com/cdn/shop/articles/how-to-get-started-with-calisthenics.jpg",
    "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/health/wp-content/uploads/2023/08/Calisthenic.jpeg.jpg",
    "https://media.post.rvohealth.io/wp-content/uploads/2020/10/Female_Yoga_1200x628-facebook-1200x628.jpg",
    "https://d2lcsjo4hzzyvz.cloudfront.net/blog/wp-content/uploads/2022/06/16173159/Recomendaciones-para-hacer-yoga-jpg.jpg"
  ];
  List<String> Blog_Title = [
    "Yoga for Beginners",
    "Mastering Gymnastics Skills",
    "Cycling: The Ultimate Guide",
    "Pilates for Core Strength",
    "Exploring the World of Dance",
    "Outdoor Running Tips"
  ];
  List<String> Blog_Desc = [
    "A comprehensive guide to starting your yoga journey.",
    "Key techniques for developing and mastering gymnastics skills.",
    "Everything you need to know to become an efficient cyclist.",
    "Build a strong core with these pilates exercises.",
    "Discover various forms of dance and their health benefits.",
    "Practical tips and strategies for improving your outdoor running experience."
  ];
  List<String> Blog_Dates = [
    "14/06/2024",
    "12/06/2024",
    "10/06/2024",
    "09/06/2024",
    "08/06/2024",
    "07/06/2024"
  ];
  List<String> Blog_Categories = [
    "Wellness",
    "Fitness",
    "Cycling",
    "Fitness",
    "Dance",
    "Running"
  ];

  HomeScreen({
    super.key,
    this.blogs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => TrendingProgressBloc(
          getTrendingProgressUseCase:
              GetIt.instance<GetTrendingProgressUseCase>(),
        )..add(LoadTrendingProgress()),
        child: MiScaffold(
          body: ListView(
            children: <Widget>[
              BlocBuilder<TrendingProgressBloc, TrendingProgressState>(
                builder: (context, state) {
                  if (state is TrendingProgressLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is TrendingProgressLoaded) {
                    return ProgressSection(
                      percent: state.progress.percent,
                    );
                  } else if (state is TrendingProgressError) {
                    if (state.message == "El usuario no posee progreso") {
                      return const NoProgressSection();
                    } else {
                      return Text('Error: ${state.message}');
                    }
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 140,
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 3.0, top: 3.0, left: 10),
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
              const SizedBox(
                height: 180,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 3.0, top: 0.0, left: 10),
                        child: Text(
                          'Procesos Populares',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PopularProcessesCarousel(),
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
                        padding:
                            EdgeInsets.only(bottom: 0.5, top: 0.0, left: 10),
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
                        children: <Widget>[
                          for (int index = 1; index < 7; index++)
                            ScrollHorizontal(
                              titulo: " ",
                              descripcion: " ",
                              categoria: " ",
                              fecha: " ",
                              fotoString:
                                  "assets/images/Yoga Ejemplo $index.png",
                              disposicion: 3,
                              isNew: false,
                              conexion: "/videos",
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 265,
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 0.0, left: 10),
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
                            titulo:
                                "15 Minutes yoga practice the beginner in 30 days",
                            descripcion: "Descripcion",
                            categoria: "Trainning",
                            fecha: "Feb 17, 2020",
                            fotoString: "assets/images/Yoga Ejemplo 5.png",
                            disposicion: 2,
                            isNew: false,
                            conexion: "/blogs",
                          ),
                          ScrollHorizontal(
                            titulo:
                                "23 Minutes yoga practice the beginner in 30 days",
                            descripcion: "Descripcion",
                            categoria: "Morning",
                            fecha: "Feb 18, 2020",
                            fotoString: "assets/images/Yoga Ejemplo 6.png",
                            disposicion: 2,
                            isNew: false,
                            conexion: "/blogs",
                          ),
                          ScrollHorizontal(
                            titulo:
                                "30 Minutes yoga practice the beginner in 30 days",
                            descripcion: "Descripcion",
                            categoria: "For Women",
                            fecha: "Feb 20, 2020",
                            fotoString: "assets/images/Yoga Ejemplo 4.png",
                            disposicion: 2,
                            isNew: false,
                            conexion: "/blogs",
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
  int? _selectedDayIndex = 1; // Por defecto, 'Hoy' está seleccionado
  final List<String> _days = ['Mañana', 'Hoy', 'Ayer'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String name = 'Nombre de Usuario';
        String email = 'ID de Usuario';

        if (state is UserLoaded) {
          name = getFirstTwoWords(state.user.name ?? 'Nombre de Usuario');
          email = state.user.email ?? 'Email';
        }

        return AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              onPressed: () {
                context.push('/profile');
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
                            Text(email,
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
                          // context.push('/popularSearch');
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
      },
    );
  }
}
