import 'package:flutter/material.dart';

import '../../models/ledger.dart';
import '../../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    required this.transaction,
    required this.currencySymbol,
    required this.secondaryText,
    super.key,
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
