import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class UpdateTrainerScreen extends StatefulWidget {
  final Trainer trainer;

  const UpdateTrainerScreen({super.key, required this.trainer});

  @override
  _UpdateTrainerScreenState createState() => _UpdateTrainerScreenState();
}

class _UpdateTrainerScreenState extends State<UpdateTrainerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _followersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.trainer.name;
    _locationController.text = widget.trainer.location!;
    _followersController.text = widget.trainer.followers.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Actualizar Entrenador"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campo de ubicación
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Ubicación',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese una ubicación';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campo de seguidores
              TextFormField(
                controller: _followersController,
                decoration: const InputDecoration(
                  labelText: 'Seguidores',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un número de seguidores';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Botón de guardar cambios
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Actualizar entrenador
                    // ignore: unused_local_variable
                    Trainer updatedTrainer = Trainer(
                      id: widget.trainer.id,
                      name: _nameController.text,
                      location: _locationController.text,
                      followers: int.parse(_followersController.text),
                    );
                    //agregar la lógica para actualizar el entrenador en tu base de datos
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Color del texto
                ),
                child: const Text('Guardar Cambios'),
              ),
              const SizedBox(height: 10),
              // Botón de eliminar entrenador
              ElevatedButton(
                onPressed: () async {
                  // Mostrar diálogo de confirmación
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Eliminar Entrenador'),
                      content: const Text(
                          '¿Seguro que deseas eliminar este entrenador?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Eliminar entrenador
                            Navigator.pop(context);
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('Eliminar Entrenador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
