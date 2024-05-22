import 'package:flutter/material.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/icons/hogar.png'),
              onPressed: () {
                //si estoy en /home y presiono el icono de la casa, no hace nada
                if (ModalRoute.of(context)!.settings.name != '/home') {
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/silla.png'),
              onPressed: () {
                //si estoy en /course y presiono el icono de la silla, no hace nada
                if (ModalRoute.of(context)!.settings.name !=
                    '/trainingScreen') {
                  Navigator.pushNamed(context, '/trainingScreen');
                }
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: Image.asset('assets/icons/ajustes.png'),
              onPressed: () {
                //si estoy en /settings y presiono el icono de ajustes, no hace nada
                if (ModalRoute.of(context)!.settings.name != '/settings') {
                  Navigator.pushNamed(context, '/settings');
                }
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/campana.png'),
              onPressed: () {
                //si estoy en /notification y presiono la campana, no hace nada
                if (ModalRoute.of(context)!.settings.name != '/notification') {
                  Navigator.pushNamed(context, '/notification');
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Image.asset('assets/icons/rayo.png',
              color: Colors.white, width: 35.0, height: 35.0),
        ),
      ),
      bottomNavigationBar: const BarraNavegacion(),
    );
  }
}
