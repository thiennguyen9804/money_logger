import 'package:flutter/material.dart';

enum TransactionType { income, expense }

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
  final TransactionCategory category;
  final String description;
  final int amountMinorUnits;
  final TransactionType type;
  final DateTime createdAt;
}

class TransactionDraft {
  TransactionDraft({this.category, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  String amountText = '';
  TransactionType type = TransactionType.expense;
  TransactionCategory? category;
  DateTime createdAt;
  String? eventContext;
  bool isMoreDetailsExpanded = false;
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
