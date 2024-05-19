import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/Course.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/auth/location_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/auth/verification_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/blogs.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/home/home_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/login/login_page.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/notifications/notification_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/popularsearchscreen/Popular_Search.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/settingscreen/faqscreen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/settingscreen/settingsscreen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/splashscreen/splash_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/tipsscreen/Tips_topics.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/trainingscreen/trainingscreen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/videos.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymnastic Center',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/notification': (context) => NotificationScreen(),
        '/settings': (context) => const SettingsPage(),
        '/verification': (context) => const VerificationScreen(),
        '/popularSearch': (context) => const PopularSearch(),
        '/trainingScreen': (context) => const TrainingScreen(),
        '/tipsTopics': (context) => const Tips_n_Topics_Screen(),
        '/videos': (context) => const Videos(),
        '/courses': (context) => const YogaHomePage(),
        '/location': (context) => const LocationScreen(),
        '/login': (context) => const LoginPage(),
        '/faq': (context) => const FAQScreen(),
        '/blogs': (context) => const YogaBlogScreen(),
      },
    );
  }
}
