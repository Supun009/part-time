import 'package:flutter/material.dart';
import 'package:parttime/features/menu/presentation/pages/contact_us_page.dart';
import 'package:parttime/features/menu/presentation/pages/privacy_page.dart';
import 'package:parttime/features/menu/presentation/pages/terms_and_conditions_page.dart';
import 'package:parttime/features/menu/presentation/widgets/menu_tile.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MenuTile(
              text: 'Terms and Conditions',
              icon: Icons.description, // Added icon
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsAndConditionsPage(),
                  ),
                );
              },
            ),
            MenuTile(
              text: 'Privacy Policy',
              icon: Icons.privacy_tip, // Added icon
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPage(),
                  ),
                );
              },
            ),
            MenuTile(
              text: 'Contact Us',
              icon: Icons.contact_mail, // Added icon
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ),
                );
              },
            ),
            // Uncomment these if you want to include them with icons as well
            // MenuTile(
            //   text: 'About Us',
            //   icon: Icons.info_outline, // Added icon
            //   onTap: () {},
            // ),
            // MenuTile(
            //   text: 'App version',
            //   icon: Icons.app_settings_alt, // Added icon
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
