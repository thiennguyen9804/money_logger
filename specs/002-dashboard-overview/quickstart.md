# Quickstart: Dashboard Overview

## Prerequisites

- Flutter and Dart versions compatible with the repository's `pubspec.yaml`.
- A connected mobile device/emulator or a browser target.

## Static validation

From the repository root, run:

```powershell
dart format lib
flutter analyze
```

Expected result: formatting completes and static analysis reports no errors. Do not
add or run automated tests; project governance requires manual validation.

## Manual runtime validation

Launch the application and open Dashboard. Verify:

1. The balance card shows `Current Balance` or `Net Worth` and a valid formatted
   amount, including when the amount is zero.
2. The privacy control masks the entire amount with non-numeric content and reveals
   it again in one action.
3. The card's detail action is present only when a wallet detail destination exists.
4. Recent Transactions shows at most three rows, with the newest records first.
5. Each row has an icon, description, timestamp, and signed amount.
6. Expense amounts use minus/expense styling and income amounts use plus/income
   styling.
7. With zero, one, two, or more than three records, the empty/limited/top-three
   behavior matches [data-model.md](data-model.md).
8. View All selects the Transactions destination in one action.
9. Light, dark, and pastel accent treatments preserve readable contrast.
10. Narrow, wide, and increased-text-scale layouts do not clip or overlap content.

## Completion evidence

Record the target, viewport sizes, theme variants, masking states, and transaction
datasets reviewed in the implementation change description. Resolve all analyzer
errors and visible layout defects before considering the feature ready.
