import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/auth/password_changed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController phoneController = TextEditingController();

// VAR
  String email = 'ejemplo@gmail.com'; //

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Transform.scale(
                scale: 0.3,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      height: 600,
      width: mediaSize.width,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(150),
            topRight: Radius.circular(150),
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    String email = 'ejemplo@gmail.com';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        const Text(
          "Verification Code",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 25),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text:
                    'Please type the verification code sent to \n                 ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: 'PTSans'),
              ),
              TextSpan(
                text: email,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'PTSans'),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Aca se colocaria para volver a enviar el correo
                  },
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildInputField(phoneController),
        const SizedBox(height: 30),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'I don’t receive a code! ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    fontFamily: 'PTSans'),
              ),
              TextSpan(
                text: 'Please resend',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontFamily: 'PTSans'),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Aca se colocaria para volver a enviar el correo
                  },
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    String pinCode = '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 0),
        Container(
          width: 50.0, // Ancho de cada cuadro
          height: 50.0, // Altura de cada cuadro
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
                Radius.circular(10)), // Borde para el cuadro
          ),
          child: TextFormField(
            keyboardType: TextInputType.number, // Teclado numérico
            //maxLength: 1, // Limitar a un solo dígito
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                pinCode = value; // Actualizar la variable
              });
            }, // Alinear el texto en el centro
          ),
        ),
        const SizedBox(width: 20), // Espacio entre cuadros
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            //maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                pinCode = value; // Actualizar la variable
              });
            },
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            //maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                pinCode = value; // Actualizar la variable
              });
            },
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            //maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                pinCode = value; // Actualizar la variable
              });
            },
          ),
        ),
        Text(
          pinCode,
          style: const TextStyle(fontSize: 24.0),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const PasswordChanged(),
        ));
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "Sign up",
        style: TextStyle(color: Colors.deepPurple),
      ),
    );
  }

  //  void _registerUser(String fullName, String phoneNumber, String email, String password) async {
  //   var url = Uri.parse('https://***** aqui va url del back/register');
  //   var response = await http.post(
  //     url,
  //     body: {
  //       'fullName': fullName,
  //       'phoneNumber': phoneNumber,
  //       'email': email,
  //       'password': password,
  //       Agrega otros campos de formulario aquí según sea necesario
  //     },
  // );
}
