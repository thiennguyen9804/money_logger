import 'package:equatable/equatable.dart';

import '../../models/ledger.dart';

class LedgerState extends Equatable {
  const LedgerState({
    required this.visibleMonths,
    required this.selectedMonth,
    required this.groupedTransactions,
  });

  final List<LedgerMonth> visibleMonths;
  final LedgerMonth? selectedMonth;
  final List<TransactionDateGroup> groupedTransactions;

  @override
  List<Object?> get props => [
    visibleMonths,
    selectedMonth,
    groupedTransactions,
  ];
}
