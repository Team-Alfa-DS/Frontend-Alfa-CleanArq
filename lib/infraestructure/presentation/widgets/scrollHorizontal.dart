import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
    RECUERDEN LLAMAR A ESTA CLASE DE LA SIGUIENTE MANERA:
    Disposicion 1: Foto grande y dentro de la foto esta el titulo y la descripcion
    Disposicion 2: Foto pequena y abajo esta el titulo, categoria y fecha
    Disposicion 3: Es simplemente La imagen con un icono de play
    Disposicion 4: Icono pequeno y su titulo abajo (en esta disposicion usen el sizedbox height: 85)
*/

class ScrollHorizontal extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String categoria;
  final String fecha;
  final int disposicion;
  final bool isNew;
  final String conexion;
  final String? fotoString;
  final ImageProvider? fotoProvider;

  const ScrollHorizontal({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.fecha,
    this.fotoString,
    this.fotoProvider,
    required this.disposicion,
    required this.isNew,
    required this.conexion,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(conexion);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: disposicion == 4 ? 5.0 : 10.0),
        width: disposicion == 4 ? 80.0 : 200.0,
        height: disposicion == 4 ? 120.0 : (disposicion == 2 ? 80.0 : null),
        decoration: BoxDecoration(
          color: disposicion == 4
              ? const Color.fromARGB(255, 212, 212, 212)
              : (disposicion == 2 ? Colors.white : null),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildImage(),
              const SizedBox(height: 5.0),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (disposicion == 1 || disposicion == 3) {
      return Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: disposicion == 1 ? 150.0 : 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: fotoString != null
                    ? AssetImage(fotoString!)
                    : fotoProvider!,
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
          if (isNew)
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
    } else if (disposicion == 4) {
      return Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: fotoString != null ? AssetImage(fotoString!) : fotoProvider!,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      // Disposiciones restantes
      return Container(
        width: double.infinity,
        height: disposicion == 1 ? 150.0 : 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: fotoString != null ? AssetImage(fotoString!) : fotoProvider!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget _buildContent() {
    switch (disposicion) {
      case 1:
        return const SizedBox();
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
        return const SizedBox();
      case 4:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      default:
        return const SizedBox(); // En caso de que disposicion no sea 1, 2, 3 o 4
    }
  }
}
