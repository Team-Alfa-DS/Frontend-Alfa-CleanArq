import 'package:alpha_gymnastic_center/aplication/BLoC/progress/profile/profile_progress_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_profile_progress_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course_detailed.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carruselh.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/common/utils/string_utils.dart';
import 'package:go_router/go_router.dart';

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
                    buildTrainningSection(),
                    const SizedBox(height: 10),
                    buildYogaPhotosSection(),
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
        if (state is UserLoaded) {
          userName = getFirstTwoWords(state.user.name ?? 'Nombre de Usuario');
        }

        return Container(
          height: 260.0,
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
            child: Column(
              children: [
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
                //const SizedBox(height: 10.0),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/user.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    //const SizedBox(width: 10.0),
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
                        /*const Row(
                          children: [
                            SizedBox(width: 30),
                            SizedBox(
                              width: 100,
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),*/
                        /*const Row(
                          children: [
                            SizedBox(width: 0),
                            SizedBox(
                              width: 100,
                              child: Text(
                                'followers',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                            Text(
                              'followings',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    const IconButton(
                      icon: Icon(Icons.sentiment_satisfied_alt,
                          color: Colors.white, size: 20),
                      onPressed: null,
                    ),
                    const SizedBox(width: 175),
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
                  width: 250,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    value: percent,
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
          Expanded(child: PopularProcessesCarousel()),
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

  Widget buildYogaPhotosSection() {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                const Text(
                  'My Yoga Photos',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 70),
                SizedBox(
                  height: 20,
                  width: 107,
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                ScrollHorizontal(
                  titulo: '',
                  descripcion: '',
                  categoria: '',
                  fecha: '',
                  fotoString: 'assets/images/yoga_video_1.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '',
                ),
                ScrollHorizontal(
                  titulo: '',
                  descripcion: '',
                  categoria: '',
                  fecha: '',
                  fotoString: 'assets/images/yoga_video_2.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '',
                ),
                ScrollHorizontal(
                  titulo: '',
                  descripcion: '',
                  categoria: '',
                  fecha: '',
                  fotoString: 'assets/images/yoga_video_3.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '',
                ),
                ScrollHorizontal(
                  titulo: '',
                  descripcion: '',
                  categoria: '',
                  fecha: '',
                  fotoString: 'assets/images/yoga_video_4.png',
                  disposicion: 2,
                  isNew: false,
                  conexion: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
