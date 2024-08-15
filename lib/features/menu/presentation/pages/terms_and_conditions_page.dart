import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/entities/widgets/loader.dart';
import 'package:parttime/core/utills/show_snac_bar.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:parttime/features/menu/presentation/widgets/terms_tile.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  void initState() {
    super.initState();
    _getTermss();
  }

  void _getTermss() {
    context.read<MenuBloc>().add(TermsgetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Terms & Conditions',
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
                if (state is TermsLoaded) {
                  return TermsTile(term: state.terms);
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
