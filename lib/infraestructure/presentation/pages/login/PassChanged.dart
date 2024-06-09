import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const PasswordChanged());

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fondo.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 180),
                  textPass(),
                  const SizedBox(height: 70),
                  iconCheck(),
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(width: 350, child: buttonLogin(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget textPass() {
  return const Column(
    children: [
      Text(
        'Password Changed',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: 20),
      Text(
        'Congratulations! You have successfully \n             changed your password.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget iconCheck() {
  return Image.asset(
    'assets/images/check.png', // Replace with the actual path to your icon image
    width: 160.0, // Set the desired width of the icon
    height: 160.0,
  );
}

Widget buttonLogin(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const LoginPage()), // Reemplaza LoginScreen() con la pantalla a la que deseas navegar
      );
    },
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      elevation: 20,
      backgroundColor: Colors.white,
      minimumSize: const Size.fromHeight(60),
    ),
    child: const Text(
      "Back to login",
      style: TextStyle(color: Colors.deepPurple),
    ),
  );
}

// Aquí debes tener la definición de tu pantalla de inicio de sesión

