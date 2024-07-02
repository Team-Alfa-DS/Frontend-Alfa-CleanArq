import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/course_card.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses_h.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_event.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({Key? key}) : super(key: key);

  @override
  TrainingViewState createState() => TrainingViewState();
}

class TrainingViewState extends State<TrainingView> {
  late final CourseListBloc _courseListBloc;
  final ScrollController _scrollController = ScrollController();
  String? _selectedLevel;
  bool _isLoadingMore = false;
  bool _hasLoadedAllCourses = false;
  bool _isReloading = false;
  int _previousCourseCount = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final courseRepository = GetIt.instance<CourseRepository>();
    _courseListBloc = CourseListBloc(
      GetCourseDataUseCase(courseRepository: courseRepository),
    );
    _courseListBloc
        .add(LoadCourseList(page: _currentPage, perPage: 3, filter: 'RECENT'));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _courseListBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoadingMore && !_hasLoadedAllCourses) {
        setState(() {
          _isLoadingMore = true;
        });
        _currentPage++;
        _courseListBloc.add(
            LoadCourseList(page: _currentPage, perPage: 3, filter: 'RECENT'));
      }
    }
  }

  Widget _buildLevelButton(String level) {
    bool isSelected = _selectedLevel == level;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          setState(() {
            _selectedLevel = level;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              level,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (isSelected) const SizedBox(width: 10),
            if (isSelected)
              const CircleAvatar(
                radius: 7,
                backgroundColor: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _courseListBloc,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            title: const Text(
              'Entrenamiento',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLevelButton('Avanzado'),
                          _buildLevelButton('Intermedio'),
                          _buildLevelButton('Principiante'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cursos más Populares',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                height: 100,
                child: PopularCoursesCarousel(),
              ),
              const SizedBox(height: 20),
              Container(
                height: 1,
                color: Colors.grey[300],
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              const Text(
                'Programador Maestro',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<CourseListBloc, CourseListState>(
                  builder: (context, state) {
                    if (state is CourseListLoading && state.courses.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CourseListLoaded) {
                      _hasLoadedAllCourses = state.hasReachedMax;
                      _isLoadingMore = false;

                      return ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.courses.length +
                            (_hasLoadedAllCourses ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < state.courses.length) {
                            return CourseCard(course: state.courses[index]);
                          } else if (_hasLoadedAllCourses) {
                            return _buildEndOfListMessage();
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else if (state is CourseListFailed) {
                      return _buildEndOfListMessage();
                    } else {
                      return const Center(
                        child: Text('No hay cursos disponibles'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndOfListMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _reloadCourses,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.refresh, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            if (_hasLoadedAllCourses)
              Text(
                'Llegaste al final.\nVuelve pronto para más cursos.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[Color(0xFF4F14A0), Color(0xFF8066FF)],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
            if (_isReloading && _hasLoadedAllCourses)
              Column(
                children: [
                  Text(
                    'No se encontraron cursos nuevos al recargar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[Color(0xFF4F14A0), Color(0xFF8066FF)],
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Presiona de nuevo para recargar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[Color(0xFF4F14A0), Color(0xFF8066FF)],
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _reloadCourses() {
    setState(() {
      _isReloading = true;
    });

    final currentState = _courseListBloc.state;
    if (currentState is CourseListLoaded) {
      _previousCourseCount = currentState.courses.length;
    }

    _courseListBloc
        .add(LoadCourseList(page: _currentPage, perPage: 4, filter: 'RECENT'));

    _courseListBloc.stream.listen((state) {
      if (state is CourseListLoaded) {
        setState(() {
          _isReloading = false;
          _hasLoadedAllCourses = state.hasReachedMax;
          _isLoadingMore = false;
          if (state.courses.length > _previousCourseCount) {
            _previousCourseCount = state.courses.length;
          }
        });
      } else if (state is CourseListFailed) {
        setState(() {
          _isReloading = false;
          _hasLoadedAllCourses = true;
        });
      }
    });
  }
}
