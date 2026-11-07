import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
  });

  final String label;
  final IconData icon;
  final Color color;
}

const transactionCategories = <TransactionCategory>[
  TransactionCategory(
    label: 'Food',
    icon: Icons.restaurant_outlined,
    color: Colors.orange,
  ),
  TransactionCategory(
    label: 'Groceries',
    icon: Icons.shopping_basket_outlined,
    color: Colors.purple,
  ),
  TransactionCategory(
    label: 'Transport',
    icon: Icons.directions_car_outlined,
    color: Colors.blue,
  ),
  TransactionCategory(
    label: 'Utilities',
    icon: Icons.bolt_outlined,
    color: Colors.teal,
  ),
  TransactionCategory(
    label: 'Income',
    icon: Icons.payments_outlined,
    color: Colors.green,
  ),
];

const expenseTransactionCategories = <TransactionCategory>[
  TransactionCategory(
    label: 'Food',
    icon: Icons.restaurant_outlined,
    color: Colors.orange,
  ),
  TransactionCategory(
    label: 'Groceries',
    icon: Icons.shopping_basket_outlined,
    color: Colors.purple,
  ),
  TransactionCategory(
    label: 'Transport',
    icon: Icons.directions_car_outlined,
    color: Colors.blue,
  ),
  TransactionCategory(
    label: 'Utilities',
    icon: Icons.bolt_outlined,
    color: Colors.teal,
  ),
];

const incomeTransactionCategories = <TransactionCategory>[
  TransactionCategory(
    label: 'Income',
    icon: Icons.payments_outlined,
    color: Colors.green,
  ),
  TransactionCategory(
    label: 'Freelance',
    icon: Icons.work_outline,
    color: Colors.green,
  ),
  TransactionCategory(
    label: 'Gifts',
    icon: Icons.card_giftcard_outlined,
    color: Colors.lightGreen,
  ),
];

const transactionEvents = <String>[
  'No event',
  'Holiday spending',
  'Home renovation',
  'Birthday celebration',
];

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
       assert(amountMinorUnits >= 0, 'Transaction amount must be absolute') {
    if (amountMinorUnits < 0) {
      throw ArgumentError.value(
        amountMinorUnits,
        'amountMinorUnits',
        'Transaction amount must be absolute',
      );
    }
  }

  final String id;
  final int sequence;
  final TransactionCategory category;
  final String description;
  final int amountMinorUnits;
  final TransactionType type;
  final DateTime createdAt;
}

class DashboardSessionData {
  DashboardSessionData({
    required this.walletSummary,
    required List<Transaction> transactions,
    this.balanceVisibility = BalanceVisibilityState.visible,
  }) : transactions = List.unmodifiable(transactions);

  final WalletSummary walletSummary;
  final List<Transaction> transactions;
  final BalanceVisibilityState balanceVisibility;

  DashboardSessionData copyWith({
    WalletSummary? walletSummary,
    List<Transaction>? transactions,
    BalanceVisibilityState? balanceVisibility,
  }) {
    return DashboardSessionData(
      walletSummary: walletSummary ?? this.walletSummary,
      transactions: transactions ?? this.transactions,
      balanceVisibility: balanceVisibility ?? this.balanceVisibility,
    );
  }
}

String formatMinorCurrency({
  required int amountMinorUnits,
  required String currencySymbol,
}) {
  final sign = amountMinorUnits < 0 ? '-' : '';
  final absoluteAmount = amountMinorUnits.abs();
  final wholePart = absoluteAmount ~/ 100;
  final fractionPart = (absoluteAmount % 100).toString().padLeft(2, '0');
  final wholeDigits = wholePart.toString();
  final groupedWhole = _groupDigits(wholeDigits);

  return '$sign$currencySymbol$groupedWhole.$fractionPart';
}

