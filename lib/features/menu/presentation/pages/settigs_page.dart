import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/language/language_cubit.dart';
import 'package:parttime/core/cubits/theme-cubit/theme_cubit.dart';
import 'package:parttime/generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _loadlanguage();
  }

  void _loadlanguage() {
    final languageState = context.read<LanguageCubit>().state;
    if (languageState is LanguageInitial) {
      _selectedLocale = languageState.locale;
    } else if (languageState is LanguageChanged) {
      _selectedLocale = languageState.locale;
    }
  }

  bool isNotifion = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).colorScheme.primary,
                      ), // Icon for Dark Mode
                      const SizedBox(width: 10),
                      const Text(
                        'Dark mode',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: context.read<ThemeCubit>().state is DarkMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        activeColor: Colors.blue
                            .shade300, // Color of the thumb when switch is on
                        activeTrackColor: Theme.of(context)
                            .colorScheme
                            .primary, // Color of the track when switch is on
                        inactiveThumbColor: Colors
                            .grey, // Color of the thumb when switch is off
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Language Selector
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        S.of(context).language,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  DropdownButton<Locale>(
                    value: _selectedLocale,
                    items: [
                      DropdownMenuItem(
                        value: Locale('en', ''),
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: Locale('si', ''),
                        child: Text('සිංහල'),
                      ),
                    ],
                    onChanged: (Locale? newLocale) {
                      if (newLocale != null) {
                        setState(() {
                          _selectedLocale = newLocale;
                        });
                        context
                            .read<LanguageCubit>()
                            .changeLanguage(_selectedLocale!);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
