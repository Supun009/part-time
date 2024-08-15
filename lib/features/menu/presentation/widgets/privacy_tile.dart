// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PrivacyTile extends StatelessWidget {
  final Map<String, dynamic> privacy;

  const PrivacyTile({
    super.key,
    required this.privacy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        // decoration: BoxDecoration(
        //   color: Theme.of(context).colorScheme.secondary,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                privacy['title'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              privacy['description'],
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