String _groupDigits(String digits) {
  final firstGroupLength = digits.length % 3 == 0 ? 3 : digits.length % 3;
  final groups = <String>[
    digits.substring(0, firstGroupLength),
    for (var index = firstGroupLength; index < digits.length; index += 3)
      digits.substring(index, index + 3),
  ];
  return groups.join(',');
}

List<Transaction> deriveRecentTransactions(List<Transaction> transactions) {
  final sortedTransactions = List<Transaction>.from(transactions)
    ..sort((left, right) {
      final dateOrder = right.createdAt.compareTo(left.createdAt);
      if (dateOrder != 0) {
        return dateOrder;
      }

      final sequenceOrder = right.sequence.compareTo(left.sequence);
      if (sequenceOrder != 0) {
        return sequenceOrder;
      }

      return right.id.compareTo(left.id);
    });

  return List.unmodifiable(sortedTransactions.take(3));
}

class LedgerMonth {
  const LedgerMonth({required this.year, required this.month})
    : assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');

  final int year;
  final int month;

  bool matches(DateTime date) => date.year == year && date.month == month;

  @override
  bool operator ==(Object other) {
    return other is LedgerMonth && other.year == year && other.month == month;
  }

  @override
  int get hashCode => Object.hash(year, month);
}

class TransactionDateGroup {
  TransactionDateGroup({
    required this.date,
    required List<Transaction> transactions,
    required this.dailyNetTotalMinorUnits,
  }) : transactions = List.unmodifiable(transactions);

  final DateTime date;
  final List<Transaction> transactions;
  final int dailyNetTotalMinorUnits;
}

List<LedgerMonth> deriveLedgerMonths(List<Transaction> transactions) {
  final months = <LedgerMonth>{
    for (final transaction in transactions)
      LedgerMonth(
        year: transaction.createdAt.toLocal().year,
        month: transaction.createdAt.toLocal().month,
      ),
  }.toList()..sort(_compareLedgerMonths);

  if (months.isEmpty) {
    final now = DateTime.now();
    return [LedgerMonth(year: now.year, month: now.month)];
  }

  return List.unmodifiable(months);
}

int _compareLedgerMonths(LedgerMonth left, LedgerMonth right) {
  final yearOrder = left.year.compareTo(right.year);
  return yearOrder == 0 ? left.month.compareTo(right.month) : yearOrder;
}

LedgerMonth latestLedgerMonth(List<LedgerMonth> months) {
  return months.reduce(
    (latest, month) =>
        _compareLedgerMonths(latest, month) <= 0 ? month : latest,
  );
}

List<Transaction> filterTransactionsForMonth(
  List<Transaction> transactions,
  LedgerMonth month,
) {
  return List.unmodifiable(
    transactions.where((transaction) {
      return month.matches(transaction.createdAt.toLocal());
    }),
  );
}

List<TransactionDateGroup> deriveTransactionDateGroups(
  List<Transaction> transactions,
) {
  final grouped = <DateTime, List<Transaction>>{};
  for (final transaction in transactions) {
    final localDate = transaction.createdAt.toLocal();
    final date = DateTime(localDate.year, localDate.month, localDate.day);
    grouped.putIfAbsent(date, () => []).add(transaction);
  }

  final groups = grouped.entries.map((entry) {
    final sortedTransactions = List<Transaction>.from(entry.value)
      ..sort(_compareTransactions);
    final dailyNetTotal = sortedTransactions.fold<int>(
      0,
      (total, transaction) =>
          total +
          (transaction.type == TransactionType.income
              ? transaction.amountMinorUnits
              : -transaction.amountMinorUnits),
    );
    return TransactionDateGroup(
      date: entry.key,
      transactions: sortedTransactions,
      dailyNetTotalMinorUnits: dailyNetTotal,
    );
  }).toList()..sort((left, right) => right.date.compareTo(left.date));

  return List.unmodifiable(groups);
}

