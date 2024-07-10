import 'package:alpha_gymnastic_center/aplication/BLoC/theme/theme_cubit.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/change_password/change_password_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/user/user/user_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/user/change_password_use_case.dart';
import 'package:alpha_gymnastic_center/config/routes/router.dart';
import 'package:alpha_gymnastic_center/config/theme/themes.dart';
import 'package:alpha_gymnastic_center/infraestructure/services/config/inject_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'aplication/BLoC/video/video_bloc.dart';
import 'aplication/serviceAplication/progress/progress_service.dart';
import 'infraestructure/services/config/firebase/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectManager.setUpInjections();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const BlocsProvider());
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProgressService>(
          create: (context) => ProgressService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RouterSimpleCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(
              create: (context) => ChangePasswordBloc(
                    changePasswordUseCase:
                        GetIt.instance<ChangePasswordUseCase>(),
                  )),
          BlocProvider(create: (context) => UserBloc()),
          BlocProvider(
              create: (context) => VideoBloc(
                  context.read<ProgressService>())), // Agrega VideoBloc aquí
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.watch<RouterSimpleCubit>().state;
    final themeCubit = context.watch<ThemeCubit>();
    return MaterialApp.router(
      title: 'Gymnastic Center',
      theme: AppTheme(isDarkmode: themeCubit.state.isDark).getTheme(),
      routerConfig: appRouter,
    );
  }
}
