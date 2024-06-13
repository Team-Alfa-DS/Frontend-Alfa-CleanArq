import 'package:alpha_gymnastic_center/aplication/BLoC/user/change_password/change_password_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() => runApp(const PasswordChanged());

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double alturaPantalla = mediaQuery.size.height;
    double alturaDeseada = alturaPantalla * 0.1;
    double anchoPantalla = mediaQuery.size.width;
    double padding = anchoPantalla * 0.05;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/fondo.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            BlocProvider(
              create: (context) => ChangePasswordBloc(
                changePasswordUseCase: GetIt.instance<ChangePasswordUseCase>(),
              ),
              child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
                child: Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: alturaDeseada, vertical: padding),
                          child: textPass(),
                        ),
                        const SizedBox(height: 100),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: alturaDeseada, vertical: padding),
                          child: iconCheck(),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: alturaDeseada, vertical: padding),
                          child:
                              const SizedBox(width: 350, child: ButtomLogin()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textPass() {
  return const Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 40,
        width: 1000,
        child: Text(
          'Password Changed',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(height: 20),
      SizedBox(
        height: 40,
        width: 1000,
        child: Text(
          'Congratulations! You have successfully \n             changed your password.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

Widget iconCheck() {
  return Image.asset(
    'assets/images/check.png',
    width: 160.0,
    height: 160.0,
  );
}

class ButtomLogin extends StatelessWidget {
  const ButtomLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<ChangePasswordBloc>(context).add(
            const ChangePasswordSubmitted(
              email: "example@example.com",
              code: "123456",
              newPassword: "newPassword123",
            ),
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
      ),
    );
  }
}
