import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/commons/COlors.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    // Llamar a la función para traer todos los usuarios
    // Aquí puedes agregar la lógica para traer los usuarios desde tu base de datos
    List<User> users = await _getAllUsers();
    setState(() {
      _users = users;
    });
  }

  Future<List<User>> _getAllUsers() async {
    // Simulación de datos
    List<User> users = [
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'Jonny Deep',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf'),
      User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+04125190405',
          type: UserRoles.admin,
          token: 'asdfghfds',
          imagenPerfil: 'nbvcfdfghjgf')
      //User(id: '2', name: 'Jane Doe', email: 'jane@example.com'),
      //User(id: '3', name: 'Bob Smith', email: 'bob@example.com'),
      //User(id: '4', name: 'John Lenon', email: 'john@example.com'),
      //User(id: '5', name: 'Paul Librery', email: 'paul@example.com'),
      //...
    ];
    return users;
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Users Management"),
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
                        labelText: 'Buscar usuario',
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
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        //Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //  builder: (context) =>
                        //     UpdateUserScreen(user: _users[index]),
                        // ),
                        // );
                      },
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryLightColor,
                        child: Text(
                          _users[index].name!.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                      title: Text(_users[index].name!),
                      subtitle: Text(_users[index].email!),
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
                  title: 'Crear Usuario',
                  onPressed: () {
                    // Navegar a la pantalla de crear usuario
                    Navigator.pushNamed(context, '/create-user');
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
