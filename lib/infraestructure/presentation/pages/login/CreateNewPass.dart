import 'package:alpha_gymnastic_center/aplication/BLoC/user/change_password/change_password_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CreatePasswordPage extends StatefulWidget {
  final String email;
  final int code;

  const CreatePasswordPage(
      {super.key, required this.email, required this.code});

  @override
  _CreatePasswordPageState createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              top: 10,
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
    return BlocProvider(
      create: (context) => ChangePasswordBloc(
        changePasswordUseCase: GetIt.instance<ChangePasswordUseCase>(),
      ),
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else if (state is ChangePasswordFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(
                      "Password change failed. Error: ${state.failure.message}"),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Create Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(newPasswordController, labelText: "New Password"),
            const SizedBox(height: 20),
            _buildInputField(confirmPasswordController,
                labelText: "Confirm Password"),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {String? labelText}) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: const Icon(Icons.lock),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (newPasswordController.text == confirmPasswordController.text) {
          BlocProvider.of<ChangePasswordBloc>(context).add(
            ChangePasswordSubmitted(
              email: widget.email,
              code: widget.code,
              newPassword: newPasswordController.text,
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Passwords do not match."),
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
        minimumSize: const Size.fromHeight(60),
        backgroundColor: Colors.deepPurple,
      ),
      child: const Text(
        "Create",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
