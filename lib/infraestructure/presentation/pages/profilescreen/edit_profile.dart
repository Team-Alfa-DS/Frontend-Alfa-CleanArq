import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/get_current_user_use_case.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../aplication/BLoC/user/update_user/update_user_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  Uint8List? _image;
  File? selectedImage;
  String? imagen = 'image';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserBloc(
          updateUseCase: GetIt.instance<UpdateUserUseCase>(),
          getCurrentUserUseCase: GetIt.instance<GetCurrentUserUseCase>(),
          userBloc: BlocProvider.of<UserBloc>(context)),
      child: BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              context.pop();
            } else if (state is UpdateUserFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Error!!"),
                    content: Text(
                        "Actualizacion de usuario fallo. Error: ${state.failure.message}"),
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
          child: Scaffold(
            appBar: const YogaAppBar(title: "Editar Perfil"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      _buildAvatar(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xFF4F14A0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showImagePickerOption(context);
                            //mostrarCuadroTutorial();
                          },
                          icon: const Icon(Icons.flip_camera_ios_rounded),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildGreyText("Nombre Completo"),
                  _buildInputField(nameController, 'nombre completo'),
                  const SizedBox(height: 5),
                  _buildGreyText("Email"),
                  _buildInputField(emailController, 'correo'),
                  const SizedBox(height: 5),
                  _buildGreyText("Numero de Telefono"),
                  _buildInputField(phoneController, 'numero de telefono'),
                  const SizedBox(height: 5),
                  _buildGreyText("Nueva contraseña"),
                  _buildInputField(passwordController, 'contraseña',
                      isPassword: true),
                  const SizedBox(height: 5),
                  _buildGreyText("Repita la contraseña"),
                  _buildInputField(passwordCheckController, 'contraseña',
                      isPassword: true),
                  const SizedBox(height: 10),
                  _buildRegisterButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildAvatar() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoaded) {
        imagen = (state.user.imagenPerfil == null)
            ? 'assets/images/userDefault.png'
            : state.user.imagenPerfil;
      }
      return _circleAvatar();
    });
  }

  Widget _circleAvatar() {
    return _image != null
        ? CircleAvatar(
            //*Imagen actualizada
            radius: 80.0,
            backgroundImage: MemoryImage(_image!),
            backgroundColor: Colors.transparent,
          )
        : CircleAvatar(
            //*Imagen Vieja
            radius: 80.0,
            backgroundImage: _imagenFinal(imagen!),
            backgroundColor: Colors.transparent,
          );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.image, size: 70),
                            Text('Galeria'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.camera_enhance, size: 70),
                            Text('Camara'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

//*Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    List<int> img = await returnImage.readAsBytes();
    setState(() {
      selectedImage = File(returnImage.path);
      _image = Uint8List.fromList(img);
    });
    Navigator.of(context).pop();
  }

//*Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) return;
    List<int> img = await returnImage.readAsBytes();
    setState(() {
      selectedImage = File(returnImage.path);
      _image = Uint8List.fromList(img);
    });
    Navigator.of(context).pop();
  }

  ImageProvider _imagenFinal(String img) {
    if (img == 'assets/images/userDefault.png') {
      return AssetImage(img);
    } else {
      return MemoryImage(base64Decode(img));
    }
  }

//*Boton para registrar
  Widget _buildRegisterButton() {
    return BlocBuilder<UpdateUserBloc, UpdateUserState>(
      builder: (context, state) {
        if (state is UpdateUserLoading) {
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
              if (phoneController.text.isNotEmpty) {
                if (!RegExp(r'^[0-9]+$').hasMatch(phoneController.text) ||
                    phoneController.text.length != 11) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("¡Atención!"),
                        content: const Text(
                            "Por favor, escribe un numero de telefono valido"),
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
              if (emailController.text.isNotEmpty) {
                if (!EmailValidator.validate(emailController.text)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("¡Atención!"),
                        content: const Text("Debes colocar un correo!"),
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
              if (passwordController.text.isNotEmpty) {
                if (passwordCheckController.text.isNotEmpty) {
                  if (passwordController.text != passwordCheckController.text) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("¡Attention!"),
                          content: const Text(
                              "Las contraseñas deben ser iguales, intente nuevamente"),
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
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("¡Atención!"),
                        content: const Text("Confirma la nueva contraseña!!"),
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
              final name =
                  (nameController.text.isEmpty) ? 'None' : nameController.text;
              final phone = (phoneController.text.isEmpty)
                  ? 'None'
                  : phoneController.text;
              final email = (emailController.text.isEmpty)
                  ? 'None'
                  : emailController.text;
              final password = (passwordController.text.isEmpty)
                  ? 'None'
                  : passwordController.text;
              final image = (_image == null) ? 'None' : base64Encode(_image!);

              if (nameController.text.isNotEmpty ||
                  phoneController.text.isNotEmpty ||
                  emailController.text.isNotEmpty ||
                  passwordController.text.isNotEmpty ||
                  _image != null) {
                BlocProvider.of<UpdateUserBloc>(context).add(
                    UpdateUserSubmitted(
                        name: name,
                        email: email,
                        password: password,
                        phone: phone,
                        image: image));
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("¡Atención!"),
                      content: const Text("Llene el campo que desee modificar"),
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

Widget _buildInputField(TextEditingController controller, String tipo,
    {bool isPassword = false}) {
  final focusNode = FocusNode();
  const outlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );

  final inputDecoration = InputDecoration(
    hintText: 'Ingrese su $tipo',
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    filled: true,
    fillColor: Colors.transparent,
    iconColor: Colors.black,
    suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : null,
  );
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        TextFormField(
          onTapOutside: (event) {
            focusNode.unfocus();
          },
          focusNode: focusNode,
          controller: controller,
          decoration: inputDecoration,
          obscureText: isPassword,
          onFieldSubmitted: (value) {
            controller.clear();
            focusNode.requestFocus();
            //onValue(value);
          },
        ),
      ],
    ),
  );
}

Widget _buildGreyText(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.blueGrey),
    textAlign: TextAlign.start,
  );
}
