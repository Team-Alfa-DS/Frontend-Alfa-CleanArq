import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

class ScreenDetail extends StatelessWidget {
  const ScreenDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Detalles de Notificación"),
      body: Container(
        color: const Color.fromARGB(
            255, 242, 242, 242), // Color de fondo de la pantalla
        child: Padding(
          padding: const EdgeInsets.all(
              20), // Agregué un padding para que no pegue de los bordes
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.all(30), // Espacio interno del contenedor
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(
                        255, 77, 6, 230)), // Borde del contenedor
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                color: const Color.fromARGB(
                    255, 217, 217, 255), // Color de fondo claro del contenedor
              ),
              child: Column(
                children: [
                  // Icono de notificación
                  const Icon(Icons.notifications,
                      size: 40, color: Color.fromARGB(255, 77, 6, 230)),
                  const SizedBox(height: 10),
                  // Título
                  const Text('Título de la notificación',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  // Separador
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  // Hora y Icono adicional
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hora: 12:54',
                        style: TextStyle(fontSize: 17),
                      ),
                      Icon(Icons.star, size: 20, color: Colors.yellow),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Mensaje
                  const Text(
                    'Este mensaje es para agradecerte por la subcripcion al curso de yoga para mejorar la salud',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                      height: 20), // Espacio adicional antes del botón
                  // Botón personalizado
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Volver'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 77, 6, 230),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
