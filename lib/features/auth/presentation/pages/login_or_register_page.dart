import 'package:flutter/material.dart';
import 'package:parttime/features/auth/presentation/pages/login_page.dart';
import 'package:parttime/features/auth/presentation/pages/sign_up_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool isLoginPage = false;

  void _toogLePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return SignUpPage(
        onTap: _toogLePage,
      );
    } else {
      return Loginpage(
        onTap: _toogLePage,
      );
    }
  }
}
