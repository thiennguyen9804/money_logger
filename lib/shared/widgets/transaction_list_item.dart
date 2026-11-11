import 'package:flutter/material.dart';

import '../formatters/currency_formatter.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/transaction.dart';
import 'category_icon.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    required this.transaction,

    required this.secondaryText,
    super.key,
  });

  final Transaction transaction;

  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;
    final amountColor = transaction.amountMinorUnits == 0
        ? colorScheme.onSurfaceVariant
        : transaction.type == TransactionType.income
        ? colorScheme.primary
        : colorScheme.error;
    final amount = CurrencyFormatter.formatMinorUnits(
      transaction.amountMinorUnits,
      Localizations.localeOf(context),
    );
    final typeLabel = transaction.amountMinorUnits == 0
        ? l.neutral
        : transaction.type == TransactionType.income
        ? l.income
        : l.expense;
    return Semantics(
      label: '${transaction.description}. $typeLabel. $amount.',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CategoryIcon(
                icon: transaction.category.icon,
                iconAssetPath: transaction.category.iconAssetPath,
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
