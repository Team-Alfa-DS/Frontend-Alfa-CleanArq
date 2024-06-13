import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:alpha_gymnastic_center/infraestructure//presentation/pages/pages.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
    path: '/notification',
    builder: (context, state) => NotificationScreen(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
  ),
  GoRoute(
    path: '/verification',
    builder: (context, state) => const VerificationScreen(),
  ),
  GoRoute(
    path: '/popularSearch',
    builder: (context, state) => const PopularSearch(),
  ),
  GoRoute(
    path: '/trainingScreen',
    builder: (context, state) => const TrainingScreen(),
  ),
  GoRoute(
    path: '/videos',
    builder: (context, state) => const Videos(),
  ),
  GoRoute(
    path: '/courses',
    builder: (context, state) => const CourseDetailView(),
  ),
  GoRoute(
    path: '/blogs',
    builder: (context, state) => Blogs_Screen(),
  ),
  GoRoute(
    path: '/location',
    builder: (context, state) => const LocationScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/faq',
    builder: (context, state) => const FAQScreen(),
  ),
  GoRoute(
    path: '/onboarding1',
    builder: (context, state) => const OnBoardingScreen1(),
  ),
  GoRoute(
    path: '/onboarding2',
    builder: (context, state) => const OnBoardingScreen2(),
  ),
  GoRoute(
    path: '/Course_test',
    builder: (context, state) => const CourseDetailView(),
  ),
  GoRoute(
    path: '/onboarding3',
    builder: (context, state) => const OnBoardingScreen3(),
  ),
  GoRoute(path: "/welcome", builder: (context, state) => const WelcomeScreen()),
]);

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit() : super(router);

  void goBack() {
    state.pop();
  }

  void goHome() {
    state.go('/home');
  }
}
