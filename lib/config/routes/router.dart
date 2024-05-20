import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:alpha_gymnastic_center/infraestructure//presentation/pages/pages.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
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
    path: '/tipsTopics',
    builder: (context, state) => const Tips_n_Topics_Screen(),
  ),
  GoRoute(
    path: '/videos',
    builder: (context, state) => const Videos(),
  ),
  GoRoute(
    path: '/courses',
    builder: (context, state) => const YogaHomePage(),
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
    path: '/blogs',
    builder: (context, state) => const YogaBlogScreen(),
  ),
]);

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit() : super(router);

  void goBack() {
    state.pop();
  }

  void goHome() {
    state.go('/');
  }
}
