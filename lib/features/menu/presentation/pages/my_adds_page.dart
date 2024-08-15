import 'package:flutter/material.dart';

class MyAddsPage extends StatefulWidget {
  const MyAddsPage({super.key});

  @override
  State<MyAddsPage> createState() => _MyAddsPageState();
}

class _MyAddsPageState extends State<MyAddsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Adds',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
    );
  }
}
