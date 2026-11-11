import 'package:flutter/material.dart';

import '../add_transaction/add_transaction_screen.dart';
import '../add_transaction/routes/slide_up_route.dart';
import '../../models/category_list.dart';
import '../../models/ledger.dart';
import '../../models/transaction.dart';
import 'app_destination.dart';
import 'destination_view_state.dart';
import 'widgets/destination_view.dart';
import 'widgets/primary_navigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  late DashboardSessionData _dashboardSession;

  @override
  void initState() {
    super.initState();
    _dashboardSession = DashboardSessionData(
      walletSummary: const WalletSummary(amountMinorUnits: 245075),
      transactions: [
        Transaction(
          id: 'coffee-shop',
          sequence: 4,
          category: ExpenseCategory.foodAndBeverage,
          description: 'Corner Coffee Shop',
          amountMinorUnits: 675,
          type: TransactionType.expense,
          createdAt: DateTime(2026, 11, 6, 8, 30),
        ),
        Transaction(
          id: 'salary',
          sequence: 3,
          category: IncomeCategory.salary,
          description: 'Monthly Salary',
          amountMinorUnits: 320000,
          type: TransactionType.income,
          createdAt: DateTime(2026, 11, 5, 9),
        ),
        Transaction(
          id: 'electricity',
          sequence: 2,
          category: ExpenseCategory.onlineServices,
          description: 'Electricity Bill',
          amountMinorUnits: 12500,
          type: TransactionType.expense,
          createdAt: DateTime(2026, 11, 4, 18),
        ),
        Transaction(
          id: 'groceries',
          sequence: 1,
          category: ExpenseCategory.shopping,
          description: 'Weekly Groceries',
          amountMinorUnits: 8420,
          type: TransactionType.expense,
          createdAt: DateTime(2026, 11, 3, 12),
        ),
        Transaction(
          id: 'internet',
          sequence: 5,
          category: ExpenseCategory.onlineServices,
          description: 'Home Internet',
          amountMinorUnits: 4999,
          type: TransactionType.expense,
          createdAt: DateTime(2026, 10, 28, 14),
        ),
        Transaction(
          id: 'freelance',
          sequence: 6,
          category: IncomeCategory.otherIncome,
          description: 'Freelance Payment',
          amountMinorUnits: 85000,
          type: TransactionType.income,
          createdAt: DateTime(2026, 10, 21, 10),
        ),
      ],
    );
  }

  final Map<String, DestinationViewState> _viewStates = {
    for (final destination in appDestinations)
      destination.keyName: DestinationViewState(
        destinationKey: destination.keyName,
      ),
  };

  @override
  void dispose() {
    for (final viewState in _viewStates.values) {
      viewState.dispose();
    }
    super.dispose();
  }

  void _updateDashboardSession(DashboardSessionData newSession) {
    setState(() {
      _dashboardSession = newSession;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          for (final destination in appDestinations)
            DestinationView(
              destination: destination,
              viewState: _viewStates[destination.keyName]!,
              dashboardSession: _dashboardSession,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              onBalanceVisibilityChanged: (BalanceVisibilityState visibility) {
                _updateDashboardSession(
                  _dashboardSession.copyWith(balanceVisibility: visibility),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: PrimaryNavigation(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 2) {
            _showAddTransactionPage();
            return;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Future<void> _showAddTransactionPage() async {
    final previousIndex = _selectedIndex;
    final draft = await Navigator.of(context).push<TransactionDraft>(
      SlideUpRoute(builder: (context) => const AddTransactionScreen()),
    );

    if (!mounted || draft == null) {
      return;
    }

    final amountMinorUnits = parsePositiveMinorUnits(
      draft.amountText,
      Localizations.localeOf(context),
    );
    if (amountMinorUnits == null || draft.category == null) {
      return;
    }

    final transaction = Transaction(
      id: 'transaction-${DateTime.now().microsecondsSinceEpoch}',
      sequence: _dashboardSession.transactions.length + 1,
      category: draft.category!,
      description: draft.eventContext ?? draft.category!.label,
      amountMinorUnits: amountMinorUnits,
      type: draft.type,
      createdAt: draft.createdAt,
    );
    _updateDashboardSession(
      _dashboardSession.copyWith(
        transactions: [..._dashboardSession.transactions, transaction],
      ),
    );
    setState(() {
      _selectedIndex = previousIndex;
    });
  }
}