int _compareTransactions(Transaction left, Transaction right) {
  final dateOrder = right.createdAt.compareTo(left.createdAt);
  if (dateOrder != 0) {
    return dateOrder;
  }
  final sequenceOrder = right.sequence.compareTo(left.sequence);
  if (sequenceOrder != 0) {
    return sequenceOrder;
  }
  return right.id.compareTo(left.id);
}

String formatLedgerMonth(LedgerMonth month) {
  const monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${monthNames[month.month - 1]} ${month.year}';
}

String formatLedgerDate(DateTime date) {
  const monthNames = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
}

enum ThemeEvent { setLight, setDark, toggle }

class ThemeState {
  const ThemeState({required this.mode});

  final ThemeMode mode;
}

class ThemeBloc {
  ThemeBloc() : _state = const ThemeState(mode: ThemeMode.light);

  final StreamController<ThemeState> _stateController =
      StreamController<ThemeState>.broadcast();
  ThemeState _state;

  ThemeState get state => _state;
  Stream<ThemeState> get stream => _stateController.stream;

  void add(ThemeEvent event) {
    final mode = switch (event) {
      ThemeEvent.setLight => ThemeMode.light,
      ThemeEvent.setDark => ThemeMode.dark,
      ThemeEvent.toggle =>
        _state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    };

    if (mode == _state.mode) {
      return;
    }

    _state = ThemeState(mode: mode);
    _stateController.add(_state);
  }

  void dispose() {
    _stateController.close();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeState>(
      stream: _themeBloc.stream,
      initialData: _themeBloc.state,
      builder: (context, snapshot) {
        final themeState = snapshot.requireData;
        return MaterialApp(
          title: 'Money Logger',
          theme: _lightTheme,
          darkTheme: _darkTheme,
          themeMode: themeState.mode,
          home: AppShell(themeBloc: _themeBloc),
        );
      },
    );
  }
}

final _lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
  useMaterial3: true,
);

final _darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);

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

class DestinationViewState {
  DestinationViewState({required this.destinationKey})
    : scrollController = ScrollController();

  final String destinationKey;
  final ScrollController scrollController;
  String activeViewState = 'default';

  void dispose() {
    scrollController.dispose();
  }
}

class AppShell extends StatefulWidget {
  const AppShell({required this.themeBloc, super.key});

