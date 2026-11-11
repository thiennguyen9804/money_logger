import 'package:flutter/material.dart';

import '../../../models/transaction.dart';
import '../../../shared/widgets/transaction_list_item.dart';

class LedgerTransactionRow extends StatelessWidget {
  const LedgerTransactionRow({required this.transaction, super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return TransactionListItem(
      transaction: transaction,

      secondaryText: transaction.category.label,
    );
  }
}
