import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:parttime/core/cubits/add_cubit/add_cubit_cubit.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/cubits/category/category_cubit.dart';
import 'package:parttime/core/cubits/isFirsttime/is_firsttime_cubit.dart';
import 'package:parttime/core/cubits/language/language_cubit.dart';
import 'package:parttime/core/cubits/theme-cubit/theme_cubit.dart';
import 'package:parttime/core/notification/notification_service.dart';
import 'package:parttime/core/pages/spalsh_screen.dart';
import 'package:parttime/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:parttime/generated/l10n.dart';
import 'package:parttime/init_dependancies.dart';
import 'package:upgrader/upgrader.dart';
import 'features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initDependancies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBlocBloc>()),
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<CategoryCubit>()),
        BlocProvider(create: (_) => serviceLocator<JobBloc>()),
        BlocProvider(create: (_) => serviceLocator<MenuBloc>()),
        BlocProvider(create: (_) => serviceLocator<ThemeCubit>()),
        BlocProvider(create: (_) => serviceLocator<AddCubitCubit>()),
        BlocProvider(create: (_) => serviceLocator<LanguageCubit>()),
        BlocProvider(create: (_) => serviceLocator<IsFirsttimeCubit>()),
      ],
      child: const MyApp(),
    ),
  );
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
    context.read<JobBloc>().add(JobcateoriesLoadEvent());
    context.read<JobBloc>().add(GetAllJobs());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final languageState = context.watch<LanguageCubit>().state;

    final theme = themeState is LightMode
        ? themeState.theme
        : themeState is DarkMode
            ? themeState.theme
            : ThemeData.light();

    final language = languageState is LanguageInitial
        ? languageState.locale
        : languageState is LanguageChanged
            ? languageState.locale
            : Locale('en', '');

    return UpgradeAlert(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: language,
          supportedLocales: S.delegate.supportedLocales,
          title: 'part time jobs',
          theme: theme,
          home: const SplashScreen()),
    );
  }
}
