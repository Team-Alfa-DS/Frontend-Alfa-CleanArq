import 'package:alpha_gymnastic_center/aplication/BLoC/trainer/trainer_post_blocs.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/trainer/trainer_post_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/trainer/trainer_post_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/trainer/post_new_trainer_use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/trainer_interfaces.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CreateTrainerScreen extends StatefulWidget {
  const CreateTrainerScreen({super.key});

  @override
  _CreateTrainerScreenState createState() => _CreateTrainerScreenState();
}

class _CreateTrainerScreenState extends State<CreateTrainerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  //final _followersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainerPostBloc(
        postNewTrainerUseCase: GetIt.instance<PostNewTrainerUseCase>(),
      ),
      child: BlocListener<TrainerPostBloc, TrainerPostState>(
        listener: (context, state) {
          if (state is TrainerPostLoaded) {
            context.pop();
          } else if (state is TrainerPostFailed) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error!!"),
                  content: Text(
                      "Creacion de Trainer Fallo. Error: ${state.failure.message}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: CrearTrainerVista(context),
      ),
    );
  }

  Widget CrearTrainerVista(BuildContext context) {
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
                  labelText: 'Name',
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
                  labelText: 'Location',
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
              const SizedBox(height: 20),
              // Botón de crear entrenador
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return BlocBuilder<TrainerPostBloc, TrainerPostState>(
      builder: (context, state) {
        if (state is TrainerPostLoading) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                if (_nameController.text.length < 3 ||
                    _nameController.text.length > 30) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("¡Atención!"),
                        content: const Text(
                            "El nombre debe ser mayor a 3 caracteres o menor a 30!!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              }

              if (_locationController.text.isNotEmpty) {
                if (_locationController.text.length < 3 ||
                    _locationController.text.length > 30) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("¡Atención!"),
                        content: const Text(
                            "El location debe ser mayor a 3 caracteres o menor a 30!!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              }

              if (_nameController.text.isNotEmpty ||
                  _locationController.text.isNotEmpty) {
                BlocProvider.of<TrainerPostBloc>(context).add(LoadTrainerPost(
                    crearTrainerRequest: CrearTrainerRequest(
                        name: _nameController.text,
                        location: _locationController.text)));
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("¡Atención!"),
                      content: const Text("Llene el campo que desea Crear"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              elevation: 20,
              backgroundColor: const Color(0xFF4F14A0),
              minimumSize: const Size.fromHeight(50),
              //maximumSize: const Size.fromWidth(20)
            ),
            child: const Text(
              "Guardar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
