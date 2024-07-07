import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/commons/COlors.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class CourseManagementScreen extends StatefulWidget {
  const CourseManagementScreen({super.key});

  @override
  _CourseManagementScreenState createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  List<Course> _courses = [];
  List<Trainer> _trainers = [
    Trainer(id: '1', name: 'Juan'),
    Trainer(id: '2', name: 'Elisa'),
    Trainer(id: '3', name: 'Diana'),
    Trainer(id: '3', name: 'Mario'),
  ]; // lista de trainers existentes
  List<Lesson> _lessons = []; // lista de lecciones existentes

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() async {
    // Llamar a la función para traer todos los cursos
    // Aquí puedes agregar la lógica para traer los cursos desde tu base de datos
    List<Course> courses = await _getAllCourses();
    setState(() {
      _courses = courses;
    });
  }

  Future<List<Course>> _getAllCourses() async {
    // Simulación de datos
    List<Course> courses = [
      Course(
        id: '1',
        title: 'Curso 1',
        description: 'Descripción del curso 1',
        category: 'Categoria 1',
        image: 'imagen1.jpg',
        trainer: _trainers[0],
        level: 'Básico',
        durationWeeks: 4,
        durationMinutes: 60,
        tags: ['programación', 'desarrollo'],
        date: DateTime.now(),
        lessons: [
          Lesson(
              id: '1',
              title: 'Lección 1',
              content: 'Descripción de la lección 1'),
          Lesson(
              id: '2',
              title: 'Lección 2',
              content: 'Descripción de la lección 2'),
        ],
      ),
      Course(
        id: '2',
        title: 'Curso 2',
        description: 'Descripción del curso 2',
        category: 'Categoria 2',
        image: 'imagen2.jpg',
        trainer: _trainers[1],
        level: 'Intermedio',
        durationWeeks: 8,
        durationMinutes: 120,
        tags: ['diseño', 'ux'],
        date: DateTime.now(),
        lessons: [
          Lesson(
              id: '3',
              title: 'Lección 3',
              content: 'Descripción de la lección 3'),
          Lesson(
              id: '4',
              title: 'Lección 4',
              content: 'Descripción de la lección 4'),
        ],
      ),
      //...
    ];
    return courses;
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Course Management"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Barra de búsqueda
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Buscar curso',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Lista de cursos
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(
                        // builder: (context) => UpdateCourseScreen(
                        //  course: _courses[index],
                        // trainers: _trainers,
                        // lessons: _lessons,
                        // ),
                        //),
                        // );
                      },
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryLightColor,
                        child: Text(
                          _courses[index].title.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                      title: Text(_courses[index].title),
                      subtitle: Text(_courses[index].category),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  );
                },
              ),
            ),
            // Botones de crear y eliminar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ManagementButton(
                  title: 'Crear Curso',
                  onPressed: () {
                    // Navegar a la pantalla de crear curso
                    //Navigator.push(
                    // context,
                    //                    MaterialPageRoute(
                    //  builder: (context) => CreateCourseScreen(
                    //       trainers: _trainers,
                    //       lessons: _lessons,
                    //     )),
                    //  );
                  },
                  backgroundColor: AppColors.primaryLightColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagementButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const _ManagementButton(
      {required this.title,
      required this.onPressed,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
