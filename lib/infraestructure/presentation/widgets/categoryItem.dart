import 'package:flutter/cupertino.dart';

class CategoryItem extends StatefulWidget {
  final String imageUrlPicked;
  final String imageUrlUnpicked;

  const CategoryItem({
    Key? key,
    required this.imageUrlPicked,
    required this.imageUrlUnpicked,
  }) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late bool isPicked;
  double opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    isPicked = true; // Default state
  }

  void toggleImage() {
    setState(() {
      opacityLevel = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 80), () {
      setState(() {
        isPicked = !isPicked;
        opacityLevel = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleImage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child:
        ClipRRect(
          borderRadius: BorderRadius.circular(9.0),
          child: Column(
            children: [
              AnimatedOpacity(
                opacity: opacityLevel,
                duration: const Duration(milliseconds: 80),
                child: Image.asset(
                  isPicked ? widget.imageUrlPicked : widget.imageUrlUnpicked,
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}