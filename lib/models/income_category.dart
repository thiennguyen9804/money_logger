import 'package:flutter/material.dart';

import 'category.dart';
import 'transaction_type.dart';

/// Predefined income categories for tracking incoming transactions.
///
/// There are exactly 6 predefined income categories with English-only labels
/// and specified Material Icons. These categories cannot be modified or extended
/// in this version (static category list).
class IncomeCategory extends Category {
  const IncomeCategory({
    required super.id,
    required super.label,
    required super.icon,
  }) : super(type: TransactionType.income);

  // Static list of all 6 predefined income categories
  static final List<IncomeCategory> values = <IncomeCategory>[
    transferIn,
    salary,
    otherIncome,
    giftsReceived,
    borrowing,
    debtCollection,
  ];

  // Individual category instances
  static final transferIn = IncomeCategory(
    id: 'income-transfer-in',
    label: 'Transfer In',
    icon: Icons.compare_arrows,
  );

  static final salary = IncomeCategory(
    id: 'income-salary',
    label: 'Salary',
    icon: Icons.work,
  );

  static final otherIncome = IncomeCategory(
    id: 'income-other-income',
    label: 'Other Income',
    icon: Icons.category,
  );

  static final giftsReceived = IncomeCategory(
    id: 'income-gifts-received',
    label: 'Gifts Received',
    icon: Icons.redeem,
  );

  static final borrowing = IncomeCategory(
    id: 'income-borrowing',
    label: 'Borrowing',
    icon: Icons.money,
  );

  static final debtCollection = IncomeCategory(
    id: 'income-debt-collection',
    label: 'Debt Collection',
    icon: Icons.credit_card,
  );
}
