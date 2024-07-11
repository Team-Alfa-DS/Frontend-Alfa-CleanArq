import 'package:alpha_gymnastic_center/domain/entities/blog.dart';
//import 'package:alpha_gymnastic_center/domain/entities/tag.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/blogsManagement/createBlogScreen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/blogsManagement/updateBlogScreen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/commons/COlors.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class BlogManagementScreen extends StatefulWidget {
  const BlogManagementScreen({super.key});

  @override
  _BlogManagementScreenState createState() => _BlogManagementScreenState();
}

class _BlogManagementScreenState extends State<BlogManagementScreen> {
  List<Blog> _blogs = [];
  List<Trainer> _trainers = [
    Trainer(id: '1', name: 'Juan'),
    Trainer(id: '2', name: 'Elisa'),
    Trainer(id: '3', name: 'Diana'),
    Trainer(id: '3', name: 'Mario'),
  ]; // lista de trainers existentes
// lista de tags existentes

  @override
  void initState() {
    super.initState();
    _loadBlogs();
  }

  void _loadBlogs() async {
    // Llamar a la función para traer todos los blogs
    // Aquí puedes agregar la lógica para traer los blogs desde tu base de datos
    List<Blog> blogs = await _getAllBlogs();
    setState(() {
      _blogs = blogs;
    });
  }

  Future<List<Blog>> _getAllBlogs() async {
    // Simulación de datos
    List<Blog> blogs = [
      Blog(
        id: '1',
        title: 'Blog 1',
        description: 'Descripción del blog 1',
        category: 'Categoria 1',
        image: 'imagen1.jpg',
        trainer: _trainers[0],
        date: DateTime.now(),
        tags: ['relax', 'yoga'],
      ),
      Blog(
        id: '2',
        title: 'Blog 2',
        description: 'Descripción del blog 2',
        category: 'Categoria 2',
        image: 'imagen2.jpg',
        trainer: _trainers[1],
        date: DateTime.now(),
        tags: ['meditacion'],
      ),
      //...
    ];
    return blogs;
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Blog Management"),
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
                        labelText: 'Buscar blog',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Lista de blogs
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _blogs.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateBlogScreen(
                              blog: _blogs[index],
                              trainers: _trainers,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryLightColor,
                        child: Text(
                          _blogs[index].title.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                      title: Text(_blogs[index].title),
                      subtitle: Text(_blogs[index].category),
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
                  title: 'Crear Blog',
                  onPressed: () {
                    // Navegar a la pantalla de crear blog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateBlogScreen(
                                trainers: _trainers,
                              )),
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
