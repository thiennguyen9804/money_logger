import 'package:flutter/material.dart';

import '../../../models/ledger.dart';
import '../../../models/transaction.dart';
import '../../../shared/widgets/transaction_list_item.dart';

class RecentTransactionRow extends StatelessWidget {
  const RecentTransactionRow({
    required this.transaction,
    required this.currencySymbol,
    super.key,
  });

  final Transaction transaction;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return TransactionListItem(
      transaction: transaction,
      currencySymbol: currencySymbol,
      secondaryText: formatTransactionDate(transaction.createdAt),
    );
  }
}
