import 'package:flutter/material.dart';

class ScrollH<T> extends StatelessWidget {
  final T item;
  final int disposicion;

  const ScrollH({
    required this.item,
    required this.disposicion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: disposicion == 4 ? 80.0 : 200.0,
      height: disposicion == 4 ? 120.0 : null,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (disposicion) {
      case 1:
        return _buildImageAndText();
      case 2:
        return _buildSmallImageWithTitle();
      case 3:
        return _buildImageWithPlayIcon();
      case 4:
        return _buildSmallIconWithTitle();
      default:
        return Container();
    }
  }

  Widget _buildImageAndText() {
    final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: _getImageProvider(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: Colors.grey.withOpacity(0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemMap['titulo'] ?? 'Titulo',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallImageWithTitle() {
    final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 100.0,
          child: Image(
            image: _getImageProvider(),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemMap['titulo'] ?? 'Titulo',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                 itemMap['categoria'] ?? 'Categoría',
                 style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 14.0,
                 )
              ),
              Text(
                  itemMap['fecha'] ?? 'Fecha',
                 style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                 )
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageWithPlayIcon() {
    return Center(
      child: Icon(
        Icons.play_circle_filled,
        size: 50.0,
        color: Colors.grey.withOpacity(0.9),
      ),
    );
  }

  Widget _buildSmallIconWithTitle() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          size: 40.0,
          color: Colors.yellow,
        ),
        SizedBox(height: 5.0),
        Text(
          'Favorito',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  ImageProvider _getImageProvider() {
    if (item != null && item is Map<String, dynamic>) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;

      final String? fotoString = itemMap['fotoString'] as String?;
      final String? fotoUrl = itemMap['fotoUrl'] as String?;



      if (fotoString != null) {
        return AssetImage(fotoString);
      } else if (fotoUrl != null && fotoUrl != '') {
        return NetworkImage(fotoUrl);
      } else if((fotoUrl == null && fotoString == null) || (fotoUrl == '' && fotoString == '')){
        return AssetImage('assets/images/placeholder_image.png');
      }
    }
    return const AssetImage('assets/images/placeholder_image.png');
  }
}
