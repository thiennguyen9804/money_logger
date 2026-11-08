import 'package:flutter/material.dart';

import '../../../models/transaction.dart';
import '../../../shared/widgets/transaction_list_item.dart';

class LedgerTransactionRow extends StatelessWidget {
  const LedgerTransactionRow({
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
      secondaryText: transaction.category.label,
    );
  }
}
