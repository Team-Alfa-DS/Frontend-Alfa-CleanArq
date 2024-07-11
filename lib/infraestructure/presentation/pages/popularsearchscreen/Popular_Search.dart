import 'package:alpha_gymnastic_center/aplication/BLoC/search/search_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/search/tagSearch_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/search/searchTags_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/search/search_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/blog/blog_detailed.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/course_details.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carrusel_h.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/infiniteScrollingListView.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../widgets/navegation.dart';
import '../../widgets/sidebarmenu.dart';

class PopularSearch extends StatefulWidget {
  final String initialSearch;
  
  const PopularSearch({super.key, required this.initialSearch});

  @override
  _PopularSearchState createState() => _PopularSearchState();
}

class _PopularSearchState extends State<PopularSearch> {
  String? categoriaSeleccionada;
  List<String> categorias = [];
  TextEditingController searchTextController = TextEditingController();
  SearchBloc searchBloc = SearchBloc(searchUseCase: GetIt.instance<SearchUseCase>());
  TagSearchBloc tagSearchBloc = TagSearchBloc(searchTagsUseCase: GetIt.instance<SearchTagsUseCase>());
  final List<Widget> _courseCards = [];
  final List<Widget> _blogCards = [];
  int _page = 0;
  final int _perpage = 5;
  final double _scrollThreshold = 0.8;
  bool noMoreContent = false;
  String searchText = '';
  
  @override
  void initState() {
    super.initState();
    searchText = widget.initialSearch;
    searchBloc.add(SearchSent(0, _perpage, const [], searchText));
    tagSearchBloc.add(const TagSearchSent(0, 20));
  }

  @override
  Widget build(BuildContext context) {
    // print('Entered search page');
    return Scaffold(
      body: SafeArea(
        child: _buildBlocProvider()
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

  Widget _buildBlocProvider() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => searchBloc),
        BlocProvider(create: (context) => tagSearchBloc)
      ], 
      child: _body(context)
    );
    // return BlocProvider(
    //   create: (context) => searchBloc,
    //   child: _body(context));
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
                  child: _buildSearchBar()
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
                _tagBlocBuilder(),
                const SizedBox(height: 30),
                const Text(
                  'Cursos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 195,
                  child: _buildCourseCards(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Blogs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: _buildBlogCards(),
                )
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
                    'Búsqueda',
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

  Widget _tagBlocBuilder() {
    /*return BlocProvider(
      create: (context) => tagSearchBloc,
      child:*/ return BlocBuilder(
        bloc: tagSearchBloc,
        builder: (context, state) {
          if (state is TagSearchLoading) {
            return const CircularProgressIndicator();
          }

          if (state is TagSearchSuccess) {
            categorias = state.tags;
          }

          return categoriasBotones();
        }
      );
    // );
  }

  Widget categoriasBotones() {
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
                // print('Category pressed');
                _newSearch();
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

  Widget _buildSearchBar() {
    // return BlocBuilder<SearchBloc, SearchState>(
    //   bloc: searchBloc,
    //   builder: (context, state) {
        return TextField(
            controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Buscar...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => searchTextController.clear(),
              ),
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (searchTextController.text.isNotEmpty) {
                    searchText = searchTextController.text;
                    _newSearch();
                  }
                }
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
              )
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                searchText = value;
                _newSearch();
              }
            },
          );
        //);
      // }
    // );
  }

  Widget _buildCourseCards() {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchSuccess) {
          if (state.result.courses.isNotEmpty || state.result.blogs.isNotEmpty) {
            _page++;
          } else {
            noMoreContent = true;
          }
          for (var course in state.result.courses) {
            // _courseCards.add(ScrollHorizontal(
            //   titulo: course.title,
            //   descripcion: '', 
            //   categoria: course.categoryName, 
            //   fecha: '${course.date.day}/${course.date.month}/${course.date.year}', 
            //   fotoProvider: NetworkImage(course.image), 
            //   disposicion: 2, 
            //   isNew: false, 
            //   conexion: '/videos'));
            _courseCards.add(
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => CourseDetailedScreen(courseId: course.id)
                    )
                  );
                },
                child: ScrollH<Map<String, dynamic>>(
                  item: {
                    'titulo': course.title,
                    'descripcion': '',
                    'categoria': course.categoryName,
                    'fecha': '${course.date.day}/${course.date.month}/${course.date.year}',
                    'fotoUrl': course.image,
                    'isNew': false,
                    'conexion': '/videos'
                  }, 
                  disposicion: 2,
                ),
              )
            );
          }
        }
        List<String> tags = [];
        if (categoriaSeleccionada != null) {
          tags = [categoriaSeleccionada!];
        }
        return InfiniteScrollingSearch(
          widgetList: _courseCards, 
          scrollThreshold: _scrollThreshold - 0.2, 
          scrollAxis: Axis.horizontal,
          page: _page,
          perpage: _perpage,
          tags: tags,
          term: searchText,
          noMoreContent: noMoreContent,
        );
      });
  }

  Widget _buildBlogCards() {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchSuccess) {
          for (var blog in state.result.blogs) {
            _blogCards.add(
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => Blog_Detailed_Widget(blogId: blog.id)
                    )
                  );
                },
                child: programsMaster(blog.title, blog.trainerName, blog.categoryName, blog.image),
              )
            );
          }
        }
        List<String> tags = [];
        if (categoriaSeleccionada != null) {
          tags = [categoriaSeleccionada!];
        }
        return InfiniteScrollingSearch(
            widgetList: _blogCards,
            scrollThreshold: _scrollThreshold, 
            scrollAxis: Axis.vertical, 
            page: _page, 
            perpage: _perpage, 
            tags: tags, 
            term: searchText,
            noMoreContent: noMoreContent,
            );
      });
  }

  void _newSearch() {
  // print('newSearch');
  _page = 0;
  _courseCards.clear();
  _blogCards.clear();
  noMoreContent = false;
  if (categoriaSeleccionada != null) {
    searchBloc.add(
      SearchSent(_page, _perpage, [categoriaSeleccionada!], searchText) //TODO: Test Search only, still need to add filter by tag and whatever the fuck i have to do with pagination
    );
  } else {
    searchBloc.add(
      SearchSent(_page, _perpage, const [], searchText) //TODO: Test Search only, still need to add filter by tag and whatever the fuck i have to do with pagination
    );
  }
  //  BlocListener(
  //   bloc: searchBloc,
  //   listener: (context, state) {
      
  //   });
  }
}
