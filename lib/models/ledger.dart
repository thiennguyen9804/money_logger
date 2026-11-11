import 'package:intl/intl.dart';

import 'transaction.dart';

class DashboardSessionData {
  DashboardSessionData({
    required this.walletSummary,
    required List<Transaction> transactions,
    this.balanceVisibility = BalanceVisibilityState.visible,
  }) : transactions = List.unmodifiable(transactions);

  final WalletSummary walletSummary;
  final List<Transaction> transactions;
  final BalanceVisibilityState balanceVisibility;

  DashboardSessionData copyWith({
    WalletSummary? walletSummary,
    List<Transaction>? transactions,
    BalanceVisibilityState? balanceVisibility,
  }) {
    return DashboardSessionData(
      walletSummary: walletSummary ?? this.walletSummary,
      transactions: transactions ?? this.transactions,
      balanceVisibility: balanceVisibility ?? this.balanceVisibility,
    );
  }
}

class LedgerMonth {
  const LedgerMonth({required this.year, required this.month})
    : assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');

  final int year;
  final int month;

  bool matches(DateTime date) => date.year == year && date.month == month;

  @override
  bool operator ==(Object other) {
    return other is LedgerMonth && other.year == year && other.month == month;
  }

  @override
  int get hashCode => Object.hash(year, month);
}

class TransactionDateGroup {
  TransactionDateGroup({
    required this.date,
    required List<Transaction> transactions,
    required this.dailyNetTotalMinorUnits,
  }) : transactions = List.unmodifiable(transactions);

  final DateTime date;
  final List<Transaction> transactions;
  final int dailyNetTotalMinorUnits;
}

List<LedgerMonth> deriveLedgerMonths(List<Transaction> transactions) {
  final months = <LedgerMonth>{
    for (final transaction in transactions)
      LedgerMonth(
        year: transaction.createdAt.toLocal().year,
        month: transaction.createdAt.toLocal().month,
      ),
  }.toList()..sort(_compareLedgerMonths);

  if (months.isEmpty) {
    final now = DateTime.now();
    return [LedgerMonth(year: now.year, month: now.month)];
  }

  return List.unmodifiable(months);
}

int _compareLedgerMonths(LedgerMonth left, LedgerMonth right) {
  final yearOrder = left.year.compareTo(right.year);
  return yearOrder == 0 ? left.month.compareTo(right.month) : yearOrder;
}

LedgerMonth latestLedgerMonth(List<LedgerMonth> months) {
  return months.reduce(
    (latest, month) =>
        _compareLedgerMonths(latest, month) <= 0 ? month : latest,
  );
}

List<TransactionDateGroup> deriveTransactionDateGroups(
  List<Transaction> transactions,
) {
  final grouped = <DateTime, List<Transaction>>{};
  for (final transaction in transactions) {
    final localDate = transaction.createdAt.toLocal();
    final date = DateTime(localDate.year, localDate.month, localDate.day);
    grouped.putIfAbsent(date, () => []).add(transaction);
  }

  final groups = grouped.entries.map((entry) {
    final sortedTransactions = List<Transaction>.from(entry.value)
      ..sort(_compareTransactions);
    final dailyNetTotal = sortedTransactions.fold<int>(
      0,
      (total, transaction) =>
          total +
          (transaction.type == TransactionType.income
              ? transaction.amountMinorUnits
              : -transaction.amountMinorUnits),
    );
    return TransactionDateGroup(
      date: entry.key,
      transactions: sortedTransactions,
      dailyNetTotalMinorUnits: dailyNetTotal,
    );
  }).toList()..sort((left, right) => right.date.compareTo(left.date));

  return List.unmodifiable(groups);
}

int _compareTransactions(Transaction left, Transaction right) {
  final dateOrder = right.createdAt.compareTo(left.createdAt);
  if (dateOrder != 0) {
    return dateOrder;
  }
  final sequenceOrder = right.sequence.compareTo(left.sequence);
  if (sequenceOrder != 0) {
    return sequenceOrder;
  }
  return right.id.compareTo(left.id);
}

List<Transaction> filterTransactionsForMonth(
  List<Transaction> transactions,
  LedgerMonth month,
) {
  return List.unmodifiable(
    transactions.where((transaction) {
      return month.matches(transaction.createdAt.toLocal());
    }),
  );
}

List<Transaction> deriveRecentTransactions(List<Transaction> transactions) {
  final sortedTransactions = List<Transaction>.from(transactions)
    ..sort((left, right) {
      final dateOrder = right.createdAt.compareTo(left.createdAt);
      if (dateOrder != 0) {
        return dateOrder;
      }
      final sequenceOrder = right.sequence.compareTo(left.sequence);
      if (sequenceOrder != 0) {
        return sequenceOrder;
      }
      return right.id.compareTo(left.id);
    });
  return List.unmodifiable(sortedTransactions.take(3));
}

String formatLedgerMonth(LedgerMonth month, [String locale = 'en_US']) {
  return DateFormat.yMMMM(locale).format(DateTime(month.year, month.month));
}

String formatLedgerDate(DateTime date, [String locale = 'en_US']) {
  return DateFormat.yMMMd(locale).format(date);
}

String formatTransactionDate(DateTime date, [String locale = 'en_US']) {
  return DateFormat.yMMMd(locale).format(date);
}
