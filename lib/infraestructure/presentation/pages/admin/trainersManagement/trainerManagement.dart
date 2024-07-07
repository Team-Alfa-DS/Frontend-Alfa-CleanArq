import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/commons/COlors.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class TrainerManagementScreen extends StatefulWidget {
  const TrainerManagementScreen({super.key});

  @override
  _TrainerManagementScreenState createState() =>
      _TrainerManagementScreenState();
}

class _TrainerManagementScreenState extends State<TrainerManagementScreen> {
  List<Trainer> _Trainers = [];

  @override
  void initState() {
    super.initState();
    _loadTrainers();
  }

  void _loadTrainers() async {
    // Llamar a la función para traer todos los entrenadores
    // Aquí puedes agregar la lógica para traer los entrenadores desde tu base de datos
    List<Trainer> trainers = await _getAllTrainers();
    setState(() {
      _Trainers = trainers;
    });
  }

  Future<List<Trainer>> _getAllTrainers() async {
    // Simulación de datos
    List<Trainer> trainers = [
      Trainer(
        id: '1',
        name: 'Mailo Mendez',
        followers: 100,
        userFollow: true,
        location: 'New York',
      ),
      Trainer(
        id: '2',
        name: 'Juan Perez',
        followers: 50,
        userFollow: false,
        location: 'Los Angeles',
      ),
      Trainer(
        id: '3',
        name: 'Miguel Molina',
        followers: 50,
        userFollow: false,
        location: 'Caracas',
      ),
      Trainer(
        id: '4',
        name: 'Jane Moreno',
        followers: 50,
        userFollow: false,
        location: 'Amsterdan',
      ),
      Trainer(
        id: '5',
        name: 'Ricardo Sanchez',
        followers: 50,
        userFollow: false,
        location: 'Los Angeles',
      ),
    ];
    return trainers;
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Trainers Management"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Barra de búsqueda
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Buscar entrenador',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Lista de entrenadores
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _Trainers.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        //Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //  builder: (context) =>
                        //      UpdateTrainerScreen(trainer: _Trainers[index]),
                        //  ),
                        // );
                      },
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryLightColor,
                        child: Text(
                          _Trainers[index].name.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                      title: Text(_Trainers[index].name),
                      subtitle: Text(_Trainers[index].location ?? ''),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  );
                },
              ),
            ),
            // Botones de crear y eliminar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ManagementButton(
                  title: 'Crear Entrenador',
                  onPressed: () {
                    // Navegar a la pantalla de crear entrenador
                    //Navigator.pushNamed(context, '/create-trainer');
                  },
                  backgroundColor: AppColors.primaryLightColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagementButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const _ManagementButton(
      {required this.title,
      required this.onPressed,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
