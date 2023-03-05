import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class BookstoreScaffold extends StatelessWidget {
  const BookstoreScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);
    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const BookstoreScaffoldBody(),
        // backgroundColor: const Color.fromARGB(255, 65, 203, 83),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/books/popular');
          if (idx == 1) routeState.go('/authors');
          if (idx == 2) routeState.go('/settings');
        },
        // fixedColor: Colors.green,
        // backgroundColor: const Color.fromARGB(255, 65, 203, 83),
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Offers',
            icon: Icons.local_offer,
          ),
          AdaptiveScaffoldDestination(
            title: 'Profile',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/books')) return 0;
    if (pathTemplate == '/authors') return 1;
    if (pathTemplate == '/settings') return 2;
    return 0;
  }
}
