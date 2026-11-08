import 'package:equatable/equatable.dart';

import '../../models/ledger.dart';
import '../../models/transaction.dart';

abstract class LedgerEvent extends Equatable {
  const LedgerEvent();

  @override
  List<Object?> get props => [];
}

/// Refreshes the ledger with the full, unfiltered list of transactions.
class LedgerRefreshed extends LedgerEvent {
  const LedgerRefreshed(this.transactions);

  final List<Transaction> transactions;

  @override
  List<Object?> get props => [transactions];
}

/// Narrows the ledger view down to a single calendar month.
class LedgerMonthSelected extends LedgerEvent {
  const LedgerMonthSelected(this.month);

  final LedgerMonth month;

  @override
  List<Object?> get props => [month];
}
