import 'package:alpha_gymnastic_center/aplication/BLoC/theme/theme_cubit.dart';
import 'package:alpha_gymnastic_center/config/routes/router.dart';
import 'package:alpha_gymnastic_center/config/theme/themes.dart';
import 'package:alpha_gymnastic_center/infraestructure/services/config/inject_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectManager.setUpInjections();
  runApp(const BlocsProvider());
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        //lazy false hace que tan pronto se inicialice el proveedor de bloques, se ejecute el constructor

        providers: [
          //BlocProvider(create: (context) => UsernameCubit(), lazy: false)
          BlocProvider(create: (context) => RouterSimpleCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: const MyApp());
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
      // theme: ThemeData(
      //   primarySwatch: Colors.grey,
      //   scaffoldBackgroundColor: Colors.white,
      // ),
      theme: AppTheme(isDarkmode: themeCubit.state.isDark).getTheme(),
      routerConfig: appRouter,
    );
  }
}
