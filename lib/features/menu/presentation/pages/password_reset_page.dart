import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:parttime/features/menu/presentation/widgets/menu_text_field.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  void _resetPassword(String email) {
    context.read<MenuBloc>().add(PAsswordResetEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password reset',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formkey,
          child: BlocConsumer<MenuBloc, MenuState>(
            listener: (context, state) {
              if (state is Menufailure) {
                showSnacBar(context, state.message);
              }
              if (state is PasswordReset) {
                showSnacBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is MenuLoading) {
                return const Loader();
              }
              return Column(
                children: [
                  const SizedBox(height: 20),
                  MenuTextField(
                      hintText: 'Enter email', controller: emailController),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        _resetPassword(emailController.text);
                      }
                    },
                    child: Text(
                      'Reset password',
                      style: Theme.of(context)
                              .textButtonTheme
                              .style
                              ?.textStyle
                              ?.resolve({}) ??
                          const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
