import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_loadUserData(), _loadProfileData()]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle errors
          }

          final userData = snapshot.data![0] as UserData; // Access first result
          final profileData =
              snapshot.data![1] as ProfileData; // Access second result

          // Use userData and anotherData in your widget logic
          return MiScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  buildAppBar(context, userData, profileData),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Statitics',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                          width: 107,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Row(
                                // Combine Icon and Text in a Row
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'See All',
                                    style: TextStyle(
                                        fontSize: 13, color: Color(0xFF677294)),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 13,
                                    color: Color(0xFF677294),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      SizedBox(width: 23),
                      Text(
                        'This week',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF677294)),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 5), // Espacio reducido después del AppBar
                  buildStatisticsSection(),
                  const SizedBox(
                      height:
                          30), // Espacio reducido después de las estadísticas
                  SizedBox(
                    height: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0), // Aumenta el padding del título
                          child: Row(
                            children: [
                              const Text(
                                'My Trainning',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 150),
                              SizedBox(
                                height: 20,
                                width: 107,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Row(
                                      // Combine Icon and Text in a Row
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'See All',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF677294)),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 13,
                                          color: Color(0xFF677294),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              ScrollHorizontal(
                                titulo: 'Tadasana Yaga',
                                descripcion: 'Yoga App',
                                categoria: 'Yoga',
                                fecha: '',
                                foto: 'assets/images/Yoga Ejemplo 1.png',
                                disposicion: 2,
                                isNew: true,
                                conexion: '',
                              ),
                              ScrollHorizontal(
                                titulo: 'Marvin McKinny',
                                descripcion: '',
                                categoria: 'Yoga',
                                fecha: '',
                                foto: 'assets/images/Yoga Ejemplo 2.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '',
                              ),
                              ScrollHorizontal(
                                titulo: 'Carlos Alonso',
                                descripcion: '',
                                categoria: 'Yoga',
                                fecha: '',
                                foto: 'assets/images/Yoga Ejemplo 4.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '/tipsTopics',
                              ),
                              ScrollHorizontal(
                                titulo: 'Ralph Tobirson',
                                descripcion: 'Yoga App',
                                categoria: 'Yoga',
                                fecha: '',
                                foto: 'assets/images/Yoga Ejemplo 6.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '/tipsTopics',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 0.4), // Espacio reducido entre las secciones
                  SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0), // Aumenta el padding del título
                          child: Row(
                            children: [
                              const Text(
                                'My Yoga Photos',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 110),
                              SizedBox(
                                height: 20,
                                width: 107,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Row(
                                      // Combine Icon and Text in a Row
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'See All',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF677294)),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 13,
                                          color: Color(0xFF677294),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              ScrollHorizontal(
                                titulo: '',
                                descripcion: '',
                                categoria: '',
                                fecha: '',
                                foto: 'assets/images/yoga_video_1.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '',
                              ),
                              ScrollHorizontal(
                                titulo: '',
                                descripcion: '',
                                categoria: '',
                                fecha: '',
                                foto: 'assets/images/yoga_video_2.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '',
                              ),
                              ScrollHorizontal(
                                titulo: '',
                                descripcion: '',
                                categoria: '',
                                fecha: '',
                                foto: 'assets/images/yoga_video_3.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '',
                              ),
                              ScrollHorizontal(
                                titulo: '',
                                descripcion: '',
                                categoria: '',
                                fecha: '',
                                foto: 'assets/images/yoga_video_4.png',
                                disposicion: 2,
                                isNew: false,
                                conexion: '',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<UserData> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'Nombre de Usuario';
    int followers = prefs.getInt('followers') ??
        0; // Asegúrate de tener un valor por defecto
    int following = prefs.getInt('following') ??
        0; // Asegúrate de tener un valor por defecto
    return UserData(name: name, followers: followers, following: following);
  }

  Future<ProfileData> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    num percent = prefs.getInt('percent') ?? 0.5;
    int time = prefs.getInt('time') ?? 0;
    return ProfileData(percent: percent, time: time);
  }

  Widget buildAppBar(
      BuildContext context, UserData userData, ProfileData profileData) {
    return Container(
      height: 260.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0), // Agrega espacio aquí
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 20.0),
                const Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(width: 220.0),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.name,
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        SizedBox(
                          width: 100,
                          child: Text(
                            '${userData.followers}',
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${userData.following}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 0),
                        SizedBox(
                          width: 100,
                          child: Text(
                            'followers',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                        Text(
                          'followings',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 65),
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
                        text: ' ${profileData.time} ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' hrs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
              width: 250,
              child: LinearProgressIndicator(
                  value: profileData.percent.toDouble(), color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatisticsSection() {
    return SizedBox(
      width: 400,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromARGB(255, 233, 231, 231)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        'Time',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Text(
                        '1:03:30',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20.0), // Agrega espacio aquí
              SizedBox(
                height: 79.0,
                width: 210.0,
                child: BarChart(
                  BarChartData(
                    barGroups: getBarGroups(),
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Mon';
                            case 1:
                              return 'Tue';
                            case 2:
                              return 'Wed';
                            case 3:
                              return 'Thu';
                            case 4:
                              return 'Fri';
                            case 5:
                              return 'Sat';
                            case 6:
                              return 'Sun';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(enabled: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    List<int> weeklyData = [5, 25, 100, 75, 56, 45, 85];

    return List.generate(weeklyData.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            y: weeklyData[i].toDouble(),
            colors: [i % 2 == 0 ? Colors.purple : Colors.green],
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ],
      );
    });
  }

  // ...
}

class UserData {
  final String name;
  final int followers;
  final int following;

  UserData(
      {required this.name, required this.followers, required this.following});
}

class WeekdayData {
  final String day;
  final int sales;

  WeekdayData(this.day, this.sales);
}

class ProfileData {
  final num percent;
  final int time;

  ProfileData({required this.percent, required this.time});
}
