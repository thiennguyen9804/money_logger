import 'package:flutter/material.dart';

import '../../../models/ledger.dart';

class LedgerMonthSelector extends StatelessWidget {
  const LedgerMonthSelector({
    required this.months,
    required this.selectedMonth,
    required this.onMonthSelected,
    super.key,
  });

  final List<LedgerMonth> months;
  final LedgerMonth selectedMonth;
  final ValueChanged<LedgerMonth> onMonthSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 72,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final month = months[index];
          final selected = month == selectedMonth;
          return Semantics(
            button: true,
            selected: selected,
            label: formatLedgerMonth(
              month,
              Localizations.localeOf(context).toString(),
            ),
            child: ChoiceChip(
              label: Text(
                formatLedgerMonth(
                  month,
                  Localizations.localeOf(context).toString(),
                ),
              ),
              selected: selected,
              onSelected: (_) => onMonthSelected(month),
              selectedColor: colorScheme.primaryContainer,
              labelStyle: TextStyle(
                color: selected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
                fontWeight: selected ? FontWeight.bold : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
