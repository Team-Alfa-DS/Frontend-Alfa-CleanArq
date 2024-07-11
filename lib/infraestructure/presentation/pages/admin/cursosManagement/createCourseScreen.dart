import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class CreateCourseScreen extends StatefulWidget {
  final List<Trainer> trainers; // lista de entrenadores disponibles
  final List<Lesson> lessons; // lista de lecciones disponibles

  const CreateCourseScreen(
      {super.key, required this.trainers, required this.lessons});

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  final _levelController = TextEditingController();
  final _durationWeeksController = TextEditingController();
  final _durationMinutesController = TextEditingController();
  final _tagController = TextEditingController();

  Trainer? _selectedTrainer; // entrenador seleccionado
  List<Lesson> _selectedLessons = []; // lecciones seleccionadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Create Course"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Campo de título
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de descripción
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de categoría
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese una categoría';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de imagen
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    labelText: 'Imagen',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese una imagen';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de nivel
                TextFormField(
                  controller: _levelController,
                  decoration: const InputDecoration(
                    labelText: 'Nivel',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un nivel';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de duración en semanas
                TextFormField(
                  controller: _durationWeeksController,
                  decoration: const InputDecoration(
                    labelText: 'Duración en semanas',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese una duración en semanas';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de duración en minutos
                TextFormField(
                  controller: _durationMinutesController,
                  decoration: const InputDecoration(
                    labelText: 'Duración en minutos',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese una duración en minutos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de tags
                TextFormField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tags',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese al menos un tag';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de entrenador
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Trainer:',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectedTrainer,
                          onChanged: (Trainer? trainer) {
                            setState(() {
                              _selectedTrainer = trainer;
                            });
                          },
                          items: widget.trainers.map((trainer) {
                            return DropdownMenuItem(
                              value: trainer,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: Icon(Icons.person, size: 25),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    trainer.name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de lecciones
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Lecciones:',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectedLessons.isEmpty
                              ? null
                              : _selectedLessons.first,
                          onChanged: (Lesson? lesson) {
                            setState(() {
                              if (lesson != null) {
                                _selectedLessons.add(lesson);
                              }
                            });
                          },
                          items: widget.lessons.map((lesson) {
                            return DropdownMenuItem(
                              value: lesson,
                              child: Text(
                                lesson.title,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                // Botón de crear curso
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Crear curso con la información ingresada
                      //...
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckboxGroup extends StatefulWidget {
  final List<String> labels;
  final Function(List<String>) onChecked;

  CheckboxGroup({required this.labels, required this.onChecked});

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  List<bool> _checkedValues = [];

  @override
  void initState() {
    super.initState();
    _checkedValues = List<bool>.filled(widget.labels.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.labels.length; i++)
          CheckboxListTile(
            title: Text(widget.labels[i]),
            value: _checkedValues[i],
            onChanged: (value) {
              setState(() {
                _checkedValues[i] = value ?? false;
              });
              List<String> selectedLabels = [];
              for (int j = 0; j < _checkedValues.length; j++) {
                if (_checkedValues[j]) {
                  selectedLabels.add(widget.labels[j]);
                }
              }
              widget.onChecked(selectedLabels);
            },
          ),
      ],
    );
  }
}
