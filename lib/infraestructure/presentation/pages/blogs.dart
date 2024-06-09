import 'package:flutter/material.dart';

class YogaBlogScreen extends StatelessWidget {
  const YogaBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Blogs'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          // Agregado SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Nuevo estilo de Yoga para este 2024',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/images/yoga_blog_1.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'El yoga ha sido una práctica milenaria que ha demostrado tener múltiples beneficios para la salud física y mental. Este 2024, expertos han desarrollado un nuevo estilo de yoga que promete ser una revolución en el mundo del bienestar.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/images/yoga_blog_2.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Este nuevo estilo de yoga combina elementos tradicionales con movimientos modernos, lo que lo hace accesible para personas de todas las edades y niveles de habilidad. Además, se ha demostrado que mejora la flexibilidad, la fuerza y el equilibrio, al tiempo que reduce el estrés y la ansiedad.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Si estás buscando una forma de mejorar tu salud y bienestar este año, te recomendamos que pruebes este nuevo estilo de yoga. No sólo te ayudará a mantenerte en forma, sino que también te proporcionará una sensación de paz y tranquilidad en tu día a día.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
