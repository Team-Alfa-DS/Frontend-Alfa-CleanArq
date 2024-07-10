import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/login_page.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/register.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _checkAndSetOnboardingSeen();

    return Container(
      color: Colors.white, // Fondo blanco
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Welcome to yoga",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Ajusta según tus necesidades
            child: Text(
              "Online class",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                decoration: TextDecoration.none, // Eliminando el subrayado
              ),
            ),
          ),
          const SizedBox(height: 20), // Espacio entre el texto y los botones
          _buildButtonRow(context), // Agrega la fila de botones
          const SizedBox(
              height:
                  20), // Espacio entre los botones y los iconos de redes sociales
          // Agrega la fila de iconos de redes sociales
        ],
      ),
    );
  }

  void _checkAndSetOnboardingSeen() async {
    final localStorage = GetIt.instance<LocalStorage>();
    final isOnboardingSeen = await localStorage.isOnboardingSeen();
    if (!isOnboardingSeen) {
      await localStorage.setOnboardingSeen();
    }
  }

  Widget _buildButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20), // Ajusta el espaciado horizontal
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoginButton(context),
          const SizedBox(width: 10), // Espacio entre los botones
          _buildRegisterButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 20,
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size(120, 40), // Tamaño del botón Login
      ),
      child: const Text("Login", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 20,
        backgroundColor: Colors.white,
        minimumSize: const Size(120, 40), // Tamaño del boton Sign Up
      ),
      child: const Text("Sign up", style: TextStyle(color: Colors.deepPurple)),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.grey,
          fontSize: 14, // Tamaño del texto
          fontFamily: 'Roboto', // Fuente del texto
          decoration: TextDecoration.none),
    );
  }
}
