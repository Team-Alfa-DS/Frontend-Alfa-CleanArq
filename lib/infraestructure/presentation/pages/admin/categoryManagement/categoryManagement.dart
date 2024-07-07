import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/categoryManagement/createCategoryScreen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/commons/COlors.dart';
//import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/trainersManagement/trainerManagement.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  _CategoryManagementScreenState createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  List<Category> _Categorys = [];

  @override
  void initState() {
    super.initState();
    _loadCategorys();
  }

  void _loadCategorys() async {
    // Llamar a la función para traer todos los usuarios
    // agregar la lógica para traer los usuarios desde tu base de datos
    List<Category> users = await _getAllCategorys();
    setState(() {
      _Categorys = users;
    });
  }

  Future<List<Category>> _getAllCategorys() async {
    // Simulación de datos
    List<Category> Categorys = [
      Category(
        icon: 'icono',
        id: '1',
        name: 'yoga',
      ),
      Category(
        icon: 'icono',
        id: '2',
        name: 'terapia',
      ),
      Category(
        icon: 'icono',
        id: '3',
        name: 'fitness',
      ),
      Category(
        icon: 'icono',
        id: '4',
        name: 'ciclismo',
      ),
      Category(
        icon: 'icono',
        id: '5',
        name: 'natacion',
      ),
    ];
    return Categorys;
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Categorys Management"),
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
                        labelText: 'Buscar categoria',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Lista de usuarios
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _Categorys.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        //Navigator.push(
                        //  context,
                        //  MaterialPageRoute(
                        //   builder: (context) => UpdateCategoryScreen(
                        //       category: _Categorys[index]),
                        //  ),
                        // );
                      },
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryLightColor,
                        child: Text(
                          _Categorys[index].name,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                      title: Text(_Categorys[index].name),
                      subtitle: Text(_Categorys[index].id),
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
                  title: 'Crear Categoria',
                  onPressed: () {
                    //Navigator.pushNamed(context, '/create-category');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateCategoryScreen()),
                    );
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
