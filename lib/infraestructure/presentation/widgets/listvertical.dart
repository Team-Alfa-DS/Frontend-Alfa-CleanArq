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
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        // Set a fixed width for the list items
        width: 200.0,
        // Set a fixed height (optional) or remove entirely
        height: 120.0, // Adjust height as needed
        decoration: BoxDecoration(
          color: Colors.white, // Consistent background for the list
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
                color: Colors.grey.withOpacity(0.7),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        itemMap['titulo'] ?? 'Titulo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        itemMap['cuerpo'] ?? 'Descripción',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
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
