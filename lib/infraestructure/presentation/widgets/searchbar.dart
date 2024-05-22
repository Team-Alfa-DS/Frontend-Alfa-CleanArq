import 'package:flutter/material.dart';

class BarraBusqueda extends StatelessWidget {
  const BarraBusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.search),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
