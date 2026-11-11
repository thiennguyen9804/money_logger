import 'package:flutter/material.dart';

/// Custom slide-up page route builder for the Add Transaction screen.
///
/// This route creates a smooth slide-up animation from the bottom of the screen
/// with a duration of 300ms and easeInOut curve, maintaining full-screen interactivity.
class SlideUpRoute<T> extends PageRouteBuilder<T> {
  SlideUpRoute({required this.builder, super.settings})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Start from bottom
          const end = Offset.zero; // End at center
          const curve = Curves.easeInOut;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );

  final WidgetBuilder builder;
}
