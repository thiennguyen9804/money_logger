import 'package:flutter/material.dart';

import 'transaction_type.dart';

/// Abstract base class representing a transaction category.
///
/// All categories have a unique identifier, display label, icon, and type.
/// Labels must be English-only, non-empty, and max 50 characters.
/// Icons must be valid Material Icons.
abstract class Category {
  const Category({
    required this.id,
    required this.label,
    required this.icon,
    required this.type,
  });

  /// Unique identifier for this category.
  final String id;

  /// Display label for this category (English-only).
  final String label;

  /// Material Icon to display for this category.
  final IconData icon;

  /// The transaction type this category belongs to.
  final TransactionType type;
}
