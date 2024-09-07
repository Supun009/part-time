import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/features/auth/presentation/pages/login_or_register_page.dart';
import 'package:parttime/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:parttime/generated/l10n.dart';

class ReasonSelectionPage extends StatefulWidget {
  const ReasonSelectionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReasonSelectionPageState createState() => _ReasonSelectionPageState();
}

class _ReasonSelectionPageState extends State<ReasonSelectionPage> {
  String? selectedReason;

  Future<void> _deleteUserAccount(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(S.of(context).deleteaccount),
          content: Text(
            'Are you sure you want to delete your account?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).delete),
              onPressed: () {
                context.read<MenuBloc>().add(UserDeletedEvent(
                      reason: selectedReason!,
                    ));
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginOrRegisterPage(),
                  ),
                  (Route route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Select a Reason',
          //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Please select a reason for deleting your account:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              // List of reasons with radio buttons
              Column(
                children: [
                  _buildReasonOption('I no longer need the service'),
                  _buildReasonOption('I found a better alternative'),
                  _buildReasonOption('I had a bad experience'),
                  _buildReasonOption('Other'),
                ],
              ),

              TextButton(
                child: Text(S.of(context).delete),
                onPressed: () {
                  _deleteUserAccount(context);
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (selectedReason != null) {
              //       // Here you can handle the selected reason
              //       Navigator.pop(context, selectedReason);
              //     } else {
              //       // Optionally show a message if no reason is selected
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(content: Text('Please select a reason')),
              //       );
              //     }
              //   },
              //   child: const Text('Delete Account'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonOption(String reason) {
    return RadioListTile<String>(
      activeColor: Colors.blue,
      title: Text(reason),
      value: reason,
      groupValue: selectedReason,
      onChanged: (value) {
        setState(() {
          selectedReason = value;
        });
      },
    );
  }
}
