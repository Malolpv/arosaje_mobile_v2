import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation/navigation.dart';

class BottomNav extends StatelessWidget {
  final activeButtonIndex;
  const BottomNav(this.activeButtonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    return BottomNavigationBar(
        currentIndex: activeButtonIndex,
        onTap: (buttonIndex) {
          switch (buttonIndex) {
            case 0:
              navigation.changeScreen('/');
              break;
            case 1:
              navigation.changeScreen('/availableMissions');
              break;
            case 2:
              navigation.changeScreen('/myMissions');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mes Jardins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.zoom_in),
            label: 'Missions disponibles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Mes missions',
          ),
        ]);
  }
}
