import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/home.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/onboarding/onboarding_screen_1.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/onboarding/onboarding_screen_2.dart';
import 'package:flutter/material.dart';

void main() => runApp(const OnBoardingScreen3());

class OnBoardingScreen3 extends StatelessWidget {
  const OnBoardingScreen3({super.key});

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
            const SizedBox(height: 195),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: alturaDeseada, vertical: padding),
              child: yogaImage(),
            ),
            const SizedBox(height: 60),
            const YogaDaily(),
            const SizedBox(height: 215),
            const BarraNavegacion(),
          ],
        ),
      ),
    ));
  }
}

Widget yogaImage() {
  return SizedBox(
    height: 208.0,
    width: 290.0,
    child: Image.asset('assets/images/yoga3.png'),
  );
}

class YogaDaily extends StatelessWidget {
  const YogaDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: 85,
          height: 35,
          child: Text('Meets',
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
            width: 200,
            height: 49,
            child: Text(
              'Community',
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
          height: 55,
          child: Text(
            'Do your practice of physical exercise and \nrelaxation make helthy',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF677294),
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'PTSans'),
          ),
        ),
        SizedBox(height: 65),
        Buttom(),
      ],
    );
  }
}

class Buttom extends StatelessWidget {
  const Buttom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(140, 60), // button width and height
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const WelcomeScreen(),
          ));
        },
        child: const Row(
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

class BarraNavegacion extends StatelessWidget {
  const BarraNavegacion({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const WelcomeScreen(),
                  ));
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
                  icon: const Icon(Icons.radio_button_unchecked),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const OnBoardingScreen1(),
                    ));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.radio_button_unchecked),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const OnBoardingScreen2(),
                    ));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.radio_button_checked),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
