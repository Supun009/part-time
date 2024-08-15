import 'package:flutter/material.dart';

class TopicTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final IconData? icon;
  const TopicTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(color: Colors.grey.shade800, width: 1.0),
        //   ),
        // ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}