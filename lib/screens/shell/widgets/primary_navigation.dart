import 'package:flutter/material.dart';

import '../app_destination.dart';
import 'navigation_item.dart';

class PrimaryNavigation extends StatelessWidget {
  const PrimaryNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              for (var index = 0; index < appDestinations.length; index++)
                Expanded(
                  child: NavigationItem(
                    destination: appDestinations[index],
                    index: index,
                    selected: index == selectedIndex,
                    prominent: index == 2,
                    onPressed: onDestinationSelected,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
