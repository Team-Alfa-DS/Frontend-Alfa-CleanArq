import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/get_current_user_use_case.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _splashBloc = SplashBloc(
        getCurrentUserUseCase: GetIt.instance<GetCurrentUserUseCase>(),
        userBloc: BlocProvider.of<UserBloc>(context))
      ..add(CheckForTokenEvent());
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    const splash = AssetImage('assets/images/splash.png');
    return BlocProvider(
      create: (_) => _splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            context.go('/home');
          } else if (state is SplashUnauthenticated) {
            Future.delayed(const Duration(seconds: 5), () {
              context.go("/onboarding1");
            });
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: splash, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
