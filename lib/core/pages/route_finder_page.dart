import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/core/entities/pages/main_page.dart';
import 'package:parttime/features/auth/presentation/pages/login_or_register_page.dart';

class RouteFinderPage extends StatefulWidget {
  const RouteFinderPage({super.key});

  @override
  State<RouteFinderPage> createState() => _RouteFinderPageState();
}

class _RouteFinderPageState extends State<RouteFinderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppUserCubit, AppUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return const Loader();
          if (state is AppUserLoggedIn) {
            return const MainPage();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
