import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/CreateNewPass.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/fondo.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.color),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Transform.scale(
                scale:
                    0.5, // Escala deseada para reducir el tamaño de la imagen
                child: Image.asset(
                  "assets/images/logoblanco.png", // Ruta de la imagen
                  fit: BoxFit.cover, // Ajustar la imagen al contenedor
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20), // Espacio adicional entre los textos
        const Text(
          "Please enter your email",
          style: TextStyle(
            color: Colors.grey,
            fontSize:
                14, // Tamaño de fuente más pequeño para el texto explicativo
          ),
        ),
        const SizedBox(height: 40), // Aumenta la distancia entre los textos
        _buildInputField(emailController,
            labelText:
                "Email"), // Agrega un texto al campo de correo electrónico
        const SizedBox(height: 80),
        _buildSubmitButton(),
        const SizedBox(height: 70),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false, String? labelText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText, // Utiliza el labelText proporcionado
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.email),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const CreatePasswordPage();
          }),
        );
        // Aquí iría la lógica para enviar el correo electrónico al backend para recuperar la contraseña
        debugPrint("Email: ${emailController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "Send New Password",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
