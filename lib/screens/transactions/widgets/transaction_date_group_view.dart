import 'package:flutter/material.dart';

import '../../../models/ledger.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/formatters/currency_formatter.dart';
import 'ledger_transaction_row.dart';

class TransactionDateGroupView extends StatelessWidget {
  const TransactionDateGroupView({required this.group, super.key});

  final TransactionDateGroup group;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final total = CurrencyFormatter.formatMinorUnits(
      group.dailyNetTotalMinorUnits,
      Localizations.localeOf(context),
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
                  formatLedgerDate(
                    group.date,
                    Localizations.localeOf(context).toString(),
                  ),
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  l.dailyTotal(total),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: totalColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          for (final transaction in group.transactions)
            LedgerTransactionRow(transaction: transaction),
        ],
      ),
    );
  }
}
