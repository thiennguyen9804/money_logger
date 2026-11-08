import 'package:flutter/material.dart';

import '../../models/ledger.dart';
import '../../models/transaction.dart';
import '../shell/destination_view_state.dart';
import 'widgets/wallet_balance_card.dart';
import 'widgets/recent_transaction_row.dart';

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
                child: WalletBalanceCard(
                  isVisible: isVisible,
                  amount: formattedAmount,
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
                  RecentTransactionRow(
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
