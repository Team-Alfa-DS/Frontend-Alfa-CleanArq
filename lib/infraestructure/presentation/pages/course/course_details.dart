import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart'; // Asegúrate de importar el modelo Course y otros necesarios

class CourseDetailedScreen extends StatelessWidget {
  final Course course;

  const CourseDetailedScreen({Key? key, required this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Curso Detallado',
          style: TextStyle(color: Colors.white),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(course.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Entrenador: ${course.trainer.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Categoría: ${course.category}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    course.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  if (course.tags.isNotEmpty)
                    Text(
                      'Tags: ${course.tags.take(4).join(', ')}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  const SizedBox(height: 16.0),
                  Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level: ${course.level}',
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Semanas: ${course.durationWeeks}',
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Minutos: ${course.durationMinutes}',
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Lecciones:',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: course.lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = course.lessons[index];
                      return ListTile(
                        leading: lesson.image != null
                            ? Image.network(
                                lesson.image!,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                color: Colors.grey[300],
                              ),
                        title: Text(lesson.title),
                        subtitle: Text(lesson.content),
                        onTap: () {
                          print('Lección presionada: ${lesson.title}');
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
