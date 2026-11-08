import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ledger.dart';
import '../../models/transaction.dart';
import 'ledger_event.dart';
import 'ledger_state.dart';

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  LedgerBloc(List<Transaction> initialTransactions)
    : super(_deriveState(initialTransactions, null)) {
    on<LedgerRefreshed>((event, emit) {
      emit(_deriveState(event.transactions, state.selectedMonth));
    });
    on<LedgerMonthSelected>((event, emit) {
      emit(
        LedgerState(
          visibleMonths: state.visibleMonths,
          selectedMonth: event.month,
          groupedTransactions: state.groupedTransactions,
        ),
      );
    });
  }

  static LedgerState _deriveState(
    List<Transaction> transactions,
    LedgerMonth? selectedMonth,
  ) {
    final visibleMonths = deriveLedgerMonths(transactions);
    final effectiveMonth = selectedMonth ?? latestLedgerMonth(visibleMonths);
    final filtered = filterTransactionsForMonth(transactions, effectiveMonth);
    return LedgerState(
      visibleMonths: visibleMonths,
      selectedMonth: effectiveMonth,
      groupedTransactions: deriveTransactionDateGroups(filtered),
    );
  }
}
