import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class CreateTrainerScreen extends StatefulWidget {
  const CreateTrainerScreen({super.key});

  @override
  _CreateTrainerScreenState createState() => _CreateTrainerScreenState();
}

class _CreateTrainerScreenState extends State<CreateTrainerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _followersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Crear Entrenador"),
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
              // Botón de crear entrenador
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Crear entrenador
                    // ignore: unused_local_variable
                    Trainer trainer = Trainer(
                      name: _nameController.text,
                      location: _locationController.text,
                      followers: int.parse(_followersController.text),
                    );
                    //logica para crear entrenador
                    // await _createTrainer(trainer);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Crear Entrenador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
