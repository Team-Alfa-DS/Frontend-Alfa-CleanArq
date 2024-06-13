import 'package:alpha_gymnastic_center/aplication/BLoC/user/validate_code/validate_code_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/validate_code_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/CreateNewPass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ValidateCodeBloc(
        validateCodeUseCase: GetIt.instance<ValidateCodeUseCase>(),
      ),
      child: BlocListener<ValidateCodeBloc, ValidateCodeState>(
        listener: (context, state) {
          if (state is ValidateCodeSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreatePasswordPage()),
            );
          } else if (state is ValidateCodeFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(
                      "Code validation failed. Error: ${state.failure.message}"),
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
    String email = widget.email; // Usar el email pasado al constructor

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
        _buildInputField(codeController),
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
        _buildVerifyButton(),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: "Code",
        suffixIcon: Icon(Icons.code),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<ValidateCodeBloc, ValidateCodeState>(
      builder: (context, state) {
        if (state is ValidateCodeLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () {
            if (codeController.text.isNotEmpty) {
              try {
                int code = int.parse(codeController.text);
                BlocProvider.of<ValidateCodeBloc>(context).add(
                  ValidateCodeSubmitted(email: widget.email, code: code),
                );
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("¡Attention!"),
                      content: const Text("Please enter a valid code"),
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
                    content: const Text("Please enter the code"),
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
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(60),
          ),
          child: const Text(
            "Verify",
            style: TextStyle(color: Colors.deepPurple),
          ),
        );
      },
    );
  }
}
