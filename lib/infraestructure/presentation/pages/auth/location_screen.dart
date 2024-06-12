import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const LocationScreen());

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double alturaPantalla = mediaQuery.size.height;
    double alturaDeseada = alturaPantalla * 0.1;
    double anchoPantalla = mediaQuery.size.width;
    double padding = anchoPantalla * 0.05;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: alturaDeseada, vertical: padding),
                child: ubiImage(),
              ),
              const SizedBox(height: 0),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: alturaDeseada, vertical: padding),
                child: textUbi(),
              ),
              const SizedBox(height: 40),
              const SizedBox(width: 350, child: ButtomLogin()),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: alturaDeseada, vertical: padding),
                child: textUbi2(),
              ),
              const SizedBox(height: 50),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Or',
                      style: const TextStyle(
                          color: Color(0xFF4F14A0),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: 'PTSans'),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Aca se colocaria para volver a enviar el correo
                        },
                    ),
                    const TextSpan(
                      text: ' set your location manually ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'PTSans'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ubiImage() {
  return SizedBox(
    height: 187.68,
    width: 172.09,
    child: Image.asset('assets/images/ubicacion.png'),
  );
}

Widget textUbi() {
  return const Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 50,
        width: 1000,
        child: Text('Hi ! Make your location \n   allow with us',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: 'PTSans',
            )),
      ),
      SizedBox(height: 20),
      SizedBox(
          child: Text(
        'Set your location to start find trainer \n   around you',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xFF677294),
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: 'PTSans'),
      )),
    ],
  );
}

class ButtomLogin extends StatelessWidget {
  const ButtomLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => HomeScreen(courses: const [],),
        ));
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: const Color(0xFF4F14A0),
        minimumSize: const Size.fromHeight(60),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 60,
          ),
          Image.asset('assets/images/vector.png'),
          const SizedBox(width: 20),
          const Text(
            "Use your location",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'PTSans'),
          ),
        ],
      ),
    );
  }
}

Widget textUbi2() {
  return const Column(
    children: [
      SizedBox(
        width: 1000,
        child: Text(
            'We only access your location while ou are using \nthis location app  ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF677294),
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontFamily: 'PTSans',
            )),
      ),
    ],
  );
}
