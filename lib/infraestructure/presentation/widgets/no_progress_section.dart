import 'package:flutter/material.dart';

class NoProgressSection extends StatelessWidget {
  const NoProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        color: Colors.white,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aún no has comenzado ningún curso.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: 10), // Añadí un espacio entre los dos textos
                      Text(
                        '¡Empieza hoy para ver tu progreso aquí!',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.school,
                  color: Colors.deepPurple,
                  size: 65,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
