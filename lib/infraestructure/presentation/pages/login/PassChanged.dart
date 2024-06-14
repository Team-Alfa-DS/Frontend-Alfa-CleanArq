import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Password Changed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Congratulations! You have successfully \nchanged your password.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                Image.asset(
                  'assets/images/check.png', // Replace with the actual path to your icon image
                  width: 160.0, // Set the desired width of the icon
                  height: 160.0,
                ),
                const SizedBox(height: 70),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/login');
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
