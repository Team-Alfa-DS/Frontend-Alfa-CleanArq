import 'package:flutter/material.dart';

/*
    RECUERDEN LLAMAR A ESTA CLASE DE LA SIGUIENTE MANERA:
                SizedBox(
                  height: 195,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ScrollHorizontal(
                        titulo: "titulo",
                        descripcion: "descripcion",
                        categoria: "categoria",
                        fecha: "Ene 1, 2024",
                        foto: "assets/images/imagen.png",
                        disposicion: 2,
                        isNew: false,
                        conexion: "/videos",
                      ),
                    ],
                  ),
                ),


    Disposicion 1: Foto grande y dentro de la foto esta el titulo y la descripcion
    Disposicion 2: Foto pequena y abajo esta el titulo, categoria y fecha
    Disposicion 3: Es simplemente La imagen con un icono de play 
*/

class ScrollHorizontal extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String categoria;
  final String fecha;
  final String foto;
  final int disposicion;
  final bool isNew;
  final String conexion;

  const ScrollHorizontal({super.key, 
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.fecha,
    required this.foto,
    required this.disposicion,
    this.isNew = false,
    required this.conexion,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, conexion);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        width: 200.0,
        height: disposicion == 2 ? 80.0 : null,
        decoration: BoxDecoration(
          color: disposicion == 2 ? Colors.white : null,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImage(),
            const SizedBox(height: 5.0),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: disposicion == 1 ? 150.0 : (disposicion == 3 ? 150.0 : 100.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(foto),
              fit: BoxFit.cover,
            ),
          ),
          child: disposicion == 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.7),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            descripcion,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : disposicion == 3
                  ? Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 50.0,
                        color: Colors.grey.withOpacity(0.9),
                      ),
                    )
                  : null,
        ),
        if (isNew) // Se muestra solo si isNew es true
          Positioned(
            top: 5.0,
            right: 5.0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    switch (disposicion) {
      case 1:
        return const SizedBox(); // No se necesita contenido adicional
      case 2:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      categoria,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    fecha,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      case 3:
        return const SizedBox(); // No se necesita contenido adicional
      default:
        return const SizedBox(); // En caso de que disposicion no sea 1, 2 o 3
    }
  }
}
