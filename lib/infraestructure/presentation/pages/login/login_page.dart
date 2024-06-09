import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/auth/location_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/forgotpass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  // Abre LoginPage
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
} // Cierra LoginPage

class _LoginPageState extends State<LoginPage> {
  // Abre _LoginPageState
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    // Abre build
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;

    return Container(
      // Abre Container
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
        // Abre Scaffold
        backgroundColor: Colors.transparent,
        body: Stack(
          // Abre Stack
          children: [
            Positioned(
              top: -65,
              left: 0,
              right: 0,
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset(
                  "assets/images/logoblanco.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ), // Cierra Scaffold
    ); // Cierra Container
  } // Cierra build

  Widget _buildBottom() {
    // Abre _buildBottom
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
          padding: const EdgeInsets.all(5.0),
          child: _buildForm(),
        ),
      ),
    );
  } // Cierra _buildBottom

  Widget _buildForm() {
    // Abre _buildForm
    return SizedBox(
      height: 560,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildGreyText("Hi! Enter your credentials"),
          const SizedBox(height: 60),
          _buildGreyText("Email"),
          _buildInputField(emailController),
          const SizedBox(height: 40),
          _buildGreyText("Password"),
          _buildInputField(passwordController, isPassword: true),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          _buildLoginButton(),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage()),
              );
            },
            child: const Text("Forgot password?"),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  } // Cierra _buildForm

  Widget _buildGreyText(String text) {
    // Abre _buildGreyText
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  } // Cierra _buildGreyText

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    // Abre _buildInputField
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  } // Cierra _buildInputField

  Widget _buildLoginButton() {
    // Abre _buildLoginButton
    return ElevatedButton(
      onPressed: () {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          if (EmailValidator.validate(emailController.text)) {
            _loginUser(); // Llama a la función para iniciar sesión
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("¡Attention!"),
                  content: const Text("You must put a email"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("¡Attention!"),
                content: const Text("Please complete all the flieds"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  } // Cierra _buildLoginButton

  Future<void> _loginUser() async {
    final url =
        Uri.parse('https://backend-alfa-production.up.railway.app/auth/login');
    final response = await http.post(
      url,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('name', data['name'] ?? 'Nombre de Usuario');
      prefs.setString('uuid', data['id'] ?? 'ID de Usuario');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LocationScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Login failed. Error: ${response.body}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  } // Cierra _loginUser
} // Cierra _LoginPageState
