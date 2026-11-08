import 'package:flutter/material.dart';

import '../../models/transaction.dart';

class TypeSegmentedButton extends StatelessWidget {
  const TypeSegmentedButton({
    required this.selectedType,
    required this.onSelected,
    super.key,
  });

  final TransactionType selectedType;
  final ValueChanged<TransactionType> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerHighest,
      child: SegmentedButton<TransactionType>(
        segments: const [
          ButtonSegment<TransactionType>(
            value: TransactionType.expense,
            icon: Icon(Icons.arrow_upward),
            label: Text('Expense'),
          ),
          ButtonSegment<TransactionType>(
            value: TransactionType.income,
            icon: Icon(Icons.arrow_downward),
            label: Text('Income'),
          ),
        ],
        selected: {selectedType},
        onSelectionChanged: (Set<TransactionType> newSelection) {
          if (newSelection.isNotEmpty) {
            onSelected(newSelection.first);
          }
        },
        style: SegmentedButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainerHighest,
          selectedBackgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onSurfaceVariant,
          selectedForegroundColor: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
