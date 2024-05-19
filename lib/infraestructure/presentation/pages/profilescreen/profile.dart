import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/scrollHorizontal.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadUserData(),
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return MiScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  buildAppBar(context, snapshot.data!),
                  const SizedBox(
                      height: 5.0), // Espacio reducido después del AppBar
                  buildStatisticsSection(),
                  const SizedBox(
                      height:
                          0.4), // Espacio reducido después de las estadísticas
                  SizedBox(
                    height: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 20.0), // Aumenta el padding del título
                          child: Text(
                            'Mi Entrenamiento',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                                isNew: false,
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
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 20.0), // Aumenta el padding del título
                          child: Text(
                            'Mis Fotos',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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

  Widget buildAppBar(BuildContext context, UserData userData) {
    return Container(
      height: 250.0,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.name,
                      style:
                          const TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                    Text(
                      'Seguidores: ${userData.followers}    Seguidos: ${userData.following}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const SizedBox(
              height: 10.0,
              child: LinearProgressIndicator(value: 0.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatisticsSection() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Lun';
                        case 1:
                          return 'Mar';
                        case 2:
                          return 'Mie';
                        case 3:
                          return 'Jue';
                        case 4:
                          return 'Vie';
                        case 5:
                          return 'Sab';
                        case 6:
                          return 'Dom';
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
          const SizedBox(width: 20.0), // Agrega espacio aquí
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Tiempo:\n1:03:30',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
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
