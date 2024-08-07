import 'package:alpha_gymnastic_center/aplication/BLoC/progress/trending/trending_progress_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/search/search_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_trending_progress_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/search/search_use_case.dart';
import 'package:alpha_gymnastic_center/common/utils/string_utils.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/popularsearchscreen/Popular_Search.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/blogsCaursel.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/no_progress_section.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses_h.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/sidebarmenu.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/categorycarousel.dart';
import '../../widgets/scrollHorizontal.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> categories = [
    "assets/icons/cycling.png",
    "assets/icons/running.png",
    "assets/icons/streching.png",
    "assets/icons/swimming.png",
    "assets/icons/yoga.png",
  ];

  final List<String> categoriesUnpicked = [
    "assets/icons/cycling_unpicked.png",
    "assets/icons/running_unpicked.png",
    "assets/icons/streching_unpicked.png",
    "assets/icons/swimming_unpicked.png",
    "assets/icons/yoga_unpicked.png",
  ];

  HomeScreen({
    super.key,
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
              const SizedBox(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 3.0, top: 3.0, left: 10),
                        child: Text(
                          'Categorías',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CategoryCarousel(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, top: 0.0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Procesos Populares',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push('/trainingScreen');
                            },
                            child: const Text(
                              'Ver más...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 100, 0, 161),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: PopularCoursesCarousel(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, top: 0.0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Videos de Cursos',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/videos');
                            },
                            child: const Text(
                              'Ver más...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 100, 0, 161),
                              ),
                            ),
                          ),
                        ],
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
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 0.0, top: 0.0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nuestros últimos Blogs',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/blogs');
                            },
                            child: const Text(
                              'Ver más...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 100, 0, 161),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const blogsCarousel(),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '© 2024 Mi Aplicación',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10), // Espacio entre los textos
                    Text(
                      'Versión 1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
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
  Size get preferredSize => const Size.fromHeight(150);
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController searchText = TextEditingController();

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

        return PreferredSize(
          preferredSize: const Size.fromHeight(20.0), // Altura total del AppBar
          child: AppBar(
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
              height: 190.0, // Altura del fondo morado
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
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
                      const SizedBox(
                          height:
                              15), // Espacio entre los textos y el SearchBar
                      Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: _buildSearchBar()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return BlocProvider(
        create: (context) =>
            SearchBloc(searchUseCase: GetIt.instance<SearchUseCase>()),
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return TextField(
            controller: searchText,
            decoration: InputDecoration(
                hintText: 'Buscar...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => searchText.clear(),
                ),
                prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (searchText.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PopularSearch(
                                    initialSearch: searchText.text)));
                      }
                    }),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PopularSearch(
                              initialSearch: value,
                            )));
              }
            },
          );
          //);
        }));
  }
}
