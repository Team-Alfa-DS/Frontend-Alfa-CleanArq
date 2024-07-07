import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/blogsManagement/blogManagement.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/categoryManagement/categoryManagement.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/commons/COlors.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/trainersManagement/trainerManagement.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/usersManagement/userManagement.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Dashboard Administrador"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leo Hernandez',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'HernandezL@gmail.com',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        '+58 424 131 2528',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Mensaje de bienvenida
            const Text(
              'Bienvenido(a) al panel de administración',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),

            // Botones de management
            GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 5,
              shrinkWrap: true,
              children: [
                _ManagementButton(
                  title: 'Users',
                  onPressed: () {
                    //Navigator.pushNamed(context, '/user-management');
                    // Navegar a la pantalla de usuarios
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserManagementScreen()),
                    );
                  },
                  backgroundColor: AppColors.primaryLightColor,
                ),
                _ManagementButton(
                  title: 'Courses',
                  onPressed: () {
                    // Navegar a la pantalla de cursos
                  },
                  backgroundColor: AppColors.primaryLightColor,
                ),
                _ManagementButton(
                  title: 'Blogs',
                  onPressed: () {
                    // Navegar a la pantalla de blogs
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BlogManagementScreen()),
                    );
                  },
                  backgroundColor: AppColors.primaryLightColor,
                ),
                _ManagementButton(
                  title: 'Categorys',
                  onPressed: () {
                    //Navigator.pushNamed(context, '/category-management');
                    // Navegar a la pantalla de categorías
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CategoryManagementScreen()),
                    );
                  },
                  backgroundColor: AppColors.primaryLightColor,
                ),
                _ManagementButton(
                  title: 'Trainers',
                  onPressed: () {
                    // Navegar a la pantalla de entrenadores
                    //Navigator.pushNamed(context, '/trainer-management');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TrainerManagementScreen()),
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
