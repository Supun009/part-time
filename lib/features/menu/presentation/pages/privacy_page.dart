import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:parttime/features/menu/presentation/widgets/privacy_tile.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  void initState() {
    super.initState();
    _getFAQs();
  }

  void _getFAQs() {
    context.read<MenuBloc>().add(PrivacygetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Privacy policies',
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
            BlocConsumer<MenuBloc, MenuState>(
              listener: (context, state) {
                if (state is Menufailure) {
                  showSnacBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is MenuLoading) {
                  return const SizedBox(
                      height: 600, child: Center(child: Loader()));
                }
                if (state is PrivacyLoaded) {
                  return PrivacyTile(privacy: state.privacy);
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