  final ThemeBloc themeBloc;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  DashboardSessionData _dashboardSession = DashboardSessionData(
    walletSummary: const WalletSummary(
      amountMinorUnits: 245075,
      currencyCode: 'USD',
      currencySymbol: r'$',
    ),
    transactions: [
      Transaction(
        id: 'coffee-shop',
        sequence: 4,
        category: TransactionCategory(
          label: 'Food',
          icon: Icons.restaurant_outlined,
          color: Colors.orange,
        ),
        description: 'Corner Coffee Shop',
        amountMinorUnits: 675,
        type: TransactionType.expense,
        createdAt: DateTime(2026, 11, 6, 8, 30),
      ),
      Transaction(
        id: 'salary',
        sequence: 3,
        category: TransactionCategory(
          label: 'Income',
          icon: Icons.work_outline,
          color: Colors.green,
        ),
        description: 'Monthly Salary',
        amountMinorUnits: 320000,
        type: TransactionType.income,
        createdAt: DateTime(2026, 11, 5, 9),
      ),
      Transaction(
        id: 'electricity',
        sequence: 2,
        category: TransactionCategory(
          label: 'Utilities',
          icon: Icons.bolt_outlined,
          color: Colors.blue,
        ),
        description: 'Electricity Bill',
        amountMinorUnits: 12500,
        type: TransactionType.expense,
        createdAt: DateTime(2026, 11, 4, 18),
      ),
      Transaction(
        id: 'groceries',
        sequence: 1,
        category: TransactionCategory(
          label: 'Groceries',
          icon: Icons.shopping_basket_outlined,
          color: Colors.purple,
        ),
        description: 'Weekly Groceries',
        amountMinorUnits: 8420,
        type: TransactionType.expense,
        createdAt: DateTime(2026, 11, 3, 12),
      ),
      Transaction(
        id: 'internet',
        sequence: 5,
        category: TransactionCategory(
          label: 'Utilities',
          icon: Icons.wifi_outlined,
          color: Colors.teal,
        ),
        description: 'Home Internet',
        amountMinorUnits: 4999,
        type: TransactionType.expense,
        createdAt: DateTime(2026, 10, 28, 14),
      ),
      Transaction(
        id: 'freelance',
        sequence: 6,
        category: TransactionCategory(
          label: 'Income',
          icon: Icons.payments_outlined,
          color: Colors.green,
        ),
        description: 'Freelance Payment',
        amountMinorUnits: 85000,
        type: TransactionType.income,
        createdAt: DateTime(2026, 10, 21, 10),
      ),
    ],
  );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          for (final destination in appDestinations)
            _DestinationView(
              destination: destination,
              viewState: _viewStates[destination.keyName]!,
              themeBloc: widget.themeBloc,
              dashboardSession: _dashboardSession,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              onBalanceVisibilityChanged: (visibility) {
                setState(() {
                  _dashboardSession = _dashboardSession.copyWith(
                    balanceVisibility: visibility,
                  );
                });
              },
            ),
        ],
      ),
      bottomNavigationBar: _PrimaryNavigation(
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
      MaterialPageRoute(builder: (context) => const _AddTransactionPage()),
    );

    if (!mounted || draft == null) {
      return;
    }

    final amountMinorUnits = parsePositiveMinorUnits(draft.amountText);
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
    setState(() {
      _dashboardSession = _dashboardSession.copyWith(
        transactions: [..._dashboardSession.transactions, transaction],
      );
      _selectedIndex = previousIndex;
    });
  }
}

class _PrimaryNavigation extends StatelessWidget {
  const _PrimaryNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              for (var index = 0; index < appDestinations.length; index++)
                Expanded(
                  child: _NavigationItem(
                    destination: appDestinations[index],
                    index: index,
                    selected: index == selectedIndex,
                    prominent: index == 2,
                    onPressed: onDestinationSelected,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.destination,
    required this.index,
    required this.selected,
    required this.prominent,
    required this.onPressed,
  });

