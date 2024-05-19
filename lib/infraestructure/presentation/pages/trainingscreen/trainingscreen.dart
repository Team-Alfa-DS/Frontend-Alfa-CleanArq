import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/navegation.dart';
import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrainingAppBar(title: "Training"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildPopularCoursesSection(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Programs Master",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            programsMaster(
              '30 day yoga challenge',
              'Ralph Edwards',
              'Level 5',
              'assets/icons/Yoga Ejemplo.png',
            ),
            programsMaster(
              '45 day advanced yoga',
              'Sarah Conner',
              'Level 7',
              'assets/icons/Yoga Ejemplo.png',
            ),
            programsMaster(
              '15 day relax program',
              'Mike Tyson',
              'Level 3',
              'assets/icons/Yoga Ejemplo.png',
            ),
          ],
        ),
      ),
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
          onPressed: () {
            // Aquí va la acción del botón
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Image.asset('assets/icons/rayo.png',
              color: Colors.white, width: 35.0, height: 35.0),
        ),
      ),
      bottomNavigationBar: const BarraNavegacion(),
    );
  }

  Widget _buildPopularCoursesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most Popular Courses',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/videos');
                },
                child: const Text('See all >'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCourseCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/v1.png', // Your image paths as placeholders
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Text(
              'New!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ['Savannah Nguyen', 'Theresa Webb', 'Mike Tyson'][index],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Yoga app',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget programsMaster(
      String title, String instructor, String difficulty, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  instructor,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  difficulty,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Ajustado para acomodar los botones

  final String title;

  const TrainingAppBar({
    super.key,
    required this.title,
  });

  @override
  _TrainingAppBarState createState() => _TrainingAppBarState();
}

class _TrainingAppBarState extends State<TrainingAppBar> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
            color: Colors.white), // Asegura que el título es blanco
      ),
      backgroundColor: Colors.deepPurple,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: Colors.deepPurple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTabItem(0, 'Master'),
              _buildTabItem(1, 'Skilled'),
              _buildTabItem(2, 'Beginner'),
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circulo a la izquierda del texto
          if (_selectedTabIndex == index)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 4,
                backgroundColor: Colors.white,
              ),
            ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: _selectedTabIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
