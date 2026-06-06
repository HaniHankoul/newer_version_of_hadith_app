import 'package:flutter/material.dart';

import '../logic/navigation_cubit.dart';
import 'navigation_element.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          NavigationElements(
            index: NavigationState.home,
            state: NavigationState.home,
            title: 'Home',
            icon: Icons.home,
          ),
          NavigationElements(
            index: NavigationState.settings,
            state: NavigationState.settings,
            title: 'settings',
            icon: Icons.settings,
          ),
          NavigationElements(
            index: NavigationState.profile,
            state: NavigationState.profile,
            title: 'profile',
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
