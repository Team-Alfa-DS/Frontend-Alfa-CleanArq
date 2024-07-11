import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ScreenDetail extends StatelessWidget {
  final Notifications? notification;
  final RemoteMessage? message;

  ScreenDetail({super.key, this.notification, this.message});

  get as => null;

  @override
  Widget build(BuildContext context) {

    if(notification == null){
        notification?.title = message?.notification?.title as String;
        notification?.body = message?.notification?.body as String;
        notification?.date = (message?.sentTime ?? DateTime.now());
    }

    String? formattedDate = notification?.date.toString();
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
                  Text(notification!.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  // Separador
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  // Hora y Icono adicional
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedDate!,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const Icon(Icons.star, size: 20, color: Colors.yellow),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Mensaje
                  Text(
                    notification!.body,
                    style: const TextStyle(fontSize: 17),
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
