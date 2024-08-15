import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentindex;
  final Function(int)? onTap;
  const BottomNavBar({
    super.key,
    required this.currentindex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post job'),
          // BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu')
        ]);
  }
}
