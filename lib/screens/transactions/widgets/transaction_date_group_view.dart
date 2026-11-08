import 'package:flutter/material.dart';

import '../../../models/ledger.dart';
import 'ledger_transaction_row.dart';

class TransactionDateGroupView extends StatelessWidget {
  const TransactionDateGroupView({
    required this.group,
    required this.currencySymbol,
    super.key,
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
            LedgerTransactionRow(
              transaction: transaction,
              currencySymbol: currencySymbol,
            ),
        ],
      ),
    );
  }
}
