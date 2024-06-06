import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double alturaPantalla = mediaQuery.size.height;
    double alturaDeseada = alturaPantalla * 0.1;
    double anchoPantalla = mediaQuery.size.width;
    double padding = anchoPantalla * 0.05;

    return Scaffold(
        body: Center(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 85),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: alturaDeseada, vertical: padding),
              child: yogaImage(),
            ),
            const SizedBox(height: 60),
            yogaDaily1(),
            const SizedBox(height: 215),
            const BarraNavegacion1(),
          ],
        ),
      ),
    ));
  }
}

Widget yogaImage() {
  return SizedBox(
    height: 304.0,
    width: 328.0,
    child: Image.asset('assets/images/yoga1.png'),
  );
}

Widget yogaDaily1() {
  return const Column(
    children: [
      SizedBox(
        width: 70,
        height: 40,
        child: Text('Yoga',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4F14A0),
              fontWeight: FontWeight.w400,
              fontSize: 30,
              fontFamily: 'PTSans',
            )),
      ),
      SizedBox(height: 10),
      SizedBox(
          width: 190,
          height: 49,
          child: Text(
            'Daily Yoga',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w700,
                fontSize: 38,
                fontFamily: 'PTSans'),
          )),
      SizedBox(height: 20),
      SizedBox(
        width: 400,
        height: 60,
        child: Text(
          'Do your practice of physical exercise and \n relaxation make helthy',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF677294),
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'PTSans'),
        ),
      ),
      SizedBox(height: 60),
      Buttom(),
    ],
  );
}

class Buttom extends StatelessWidget {
  const Buttom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(140, 65), // button width and height
      child: ElevatedButton(
        onPressed: () {
          context.push("/onboarding2");
        },
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  fontFamily: 'PTSans'),
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF4F14A0), // button color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.chevron_right, color: Colors.white), // icon
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarraNavegacion1 extends StatefulWidget {
  const BarraNavegacion1({super.key});

  @override
  State<BarraNavegacion1> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion1> {
  bool _botonBloqueado = false;

  void _onPressed() {
    setState(() {
      _botonBloqueado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SafeArea(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (!_botonBloqueado) {
                      _onPressed();
                      context.push('/welcome');
                    }
                  },
                  child: const Text('skip',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF677294),
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: 'PTSans'))),
              const SizedBox(width: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.radio_button_checked),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.radio_button_unchecked),
                    onPressed: () {
                      context.push("/onboarding2");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.radio_button_unchecked),
                    onPressed: () {
                      context.push("/onboarding3");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
