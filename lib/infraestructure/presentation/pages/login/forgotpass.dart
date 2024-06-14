import 'package:flutter/material.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/forgot_password/forgot_password_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/forgot_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        forgotPasswordUseCase: GetIt.instance<ForgotPasswordUseCase>(),
      ),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            context.push('/verification', extra: emailController.text);
          } else if (state is ForgotPasswordFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(
                      "Failed to send new password. Error: ${state.failure.message}"),
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
        child: Container(
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
        const SizedBox(height: 20),
        const Text(
          "Please enter your email",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 40),
        _buildInputField(emailController, labelText: "Email"),
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
        labelText: labelText,
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.email),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        if (state is ForgotPasswordLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () {
            if (emailController.text.isNotEmpty) {
              BlocProvider.of<ForgotPasswordBloc>(context).add(
                ForgotPasswordSubmitted(email: emailController.text),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("¡Attention!"),
                    content: const Text("Please complete the email field"),
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
            "Send New Password",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