  final AppDestination destination;
  final int index;
  final bool selected;
  final bool prominent;
  final ValueChanged<int> onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = selected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: InkWell(
        onTap: () => onPressed(index),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(prominent ? 10 : 6),
                decoration: BoxDecoration(
                  color: prominent
                      ? colorScheme.primary
                      : selected
                      ? colorScheme.secondaryContainer
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  destination.icon,
                  color: prominent ? colorScheme.onPrimary : foregroundColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: selected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationView extends StatelessWidget {
  const _DestinationView({
    required this.destination,
    required this.viewState,
    required this.themeBloc,
    required this.dashboardSession,
    required this.onDestinationSelected,
    required this.onBalanceVisibilityChanged,
  });

  final AppDestination destination;
  final DestinationViewState viewState;
  final ThemeBloc themeBloc;
  final DashboardSessionData dashboardSession;
  final ValueChanged<int> onDestinationSelected;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    if (destination.keyName == 'dashboard') {
      return _DashboardView(
        viewState: viewState,
        dashboardSession: dashboardSession,
        onDestinationSelected: onDestinationSelected,
        onBalanceVisibilityChanged: onBalanceVisibilityChanged,
      );
    }
    if (destination.keyName == 'transactions') {
      return _TransactionsView(
        viewState: viewState,
        dashboardSession: dashboardSession,
        onBalanceVisibilityChanged: onBalanceVisibilityChanged,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(destination.label)),
      body: ListView(
        key: PageStorageKey<String>(
          '${destination.keyName}-${dashboardSession.walletSummary.currencyCode}',
        ),
        controller: viewState.scrollController,
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            destination.label,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          Text(
            destination.purpose,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (destination.keyName == 'add-transaction') ...[
            const SizedBox(height: 12),
            const Text(
              'Start a new income or expense entry.',
              style: TextStyle(fontSize: 18),
            ),
          ],
          if (destination.keyName == 'profile')
            _ThemeControls(themeBloc: themeBloc),
          const SizedBox(height: 24),
          for (var index = 1; index <= 8; index++)
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('$index')),
                title: Text('${destination.label} item $index'),
                subtitle: Text(destination.purpose),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddTransactionPage extends StatefulWidget {
  const _AddTransactionPage();

  @override
  State<_AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<_AddTransactionPage> {
  late final TransactionDraft _draft;
  late final TextEditingController _amountController;
  late final FocusNode _amountFocusNode;
  String? _amountError;

  @override
  void initState() {
    super.initState();
    _draft = TransactionDraft();
    _amountController = TextEditingController();
    _amountFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _amountFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _draft.createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_draft.createdAt),
    );
    if (!mounted || time == null) {
      return;
    }
    setState(() {
      _draft.createdAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _save() {
    final amount = parsePositiveMinorUnits(_draft.amountText);
    if (amount == null || _draft.category == null) {
      setState(() {
        _amountError = amount == null
            ? 'Enter an amount greater than zero.'
            : 'Select a category.';
      });
      return;
    }
    Navigator.of(context).pop(_draft);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amountIsValid = parsePositiveMinorUnits(_draft.amountText) != null;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final typeColor = _draft.type == TransactionType.expense
        ? Colors.red.withValues(alpha: 0.18)
        : Colors.lightGreen.withValues(alpha: 0.2);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Transaction'),
        actions: [
          TextButton(
            onPressed: amountIsValid && _draft.category != null ? _save : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Semantics(
        container: true,
        label: 'Add transaction form',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _amountFocusNode.unfocus,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 16),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    autofocus: false,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: '0.00',
                      prefixText: r'$ ',
                      errorText: _amountError,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _draft.amountText = value;
                        _amountError = null;
                      });
                    },
                    onSubmitted: (_) {
                      if (amountIsValid) {
                        _save();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: typeColor,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: SegmentedButton<TransactionType>(
                      segments: const [
                        ButtonSegment(
                          value: TransactionType.expense,
                          label: Text('Expense'),
                          icon: Icon(Icons.arrow_upward),
                        ),
                        ButtonSegment(
                          value: TransactionType.income,
                          label: Text('Income'),
                          icon: Icon(Icons.arrow_downward),
                        ),
                      ],
                      selected: {_draft.type},
                      onSelectionChanged: (selection) {
                        setState(() => _draft.type = selection.first);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      _draft.category?.icon ?? Icons.category_outlined,
                      color: _draft.category?.color,
                    ),
                    title: Text(
                      _draft.category?.label ?? 'Select Category',
                      style: theme.textTheme.titleMedium,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final category = await Navigator.of(context)
                          .push<TransactionCategory>(
                            MaterialPageRoute(
                              builder: (context) => _CategorySelectionPage(
                                selectedCategory: _draft.category,
                              ),
                            ),
                          );
                      if (mounted && category != null) {
                        setState(() => _draft.category = category);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.event_outlined),
                    title: const Text('Date and time'),
                    subtitle: Text(_formatDraftDateTime(_draft.createdAt)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _selectDateTime,
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('More Details'),
                    subtitle: Text(
                      _draft.eventContext == null ||
                              _draft.eventContext == 'No event'
                          ? 'Add an event or campaign'
                          : _draft.eventContext!,
                    ),
                    trailing: Icon(
                      _draft.isMoreDetailsExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                    ),
                    onTap: () {
                      setState(() {
                        _draft.isMoreDetailsExpanded =
                            !_draft.isMoreDetailsExpanded;
                      });
                    },
                  ),
                  if (_draft.isMoreDetailsExpanded)
                    DropdownButtonFormField<String>(
                      initialValue:
                          _draft.eventContext ?? transactionEvents.first,
                      decoration: const InputDecoration(
                        labelText: 'Event or campaign',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (final event in transactionEvents)
                          DropdownMenuItem(value: event, child: Text(event)),
                      ],
                      onChanged: (event) {
                        setState(() => _draft.eventContext = event);
                      },
                    ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: amountIsValid ? _save : null,
                    icon: const Icon(Icons.check),
                    label: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategorySelectionPage extends StatefulWidget {
  const _CategorySelectionPage({this.selectedCategory});

  final TransactionCategory? selectedCategory;

  @override
  State<_CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<_CategorySelectionPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = _tabIndex == 0
        ? expenseTransactionCategories
        : incomeTransactionCategories;

    return DefaultTabController(
      length: 2,
      initialIndex: _tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Category'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Expense'),
              Tab(text: 'Income'),
            ],
            onTap: (index) => setState(() => _tabIndex = index),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: categories.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final category = categories[index];
            final selected = category == widget.selectedCategory;
            return Semantics(
              button: true,
              selected: selected,
              label:
                  '${category.label} category${selected ? ', selected' : ''}',
              child: Card(
                color: selected
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                child: ListTile(
                  leading: Icon(category.icon, color: category.color),
                  title: Text(category.label),
                  trailing: selected ? const Icon(Icons.check) : null,
                  onTap: () => Navigator.of(context).pop(category),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

String _formatDraftDateTime(DateTime dateTime) {
  final local = dateTime.toLocal();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.day}/${local.month}/${local.year} at $hour:$minute';
}

class _TransactionsView extends StatefulWidget {
  const _TransactionsView({
    required this.viewState,
    required this.dashboardSession,
    required this.onBalanceVisibilityChanged,
  });

  final DestinationViewState viewState;
  final DashboardSessionData dashboardSession;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;

  @override
  State<_TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<_TransactionsView> {
  late List<LedgerMonth> _months;
  late LedgerMonth _selectedMonth;

  @override
  void initState() {
    super.initState();
    _syncMonthState(selectLatest: true);
  }

  @override
  void didUpdateWidget(covariant _TransactionsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dashboardSession.transactions !=
        widget.dashboardSession.transactions) {
      _syncMonthState();
    }
  }

  void _syncMonthState({bool selectLatest = false}) {
    _months = deriveLedgerMonths(widget.dashboardSession.transactions);
    if (selectLatest || !_months.any((month) => month == _selectedMonth)) {
      _selectedMonth = latestLedgerMonth(_months);
    }
  }

  void _selectMonth(LedgerMonth month) {
    if (month == _selectedMonth) {
      return;
    }
    setState(() {
      _selectedMonth = month;
    });
    if (widget.viewState.scrollController.hasClients) {
      widget.viewState.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final wallet = widget.dashboardSession.walletSummary;
    final isBalanceVisible =
        widget.dashboardSession.balanceVisibility ==
        BalanceVisibilityState.visible;
    final balanceText = isBalanceVisible
        ? formatMinorCurrency(
            amountMinorUnits: wallet.amountMinorUnits,
            currencySymbol: wallet.currencySymbol,
          )
        : '••••••';
    final filteredTransactions = filterTransactionsForMonth(
      widget.dashboardSession.transactions,
      _selectedMonth,
    );
    final groups = deriveTransactionDateGroups(filteredTransactions);

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Column(
        children: [
          Semantics(
            container: true,
            label: isBalanceVisible
                ? 'Current Balance. $balanceText.'
                : 'Current Balance. Balance hidden.',
            child: Container(
              width: double.infinity,
              color: colorScheme.surfaceContainerHighest,
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Balance',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        ExcludeSemantics(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              balanceText,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: isBalanceVisible ? 'Hide balance' : 'Show balance',
                    child: IconButton(
                      tooltip: isBalanceVisible
                          ? 'Hide balance'
                          : 'Show balance',
                      onPressed: () {
                        widget.onBalanceVisibilityChanged(
                          isBalanceVisible
                              ? BalanceVisibilityState.masked
                              : BalanceVisibilityState.visible,
                        );
                      },
                      icon: Icon(
                        isBalanceVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _LedgerMonthSelector(
            months: _months,
            selectedMonth: _selectedMonth,
            onMonthSelected: _selectMonth,
          ),
          Expanded(
            child: ListView(
              controller: widget.viewState.scrollController,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                if (groups.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No transactions recorded for this month.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  for (final group in groups)
                    _TransactionDateGroupView(
                      group: group,
                      currencySymbol: wallet.currencySymbol,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LedgerMonthSelector extends StatelessWidget {
  const _LedgerMonthSelector({
    required this.months,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  final List<LedgerMonth> months;
  final LedgerMonth selectedMonth;
  final ValueChanged<LedgerMonth> onMonthSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 72,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final month = months[index];
          final selected = month == selectedMonth;
          return Semantics(
            button: true,
            selected: selected,
            label: formatLedgerMonth(month),
            child: ChoiceChip(
              label: Text(formatLedgerMonth(month)),
              selected: selected,
              onSelected: (_) => onMonthSelected(month),
              selectedColor: colorScheme.primaryContainer,
              labelStyle: TextStyle(
                color: selected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
                fontWeight: selected ? FontWeight.bold : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TransactionDateGroupView extends StatelessWidget {
  const _TransactionDateGroupView({
    required this.group,
    required this.currencySymbol,
  });

  final TransactionDateGroup group;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = formatMinorCurrency(
      amountMinorUnits: group.dailyNetTotalMinorUnits,
      currencySymbol: currencySymbol,
    );
    final totalColor = group.dailyNetTotalMinorUnits > 0
        ? colorScheme.primary
        : group.dailyNetTotalMinorUnits < 0
        ? colorScheme.error
        : colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 4,
              children: [
                Text(
                  formatLedgerDate(group.date),
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Daily total: $total',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: totalColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          for (final transaction in group.transactions)
            _LedgerTransactionRow(
              transaction: transaction,
              currencySymbol: currencySymbol,
            ),
        ],
      ),
    );
  }
}

class _LedgerTransactionRow extends StatelessWidget {
  const _LedgerTransactionRow({
    required this.transaction,
    required this.currencySymbol,
  });

  final Transaction transaction;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return _TransactionListItem(
      transaction: transaction,
      currencySymbol: currencySymbol,
      secondaryText: transaction.category.label,
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  const _TransactionListItem({
    required this.transaction,
    required this.currencySymbol,
    required this.secondaryText,
  });

  final Transaction transaction;
  final String currencySymbol;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final amountColor = transaction.amountMinorUnits == 0
        ? colorScheme.onSurfaceVariant
        : transaction.type == TransactionType.income
        ? colorScheme.primary
        : colorScheme.error;
    final amount = formatMinorCurrency(
      amountMinorUnits: transaction.amountMinorUnits,
      currencySymbol: currencySymbol,
    );
    final typeLabel = transaction.amountMinorUnits == 0
        ? 'Neutral'
        : transaction.type == TransactionType.income
        ? 'Income'
        : 'Expense';
    final categoryColor = Color.alphaBlend(
      transaction.category.color.withValues(alpha: 0.75),
      colorScheme.surface,
    );

    return Semantics(
      label: '${transaction.description}. $typeLabel. $amount.',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: categoryColor,
                foregroundColor: colorScheme.onSurface,
                child: Icon(transaction.category.icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      secondaryText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      typeLabel,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: amountColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      amount,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: amountColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView({
    required this.viewState,
    required this.dashboardSession,
    required this.onDestinationSelected,
    required this.onBalanceVisibilityChanged,
  });

  final DestinationViewState viewState;
  final DashboardSessionData dashboardSession;
  final ValueChanged<int> onDestinationSelected;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final wallet = dashboardSession.walletSummary;
    final isVisible =
        dashboardSession.balanceVisibility == BalanceVisibilityState.visible;
    final formattedAmount = formatMinorCurrency(
      amountMinorUnits: wallet.amountMinorUnits,
      currencySymbol: wallet.currencySymbol,
    );
    final amountLabel = isVisible ? formattedAmount : 'Balance hidden';
    final recentTransactions = deriveRecentTransactions(
      dashboardSession.transactions,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 420;
          final horizontalPadding = compact ? 16.0 : 24.0;
          return ListView(
            key: const PageStorageKey<String>('dashboard'),
            controller: viewState.scrollController,
            padding: EdgeInsets.all(horizontalPadding),
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              Semantics(
                container: true,
                label: 'Current Balance. $amountLabel.',
                child: Card(
                  color: Color.alphaBlend(
                    colorScheme.primary.withValues(alpha: 0.12),
                    colorScheme.surfaceContainerHighest,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(compact ? 16.0 : 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 4,
                          children: [
                            Text(
                              'Current Balance',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Semantics(
                              button: true,
                              label: isVisible
                                  ? 'Hide balance'
                                  : 'Show balance',
                              child: IconButton(
                                tooltip: isVisible
                                    ? 'Hide balance'
                                    : 'Show balance',
                                onPressed: () {
                                  onBalanceVisibilityChanged(
                                    isVisible
                                        ? BalanceVisibilityState.masked
                                        : BalanceVisibilityState.visible,
                                  );
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ExcludeSemantics(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isVisible ? formattedAmount : '••••••',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        if (!isVisible)
                          Text(
                            'Tap the eye icon to show your balance.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 4,
                children: [
                  Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => onDestinationSelected(1),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (recentTransactions.isEmpty)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.receipt_long_outlined),
                    title: Text('No transactions yet'),
                    subtitle: Text('Your recent activity will appear here.'),
                  ),
                )
              else
                for (final transaction in recentTransactions)
                  _RecentTransactionRow(
                    transaction: transaction,
                    currencySymbol: wallet.currencySymbol,
                  ),
            ],
          );
        },
      ),
    );
  }
}

class _RecentTransactionRow extends StatelessWidget {
  const _RecentTransactionRow({
    required this.transaction,
    required this.currencySymbol,
  });

  final Transaction transaction;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return _TransactionListItem(
      transaction: transaction,
      currencySymbol: currencySymbol,
      secondaryText: _formatTransactionDate(transaction.createdAt),
    );
  }
}

String _formatTransactionDate(DateTime date) {
  const monthNames = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
}

class _ThemeControls extends StatelessWidget {
  const _ThemeControls({required this.themeBloc});

  final ThemeBloc themeBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeState>(
      stream: themeBloc.stream,
      initialData: themeBloc.state,
      builder: (context, snapshot) {
        final mode = snapshot.requireData.mode;
        return Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark mode'),
                subtitle: Text(mode == ThemeMode.dark ? 'Enabled' : 'Disabled'),
                value: mode == ThemeMode.dark,
                onChanged: (enabled) {
                  themeBloc.add(
                    enabled ? ThemeEvent.setDark : ThemeEvent.setLight,
                  );
                },
              ),
              OverflowBar(
                children: [
                  TextButton(
                    onPressed: () => themeBloc.add(ThemeEvent.setLight),
                    child: const Text('Light'),
                  ),
                  TextButton(
                    onPressed: () => themeBloc.add(ThemeEvent.setDark),
                    child: const Text('Dark'),
                  ),
                  TextButton(
                    onPressed: () => themeBloc.add(ThemeEvent.toggle),
                    child: const Text('Toggle'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
