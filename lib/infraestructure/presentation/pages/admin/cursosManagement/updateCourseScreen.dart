import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class UpdateCourseScreen extends StatefulWidget {
  final Course course;
  final List<Trainer> trainers;
  final List<Lesson> lessons;

  const UpdateCourseScreen({
    super.key,
    required this.course,
    required this.trainers,
    required this.lessons,
  });

  @override
  _UpdateCourseScreenState createState() => _UpdateCourseScreenState();
}

class _UpdateCourseScreenState extends State<UpdateCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  Trainer? _trainer;
  Lesson? _lesson;

  @override
  void initState() {
    super.initState();
    _title = widget.course.title;
    _description = widget.course.description;
    _trainer = widget.course.trainer;
    _lesson = widget.course.lessons as Lesson?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Update Course"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un título';
                      }
                      return null;
                    },
                    onSaved: (value) => _title = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una descripción';
                      }
                      return null;
                    },
                    onSaved: (value) => _description = value!,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _trainer,
                      onChanged: (Trainer? trainer) {
                        setState(() {
                          _trainer = trainer;
                        });
                      },
                      items: widget.trainers.map((trainer) {
                        return DropdownMenuItem(
                          value: trainer,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 226, 221, 221),
                                child: Icon(Icons.person, size: 25),
                              ),
                              SizedBox(width: 10),
                              Text(trainer.name),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _lesson,
                      onChanged: (Lesson? lesson) {
                        setState(() {
                          _lesson = lesson;
                        });
                      },
                      items: widget.lessons.map((lesson) {
                        return DropdownMenuItem(
                          value: lesson,
                          child: Text(lesson.title),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Actualizar curso en la base de datos
                        //...
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // Color del texto
                    ),
                    child: const Text('Guardar cambios'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content: const Text(
                                '¿Está seguro de eliminar el curso?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Eliminar'),
                                onPressed: () {
                                  // Eliminar curso en la base de datos
                                  //...
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // Color del texto
                    ),
                    child: const Text('Eliminar curso'),
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
