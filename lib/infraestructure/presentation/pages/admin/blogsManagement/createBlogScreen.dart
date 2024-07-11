import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class CreateBlogScreen extends StatefulWidget {
  final List<Trainer> trainers; // lista de entrenadores disponibles

  const CreateBlogScreen({super.key, required this.trainers});

  @override
  _CreateBlogScreenState createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  final _tagController = TextEditingController();

  Trainer? _selectedTrainer; // entrenador seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Create Blog"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
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
              // Botón de crear blog
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Crear blog con la información ingresada
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
    );
  }
}
