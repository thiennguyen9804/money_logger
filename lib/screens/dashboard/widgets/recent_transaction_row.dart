import 'package:flutter/material.dart';

import '../../../models/ledger.dart';
import '../../../models/transaction.dart';
import '../../../shared/widgets/transaction_list_item.dart';

class RecentTransactionRow extends StatelessWidget {
  const RecentTransactionRow({required this.transaction, super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return TransactionListItem(
      transaction: transaction,

      secondaryText: formatTransactionDate(
        transaction.createdAt,
        Localizations.localeOf(context).toString(),
      ),
    );
  }
}
