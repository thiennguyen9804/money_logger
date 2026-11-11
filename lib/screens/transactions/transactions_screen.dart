import 'package:flutter/material.dart';

import '../../models/ledger.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/formatters/currency_formatter.dart';
import '../../models/transaction.dart';
import '../shell/destination_view_state.dart';
import 'widgets/ledger_month_selector.dart';
import 'widgets/transaction_date_group_view.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    required this.viewState,
    required this.dashboardSession,
    required this.onBalanceVisibilityChanged,
    super.key,
  });

  final DestinationViewState viewState;
  final DashboardSessionData dashboardSession;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late List<LedgerMonth> _months;
  late LedgerMonth _selectedMonth;

  @override
  void initState() {
    super.initState();
    _syncMonthState(selectLatest: true);
  }

  @override
  void didUpdateWidget(covariant TransactionsScreen oldWidget) {
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
    final l = AppLocalizations.of(context)!;
    final wallet = widget.dashboardSession.walletSummary;
    final isBalanceVisible =
        widget.dashboardSession.balanceVisibility ==
        BalanceVisibilityState.visible;
    final balanceText = isBalanceVisible
        ? CurrencyFormatter.formatMinorUnits(
            wallet.amountMinorUnits,
            Localizations.localeOf(context),
          )
        : '••••••';
    final filteredTransactions = filterTransactionsForMonth(
      widget.dashboardSession.transactions,
      _selectedMonth,
    );
    final groups = deriveTransactionDateGroups(filteredTransactions);

    return Scaffold(
      appBar: AppBar(title: Text(l.transactions)),
      body: Column(
        children: [
          Semantics(
            container: true,
            label: isBalanceVisible
                ? '${l.currentBalance}. $balanceText.'
                : '${l.currentBalance}. ${l.balanceHidden}.',
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
                          l.currentBalance,
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
                    label: isBalanceVisible ? l.hideBalance : l.showBalance,
                    child: IconButton(
                      tooltip: isBalanceVisible ? l.hideBalance : l.showBalance,
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
          LedgerMonthSelector(
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
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        l.noMonthTransactions,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  for (final group in groups)
                    TransactionDateGroupView(group: group),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
