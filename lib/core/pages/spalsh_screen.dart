import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/isFirsttime/is_firsttime_cubit.dart';
import 'package:parttime/core/pages/first_open_page.dart';
import 'package:parttime/core/pages/route_finder_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final isFirsttime = context.read<IsFirsttimeCubit>().state;
    // Navigate to the next screen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => isFirsttime is IsFirsttimeInitial
            ? const FirstOpenPage()
            : RouteFinderPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or app name
            Text(
              'Part Time Jobs',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.work,
              size: 80,
            ),
            SizedBox(height: 20),
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(
            //       Colors.blue), // Change the color as needed
            // ),
          ],
        ),
      ),
    );
  }
}
