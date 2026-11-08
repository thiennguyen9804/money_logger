import 'package:flutter/material.dart';

import '../../../models/transaction.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    required this.isVisible,
    required this.amount,
    required this.onBalanceVisibilityChanged,
    super.key,
  });

  final bool isVisible;
  final String amount;
  final ValueChanged<BalanceVisibilityState> onBalanceVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Card(
      color: Color.alphaBlend(
        colorScheme.primary.withValues(alpha: 0.12),
        colorScheme.surfaceContainerHighest,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 4,
              children: [
                Text('Current Balance', style: theme.textTheme.titleMedium),
                Semantics(
                  button: true,
                  label: isVisible ? 'Hide balance' : 'Show balance',
                  child: IconButton(
                    tooltip: isVisible ? 'Hide balance' : 'Show balance',
                    onPressed: () {
                      onBalanceVisibilityChanged(
                        isVisible
                            ? BalanceVisibilityState.masked
                            : BalanceVisibilityState.visible,
                      );
                    },
                    icon: Icon(
                      isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ExcludeSemantics(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  isVisible ? amount : '••••••',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isVisible)
              Text(
                'Tap the eye icon to show your balance.',
                style: theme.textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
