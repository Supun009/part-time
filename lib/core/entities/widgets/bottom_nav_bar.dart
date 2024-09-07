import 'package:flutter/material.dart';
import 'package:parttime/generated/l10n.dart';

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
        // type: BottomNavigationBarType.fixed,
        onTap: onTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.work), label: S.of(context).jobs),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: S.of(context).search),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: S.of(context).postjob),
          // BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu), label: S.of(context).menu)
        ]);
  }
}
