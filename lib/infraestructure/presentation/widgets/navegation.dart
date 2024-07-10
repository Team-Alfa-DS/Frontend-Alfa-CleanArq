import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BarraNavegacion extends StatelessWidget {
  const BarraNavegacion({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // Alineación espaciada uniformemente
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/icons/hogar.png'),
              onPressed: () {
                //si estoy en /home y presiono el icono de la casa, no hace nada
                if (ModalRoute.of(context)!.settings.name != '/home') {
                  context.push('/home');
                }
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/silla.png'),
              onPressed: () {
                //si estoy en /course y presiono el icono de la silla, no hace nada
                if (ModalRoute.of(context)!.settings.name !=
                    '/trainingScreen') {
                  context.push('/trainingScreen');
                }
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/ajustes.png'),
              onPressed: () {
                //si estoy en /settings y presiono el icono de ajustes, no hace nada
                if (ModalRoute.of(context)!.settings.name != '/settings') {
                  context.push('/settings');
                }
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/campana.png'),
              onPressed: () {
                //si estoy en /notification y presiono la campana, no hace nada
                if (ModalRoute.of(context)!.settings.name != '/notification') {
                  context.push('/notification');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MiScaffold extends StatelessWidget {
  final Widget body;
  const MiScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: const BarraNavegacion(),
    );
  }
}
