import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

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
            const SizedBox(height: 165),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: alturaDeseada, vertical: padding),
              child: yogaImage2(),
            ),
            const SizedBox(height: 60),
            const YogaDaily2(),
            const SizedBox(height: 215),
            const BarraNavegacion2(),
          ],
        ),
      ),
    ));
  }
}

Widget yogaImage2() {
  return SizedBox(
    height: 231.01,
    width: 329.0,
    child: Image.asset('assets/images/yoga2.png'),
  );
}

class YogaDaily2 extends StatelessWidget {
  const YogaDaily2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: 160,
          height: 35,
          child: Text('Meditation',
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
            width: 233,
            height: 49,
            child: Text(
              'Yoga Classes',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w700,
                  fontSize: 38,
                  fontFamily: 'PTSans'),
            )),
        SizedBox(height: 20),
        SizedBox(
          width: 350,
          height: 60,
          child: Text(
            'Meditation is the key to Productivity. \nHappiness & Longevity',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF677294),
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'PTSans'),
          ),
        ),
        SizedBox(height: 65),
        Buttom2(),
      ],
    );
  }
}

class Buttom2 extends StatelessWidget {
  const Buttom2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(140, 60), // button width and height
      child: ElevatedButton(
        onPressed: () {
          context.push('/onboarding3');
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

class BarraNavegacion2 extends StatelessWidget {
  const BarraNavegacion2({super.key});

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
                  context.push('/welcome');
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
                    context.push("/onboarding1");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.radio_button_checked),
                  onPressed: () {},
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
    );
  }
}
