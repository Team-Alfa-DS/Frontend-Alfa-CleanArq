import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:alpha_gymnastic_center/aplication/BLoC/progress/profile/profile_progress_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_profile_progress_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course_detailed.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carrusel_h.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses_h.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/common/utils/string_utils.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/my_training.dart';
//import '../../widgets/popular_courses.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileProgressBloc(
        getProfileProgressUseCase: GetIt.instance<GetProfileProgressUseCase>(),
      )..add(LoadProfileProgress()),
      child: BlocBuilder<ProfileProgressBloc, ProfileProgressState>(
        builder: (context, state) {
          if (state is ProfileProgressLoading) {
            return const CircularProgressIndicator();
          } else if (state is ProfileProgressLoaded) {
            return MiScaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    buildAppBar(context, state.percent, state.time),
                    const SizedBox(height: 10.0),
                    buildUserData(context),
                    const SizedBox(height: 10.0),
                    buildTrainningSection(),
                  ],
                ),
              ),
            );
          } else if (state is ProfileProgressError) {
            return Text('Error: ${state.message}');
          }
          return Container();
        },
      ),
    );
  }

  Widget buildAppBar(BuildContext context, double percent, int time) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String userName = 'Nombre de Usuario';
        String image = 'image';
        if (state is UserLoaded) {
          userName = getFirstTwoWords(state.user.name ?? 'Nombre de Usuario');
          image = (state.user.imagenPerfil == null)
              ? 'assets/images/userDefault.png'
              : state.user.imagenPerfil!;
          print(image);
          print('imagen locaa!!');
        }
        return Container(
          height: 220.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50.0),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      //const SizedBox(width: 20.0),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  //const SizedBox(width: 220.0),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      context.push('/editProfile');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: _imagenFinal(image),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          //const SizedBox(width: 50),
                          const IconButton(
                            icon: Icon(Icons.sentiment_satisfied_alt,
                                color: Colors.white, size: 20),
                            onPressed: null,
                          ),
                          const SizedBox(width: 130),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: ' $time ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'hrs',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                        width: 230,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          value: percent,
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }

  ImageProvider _imagenFinal(String img) {
    if (img == 'assets/images/userDefault.png') {
      return AssetImage(img);
    } else{
      return FileImage(_imageFromBase64String(img));
    }
      
  }

  String _normalizeBase64(String base64String) {
    int length = base64String.length;
    int remainder = length % 4;

    if (remainder != 0) {
      base64String += '=' * (4 - remainder);
    }

    return base64String;
  }

  File _imageFromBase64String(String base64String) {
    String normalizedBase64 = _normalizeBase64(base64String);

    print('BASE 64 LOCOCHON!!!');
    print(normalizedBase64);

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String decoded = stringToBase64.decode(normalizedBase64);

    // Quitar "File: " del principio
    decoded = decoded.replaceAll("File: ", "");
    // Quitar comillas simples (') del principio y del final
    decoded = decoded.replaceAll("'", "");

    print(decoded);

    final File img = File(decoded);

    print(img);

    return img;
  }

  Widget buildUserData(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      String userEmail = 'example@gmail.com';
      String userPhone = '04141234567';
      if (state is UserLoaded) {
        userEmail = state.user.email ?? 'example@gmail.com';
        userPhone = state.user.phone ?? '04141234567';
      }
      return Container(
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height / 5.5,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 237, 247),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Mis datos',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(Icons.email),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(Icons.phone_android),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userPhone,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildTrainningSection() {
    return const SizedBox(
      height: 230,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Text(
                  'My Trainning',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                //const SizedBox(width: 100),
                /*SizedBox(
                  height: 20,
                  width: 100,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all >',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: PopularCoursesCarousel() /*MyTrainingCarrousel()*/),
        ],
      ),
    );
  }

/*Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                ScrollHorizontal(
                  titulo: 'Tadasana Yaga',
                  descripcion: 'Yoga App',
                  categoria: 'Yoga',
                  fecha: '',
                  fotoString: 'assets/images/Yoga Ejemplo 1.png',
                  disposicion: 2,
                  isNew: true,
                  conexion: '',
                ),
                ScrollHorizontal(
                  titulo: 'Marvin McKinny',
                  descripcion: '',
                  categoria: 'Yoga',
                  fecha: '',
                  fotoString: 'assets/images/Yoga Ejemplo 2.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '',
                ),
                ScrollHorizontal(
                  titulo: 'Carlos Alonso',
                  descripcion: '',
                  categoria: 'Yoga',
                  fecha: '',
                  fotoString: 'assets/images/Yoga Ejemplo 4.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '/tipsTopics',
                ),
                ScrollHorizontal(
                  titulo: 'Ralph Tobirson',
                  descripcion: 'Yoga App',
                  categoria: 'Yoga',
                  fecha: '',
                  fotoString: 'assets/images/Yoga Ejemplo 6.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '/tipsTopics',
                ),
              ],
            ),
          ),*/
}
