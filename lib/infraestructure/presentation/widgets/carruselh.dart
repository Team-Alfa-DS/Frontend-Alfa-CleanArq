import 'package:flutter/material.dart';

class ScrollH<T> extends StatelessWidget {
  final T item;
  final int disposicion;
  final Function(T item) onTap;

  const ScrollH({
    Key? key,
    required this.item,
    required this.disposicion,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        width: disposicion == 4 ? 80.0 : 200.0,
        height: disposicion == 4 ? 120.0 : null,
        decoration: BoxDecoration(
          color: disposicion == 4
              ? const Color.fromARGB(255, 212, 212, 212)
              : (disposicion == 2 ? Colors.white : null),
          borderRadius: BorderRadius.circular(10.0),
        ),
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
        return Container(); // Puedes definir un comportamiento por defecto aquí
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
          child: Column(
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
                      itemMap['titulo'] ?? 'Titulo',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      itemMap['descripcion'] ?? 'Descripción',
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
          ),
        ),
        if (itemMap['isNew'] ?? false)
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

  Widget _buildSmallImageWithTitle() {
    final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 80.0,
          child: Image(
            image: _getImageProvider(),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      itemMap['categoria'] ?? 'Categoría',
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    itemMap['fecha'] ?? 'Fecha',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
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
    return Column(
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
    );
  }

  ImageProvider _getImageProvider() {
    if (item != null && item is Map<String, dynamic>) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;

      final String? fotoString = itemMap['fotoString'] as String?;
      final String? fotoUrl = itemMap['fotoUrl'] as String?;

      if (fotoString != null) {
        return AssetImage(fotoString);
      } else if (fotoUrl != null) {
        return NetworkImage(fotoUrl);
      }
    }
    return AssetImage('assets/images/placeholder_image.jpg');
  }
}
