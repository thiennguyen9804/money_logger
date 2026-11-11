import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

class AppDestination {
  const AppDestination({
    required this.keyName,
    required this.route,
    required this.icon,
  });
  final String keyName;
  final String route;
  final IconData icon;
  String label(AppLocalizations l) => switch (keyName) {
    'dashboard' => l.navDashboard,
    'transactions' => l.navTransactions,
    'add-transaction' => l.navAddTransaction,
    'budgets' => l.navBudgets,
    _ => l.navProfile,
  };
  String purpose(AppLocalizations l) => switch (keyName) {
    'dashboard' => l.purposeDashboard,
    'transactions' => l.purposeTransactions,
    'add-transaction' => l.purposeAddTransaction,
    'budgets' => l.purposeBudgets,
    _ => l.purposeProfile,
  };
}

const appDestinations = <AppDestination>[
  AppDestination(
    keyName: 'dashboard',
    route: '/dashboard',
    icon: Icons.dashboard_outlined,
  ),
  AppDestination(
    keyName: 'transactions',
    route: '/transactions',
    icon: Icons.receipt_long_outlined,
  ),
  AppDestination(
    keyName: 'add-transaction',
    route: '/add-transaction',
    icon: Icons.add_circle_outline,
  ),
  AppDestination(
    keyName: 'budgets',
    route: '/budgets',
    icon: Icons.account_balance_wallet_outlined,
  ),
  AppDestination(
    keyName: 'profile',
    route: '/profile',
    icon: Icons.person_outline,
  ),
];
