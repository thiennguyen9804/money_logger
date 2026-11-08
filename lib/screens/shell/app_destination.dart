import 'package:flutter/material.dart';

class AppDestination {
  const AppDestination({
    required this.keyName,
    required this.label,
    required this.route,
    required this.purpose,
    required this.icon,
  });

  final String keyName;
  final String label;
  final String route;
  final String purpose;
  final IconData icon;
}

const appDestinations = <AppDestination>[
  AppDestination(
    keyName: 'dashboard',
    label: 'Dashboard',
    route: '/dashboard',
    purpose: 'Financial summary and recent activity',
    icon: Icons.dashboard_outlined,
  ),
  AppDestination(
    keyName: 'transactions',
    label: 'Transactions',
    route: '/transactions',
    purpose: 'Monthly income and expense history',
    icon: Icons.receipt_long_outlined,
  ),
  AppDestination(
    keyName: 'add-transaction',
    label: 'Add Transaction',
    route: '/add-transaction',
    purpose: 'Primary income or expense entry point',
    icon: Icons.add_circle_outline,
  ),
  AppDestination(
    keyName: 'budgets',
    label: 'Budgets',
    route: '/budgets',
    purpose: 'Spending limits and category budgets',
    icon: Icons.account_balance_wallet_outlined,
  ),
  AppDestination(
    keyName: 'profile',
    label: 'Profile',
    route: '/profile',
    purpose: 'Account, preferences, security, and theme settings',
    icon: Icons.person_outline,
  ),
];
