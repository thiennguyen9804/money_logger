import 'package:flutter/material.dart';

import '../../dashboard/dashboard_screen.dart';
import '../../../models/ledger.dart';
import '../../../models/transaction.dart';
import '../../transactions/transactions_screen.dart';
import '../app_destination.dart';
import '../destination_view_state.dart';
import 'theme_controls.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({
    required this.destination,
    required this.viewState,
    required this.dashboardSession,
    required this.onDestinationSelected,
    required this.onBalanceVisibilityChanged,
    super.key,
  });

  final AppDestination destination;
  final DestinationViewState viewState;
  final DashboardSessionData dashboardSession;
  final ValueChanged<int> onDestinationSelected;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    if (destination.keyName == 'dashboard') {
      return DashboardScreen(
        viewState: viewState,
        dashboardSession: dashboardSession,
        onDestinationSelected: onDestinationSelected,
        onBalanceVisibilityChanged: onBalanceVisibilityChanged,
      );
    }
    if (destination.keyName == 'transactions') {
      return TransactionsScreen(
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
          if (destination.keyName == 'profile') const ThemeControls(),
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
