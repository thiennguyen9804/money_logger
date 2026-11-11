import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Displays a category icon in a consistent, theme-aware badge.
class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    required this.icon,
    this.iconAssetPath,
    this.size = 40,
    this.iconSize = 20,
    super.key,
  });

  final IconData icon;
  final String? iconAssetPath;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = colorScheme.onPrimaryContainer;
    final fallback = Icon(icon, size: iconSize, color: iconColor);
    final artwork = iconAssetPath == null
        ? fallback
        : SvgPicture.asset(
            iconAssetPath!,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            errorBuilder: (context, error, stackTrace) => fallback,
          );

    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: artwork,
      ),
    );
  }
}
