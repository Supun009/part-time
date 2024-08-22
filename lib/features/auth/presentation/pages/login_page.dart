// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:parttime/features/auth/presentation/widgets/auth_button.dart';
import 'package:parttime/features/auth/presentation/widgets/auth_field.dart';
import 'package:parttime/features/menu/presentation/pages/password_reset_page.dart';

class Loginpage extends StatefulWidget {
  final void Function()? onTap;
  const Loginpage({
    super.key,
    required this.onTap,
  });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is Authfailure) {
            state.message == "No token found"
                ? const Loader()
                : showSnacBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      hintText: 'Pasword',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 15),
                    AuthButton(
                      buttonText: 'Sign in',
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          context.read<AuthBlocBloc>().add(AuthLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                                text: 'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ))
                          ])),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PasswordResetPage(),
                            ));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: 'forgot password? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                                text: 'Reset',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ))
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
