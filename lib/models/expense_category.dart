import 'package:flutter/material.dart';

import 'category.dart';
import 'transaction_type.dart';

/// Predefined expense categories for tracking outgoing transactions.
///
/// There are exactly 18 predefined expense categories with English-only labels
/// and specified Material Icons. These categories cannot be modified or extended
/// in this version (static category list).
class ExpenseCategory extends Category {
  const ExpenseCategory({
    required super.id,
    required super.label,
    required super.icon,
    super.iconAssetPath,
  }) : super(type: TransactionType.expense);

  // Static list of all 18 predefined expense categories
  static final List<ExpenseCategory> values = <ExpenseCategory>[
    fuel,
    transportation,
    foodAndBeverage,
    rent,
    lending,
    debtRepayment,
    vehicleRepair,
    phoneBills,
    haircut,
    healthcare,
    entertainmentAndLeisure,
    otherExpenses,
    onlineServices,
    shopping,
    transferOut,
    gifts,
    vehicleMaintenance,
    personalCare,
  ];

  // Individual category instances
  static final fuel = ExpenseCategory(
    id: 'expense-fuel',
    label: 'Fuel',
    icon: Icons.local_gas_station,
    iconAssetPath: 'assets/icons/fuel.svg',
  );

  static final transportation = ExpenseCategory(
    id: 'expense-transportation',
    label: 'Transportation',
    icon: Icons.commute,
  );

  static final foodAndBeverage = ExpenseCategory(
    id: 'expense-food-and-beverage',
    label: 'Food & Beverage',
    icon: Icons.restaurant,
  );

  static final rent = ExpenseCategory(
    id: 'expense-rent',
    label: 'Rent',
    icon: Icons.home,
  );

  static final lending = ExpenseCategory(
    id: 'expense-lending',
    label: 'Lending',
    icon: Icons.account_balance_wallet,
  );

  static final debtRepayment = ExpenseCategory(
    id: 'expense-debt-repayment',
    label: 'Debt Repayment',
    icon: Icons.receipt_long,
  );

  static final vehicleRepair = ExpenseCategory(
    id: 'expense-vehicle-repair',
    label: 'Vehicle Repair',
    icon: Icons.car_repair,
  );

  static final phoneBills = ExpenseCategory(
    id: 'expense-phone-bills',
    label: 'Phone Bills',
    icon: Icons.phone_iphone,
  );

  static final haircut = ExpenseCategory(
    id: 'expense-haircut',
    label: 'Haircut',
    icon: Icons.content_cut,
  );

  static final healthcare = ExpenseCategory(
    id: 'expense-healthcare',
    label: 'Healthcare',
    icon: Icons.local_hospital,
  );

  static final entertainmentAndLeisure = ExpenseCategory(
    id: 'expense-entertainment-and-leisure',
    label: 'Entertainment & Leisure',
    icon: Icons.movie,
  );

  static final otherExpenses = ExpenseCategory(
    id: 'expense-other-expenses',
    label: 'Other Expenses',
    icon: Icons.category,
  );

  static final onlineServices = ExpenseCategory(
    id: 'expense-online-services',
    label: 'Online Services',
    icon: Icons.public,
  );

  static final shopping = ExpenseCategory(
    id: 'expense-shopping',
    label: 'Shopping',
    icon: Icons.shopping_bag,
  );

  static final transferOut = ExpenseCategory(
    id: 'expense-transfer-out',
    label: 'Transfer Out',
    icon: Icons.compare_arrows,
  );

  static final gifts = ExpenseCategory(
    id: 'expense-gifts',
    label: 'Gifts',
    icon: Icons.redeem,
  );

  static final vehicleMaintenance = ExpenseCategory(
    id: 'expense-vehicle-maintenance',
    label: 'Vehicle Maintenance',
    icon: Icons.build,
  );

  static final personalCare = ExpenseCategory(
    id: 'expense-personal-care',
    label: 'Personal Care',
    icon: Icons.face,
  );
}
