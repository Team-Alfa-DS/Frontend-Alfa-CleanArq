import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:alpha_gymnastic_center/aplication/BLoC/user/update_user/bloc/update_user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/update_user_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

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
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserBloc(
        updateUseCase: GetIt.instance<UpdateUserUseCase>(),
      ),
      child: BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            /*if(state1){

          }
          else if(state2){

          }*/
            // TODO: implement listener
          },
          child: Scaffold(
            appBar: const YogaAppBar(title: "Editar Perfil"),
            body: SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              //*Imagen actualizada
                              radius: 80.0,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor: Colors.transparent,
                            )
                          : const CircleAvatar(
                              //*Imagen Vieja
                              radius: 80.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                              backgroundColor: Colors.transparent,
                            ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xFF4F14A0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showImagePickerOption(context);
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
                  _buildInputField(
                    passwordController,
                    'contraseña',
                  ),
                  const SizedBox(height: 5),
                  _buildGreyText("Repita la contraseña"),
                  _buildInputField(passwordController, 'contraseña',
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
                      onTap: () {
                        _pickImageFromGallery();
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
                            Text('Galeria'),
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
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

//*Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
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
              if (nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                if (nameController.text.length >= 3 &&
                    nameController.text.length <= 30) {
                  if (RegExp(r'^[0-9]+$').hasMatch(phoneController.text) &&
                      phoneController.text.length == 11) {
                    if (EmailValidator.validate(emailController.text)) {
                      BlocProvider.of<UpdateUserBloc>(context).add(
                        UpdateUserSubmitted(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text,
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("¡Attention!"),
                            content: const Text("You must put a email"),
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
                          title: const Text("¡Attention!"),
                          content:
                              const Text("Please write a phone number valid"),
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
                        title: const Text("¡Attention!"),
                        content: const Text(
                            "The name must be between 3 and 30 caracters"),
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
                      title: const Text("¡Attention!"),
                      content: const Text("Please complete all the fields"),
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

/*class FormGeneral extends StatelessWidget {
  //final ValueChanged<String> onValue;

  const FormGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();
    const outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      //borderRadius: BorderRadius.circular(40),
    );

    const inputDecoration = InputDecoration(
        hintText: 'End your message with a "?"',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.white
        /*suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = textController.value.text;
          textController.clear();
          onValue(textValue);
        },
      ),*/
        );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('Hola'),
          TextFormField(
            onTapOutside: (event) {
              focusNode.unfocus();
            },
            focusNode: focusNode,
            controller: textController,
            decoration: inputDecoration,
            onFieldSubmitted: (value) {
              textController.clear();
              focusNode.requestFocus();
              //onValue(value);
            },
          ),
        ],
      ),
    );
  }
}*/

Widget _buildInputField(TextEditingController controller, String tipo,
    {bool isPassword = false}) {
  final focusNode = FocusNode();
  const outlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    //borderRadius: BorderRadius.circular(40),
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

/*Widget _buildInputField(TextEditingController controller,
    {bool isPassword = false}) {
  return TextField(
    controller: controller,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      iconColor: Colors.black,
      suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : null,
    ),
    obscureText: isPassword,
  );
}*/



