import 'package:flutter/material.dart';

import '../app_destination.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    required this.destination,
    required this.index,
    required this.selected,
    required this.prominent,
    required this.onPressed,
    super.key,
  });

  final AppDestination destination;
  final int index;
  final bool selected;
  final bool prominent;
  final ValueChanged<int> onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = selected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: InkWell(
        onTap: () => onPressed(index),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(prominent ? 10 : 6),
                decoration: BoxDecoration(
                  color: prominent
                      ? colorScheme.primary
                      : selected
                      ? colorScheme.secondaryContainer
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  destination.icon,
                  color: prominent ? colorScheme.onPrimary : foregroundColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: selected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
