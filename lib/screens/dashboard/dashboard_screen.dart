import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../models/ledger.dart';
import '../../models/transaction.dart';
import '../../shared/formatters/currency_formatter.dart';
import '../shell/destination_view_state.dart';
import 'widgets/recent_transaction_row.dart';
import 'widgets/wallet_balance_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    required this.viewState,
    required this.dashboardSession,
    required this.onDestinationSelected,
    required this.onBalanceVisibilityChanged,
    super.key,
  });
  final DestinationViewState viewState;
  final DashboardSessionData dashboardSession;
  final ValueChanged<int> onDestinationSelected;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final wallet = dashboardSession.walletSummary;
    final visible =
        dashboardSession.balanceVisibility == BalanceVisibilityState.visible;
    final amount = CurrencyFormatter.formatMinorUnits(
      wallet.amountMinorUnits,
      Localizations.localeOf(context),
    );
    final label = visible ? amount : l.balanceHidden;
    final recent = deriveRecentTransactions(dashboardSession.transactions);
    return Scaffold(
      appBar: AppBar(title: Text(l.dashboard)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final padding = constraints.maxWidth < 420 ? 16.0 : 24.0;
          return ListView(
            key: const PageStorageKey<String>('dashboard'),
            controller: viewState.scrollController,
            padding: EdgeInsets.all(padding),
            children: [
              Text(
                l.dashboard,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              Semantics(
                container: true,
                label: '${l.currentBalance}. $label.',
                child: WalletBalanceCard(
                  isVisible: visible,
                  amount: amount,
                  onBalanceVisibilityChanged: onBalanceVisibilityChanged,
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 4,
                children: [
                  Text(
                    l.recentTransactions,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => onDestinationSelected(1),
                    child: Text(l.viewAll),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (recent.isEmpty)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: Text(l.noTransactions),
                    subtitle: Text(l.recentActivityEmpty),
                  ),
                )
              else
                for (final transaction in recent)
                  RecentTransactionRow(transaction: transaction),
            ],
          );
        },
      ),
    );
  }
}
