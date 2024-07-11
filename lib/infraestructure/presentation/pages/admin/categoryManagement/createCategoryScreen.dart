import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:alpha_gymnastic_center/aplication/BLoC/category/post/category_post_blocs.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/post/category_post_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/category/post_new_Category_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_profile_progress_use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/category_interfaces.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../aplication/BLoC/category/post/category_post_event.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  //final _iconController = TextEditingController();
  Uint8List? _image;
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryPostBloc(
        postNewCategoryUseCase: GetIt.instance<PostNewCategoryUseCase>(),
      ),
      child: BlocListener<CategoryPostBloc, CategoryPostState>(
        listener: (context, state) {
          if (state is CategoryPostLoaded) {
            context.pop();
          } else if (state is CategoryPostFailed) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error!!"),
                  content: Text(
                      "Creacion de categoria Fallo. Error: ${state.failure.message}"),
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
        child: vista(context),
      ),
    );
  }

  Widget vista(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Create Category"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de nombre
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campo de ícono
              ElevatedButton(
                onPressed: () async {
                  await _pickImageFromGallery();
                },
                child: const Text('Subir Imagen'),
              ),
              const SizedBox(height: 80),
              // Botón de crear categoría
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    /*List<int> img = await returnImage.readAsBytes();*/
    setState(() {
      selectedImage = returnImage;
      //_image = Uint8List.fromList(img);
    });
  }

  Widget _buildRegisterButton() {
    return BlocBuilder<CategoryPostBloc, CategoryPostState>(
      builder: (context, state) {
        if (state is CategoryPostLoading) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                if (nameController.text.length < 3 ||
                    nameController.text.length > 30) {
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

              if (nameController.text.isNotEmpty || selectedImage != null) {
                BlocProvider.of<CategoryPostBloc>(context).add(LoadCategoryPost(
                    createCategoryRequest: CreateCategoryRequest(
                        name: nameController.text,
                        icon: selectedImage!)));
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
