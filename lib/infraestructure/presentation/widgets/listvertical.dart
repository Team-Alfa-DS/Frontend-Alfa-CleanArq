import 'package:flutter/material.dart';

class ListV<T> extends StatelessWidget {
  final T item;
  final Function(T item) onTap;

  const ListV({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        margin: const EdgeInsets.all( 10.0),
        width: 200.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: _buildText(),
      ),
    );
  }

  Widget _buildText() {
    final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
    return Stack(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.9),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        itemMap['titulo'] ?? 'Titulo',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        itemMap['description'] ?? 'Descripción',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
