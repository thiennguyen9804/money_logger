import 'package:flutter/material.dart';

import 'category.dart';
import 'transaction_type.dart';

export 'category.dart';
export 'transaction_type.dart';

enum BalanceVisibilityState { visible, masked }

class WalletSummary {
  const WalletSummary({
    required this.amountMinorUnits,
    required this.currencyCode,
    required this.currencySymbol,
  });

  final int amountMinorUnits;
  final String currencyCode;
  final String currencySymbol;
}

/// Legacy TransactionCategory for backwards compatibility.
///
/// New code should use the Category class hierarchy (ExpenseCategory, IncomeCategory)
/// from category_list.dart. This class is maintained for existing code compatibility.
///
/// Note: The color field is deprecated. Use ThemeData.colorScheme for theme-aware colors.
@Deprecated(
  'Use ExpenseCategory or IncomeCategory from category_list.dart instead',
)
class TransactionCategory {
  const TransactionCategory({
    required this.label,
    required this.icon,
    required this.color,
    required this.type,
  });

  final String label;
  final IconData icon;
  final Color color;
  final TransactionType type;
}

class Transaction {
  Transaction({
    required this.id,
    required this.sequence,
    required this.category,
    required this.description,
    required this.amountMinorUnits,
    required this.type,
    required this.createdAt,
  }) : assert(id != '', 'Transaction id is required'),
       assert(description != '', 'Transaction description is required'),
       assert(amountMinorUnits >= 0, 'Transaction amount must be absolute');

  final String id;
  final int sequence;
  final Category category;
  final String description;
  final int amountMinorUnits;
  final TransactionType type;
  final DateTime createdAt;
}

/// TransactionDraft represents an in-progress transaction being composed by the user.
///
/// This class is used in the Add Transaction flow and maintains the draft state.
/// Validation rules:
/// - If category is set, type must match category.type
/// - If type is set, category must be compatible or null
/// - Amount text must be parseable to a valid positive number
/// - Description max length: 255 characters
class TransactionDraft {
  TransactionDraft({Category? category, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  String amountText = '';
  TransactionType type = TransactionType.expense;
  Category? category;
  DateTime createdAt;
  String? eventContext;
  bool isMoreDetailsExpanded = false;

  /// Validates that the draft has a valid type-category pairing.
  ///
  /// Returns true if valid, false if there's a mismatch.
  bool get isTypeCategoryValid {
    if (category == null) return true;
    return category!.type == type;
  }
}

const transactionEvents = <String>[
  'No event',
  'Holiday spending',
  'Home renovation',
  'Birthday celebration',
];

int? parsePositiveMinorUnits(String rawAmount) {
  final normalized = rawAmount.trim().replaceAll(',', '');
  if (normalized.isEmpty ||
      !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(normalized)) {
    return null;
  }

  final parts = normalized.split('.');
  final wholeUnits = int.tryParse(parts.first);
  if (wholeUnits == null) {
    return null;
  }
  final fraction = parts.length == 1 ? '00' : parts[1].padRight(2, '0');
  final minorUnits = wholeUnits * 100 + int.parse(fraction);
  return minorUnits > 0 ? minorUnits : null;
}
