import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses_v.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/popular_courses_h.dart';

class TrainingView extends StatelessWidget {
  const TrainingView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Entrenamiento', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cursos más Populares',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: const PopularProcessesCarousel(),
              ),
              const SizedBox(height: 20),
              Container(
                height: 1,
                color: Colors.grey[300],
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              const Text(
                'Programador Maestro',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const PopularProcessesVerticalScroll(),
            ],
          ),
        ),
      ),
    );
  }
}
