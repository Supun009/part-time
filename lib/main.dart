import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:parttime/core/cubits/add_cubit/add_cubit_cubit.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/cubits/theme-cubit/theme_cubit.dart';
import 'package:parttime/core/pages/spalsh_screen.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:parttime/init_dependancies.dart';
import 'package:upgrader/upgrader.dart';
import 'features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initDependancies();
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBlocBloc>()),
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<JobBloc>()),
      BlocProvider(create: (_) => serviceLocator<MenuBloc>()),
      BlocProvider(create: (_) => serviceLocator<ThemeCubit>()),
      BlocProvider(create: (_) => serviceLocator<AddCubitCubit>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBlocBloc>().add(AppStarted());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final theme = themeState is LightMode
        ? themeState.theme
        : themeState is DarkMode
            ? themeState.theme
            : ThemeData.light();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'part time jobs',
        theme: theme,
        home: UpgradeAlert(child: const SplashScreen()));
  }
}
