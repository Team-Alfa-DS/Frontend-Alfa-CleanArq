import 'package:alpha_gymnastic_center/domain/entities/blog.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class UpdateBlogScreen extends StatefulWidget {
  final Blog blog;
  final List<Trainer> trainers;

  const UpdateBlogScreen(
      {super.key, required this.blog, required this.trainers});

  @override
  _UpdateBlogScreenState createState() => _UpdateBlogScreenState();
}

class _UpdateBlogScreenState extends State<UpdateBlogScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _content = '';
  Trainer? _trainer;

  @override
  void initState() {
    super.initState();
    _title = widget.blog.title;
    _content = widget.blog.description!;
    _trainer = widget.blog.trainer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Update Blog"),
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
                    initialValue: _content,
                    decoration: const InputDecoration(
                      labelText: 'Contenido',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un contenido';
                      }
                      return null;
                    },
                    onSaved: (value) => _content = value!,
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
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Actualizar blog en la base de datos
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
                            content:
                                const Text('¿Está seguro de eliminar el blog?'),
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
                                  // Eliminar blog en la base de datos
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
                    child: const Text('Eliminar blog'),
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
