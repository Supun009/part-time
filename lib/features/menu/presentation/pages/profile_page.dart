import 'package:flutter/material.dart';
import 'package:parttime/core/entities/models/user.dart';

import 'package:parttime/features/menu/presentation/pages/account_delete_page.dart';
import 'package:parttime/features/menu/presentation/pages/password_reset_page.dart';
import 'package:parttime/features/menu/presentation/widgets/menu_tile.dart';

class ProfiePage extends StatefulWidget {
  final User user;

  const ProfiePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfiePage> createState() => _ProfiePageState();
}

class _ProfiePageState extends State<ProfiePage> {
  void _passwordReset() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordResetPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                MenuTile(
                  text: widget.user.name,
                  icon: Icons.person, // Icon for the user's name
                  onTap: null,
                ),
                MenuTile(
                  text: widget.user.email,
                  icon: Icons.email, // Icon for the user's email
                  onTap: null,
                ),
                MenuTile(
                  text: 'Reset password',
                  icon: Icons.lock_reset, // Icon for resetting the password
                  onTap: _passwordReset,
                ),
              ],
            ),

            const SizedBox(height: 20),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'edit profile',
            //     style: Theme.of(context)
            //             .textButtonTheme
            //             .style
            //             ?.textStyle
            //             ?.resolve({}) ??
            //         const TextStyle(fontSize: 20),
            //   ),
            // ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReasonSelectionPage(),
                    ));
              },
              child: Text(
                'delete account',
                style: Theme.of(context)
                        .textButtonTheme
                        .style
                        ?.textStyle
                        ?.resolve({}) ??
                    const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
