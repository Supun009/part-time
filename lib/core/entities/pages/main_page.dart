import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/features/auth/presentation/pages/login_or_register_page.dart';
import 'package:parttime/features/jobs/presentation/pages/job_manager_page.dart';
import 'package:parttime/features/jobs/presentation/pages/job_page.dart';

import 'package:parttime/features/jobs/presentation/pages/job_search_page.dart';
import 'package:parttime/features/menu/presentation/pages/menu_page.dart';
import 'package:parttime/core/entities/widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const JobManagerPage(),
    // const SavedJobsPage(),
    const MenuPage(),
  ];

  //navigate bottom nav bar
  void _navigateBottomnavbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AppUserInitial) {
          return const LoginOrRegisterPage();
        }
        return Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavBar(
              currentindex: _currentIndex,
              onTap: _navigateBottomnavbar,
            ));
      },
    );
  }
}
