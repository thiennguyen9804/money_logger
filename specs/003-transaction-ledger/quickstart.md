# Quickstart: Transaction Ledger

## Prerequisites

- Flutter and Dart versions compatible with `pubspec.yaml`.
- A connected mobile device/emulator or browser target.
- Session transactions from at least two months and multiple calendar dates.

## Static validation

From the repository root, run:

```powershell
dart format lib
flutter analyze
```

Expected result: formatting completes and static analysis reports no errors.
Do not add or run automated tests; project governance requires manual validation.

## Manual runtime validation

Open Transactions and verify:

1. The current balance appears before the month selector and remains available
   while reviewing the ledger.
2. Available months appear chronologically and the latest transaction month is
   initially selected.
3. Selecting another month updates the ledger without leaving Transactions.
4. Every displayed record belongs to the selected calendar month.
5. Records are grouped by local date, with newest groups first.
6. Each date heading shows a readable date and correct daily net total.
7. Rows show category icon, description, category label, date context, and
   signed amount.
8. Income uses `+` and income styling; expenses use `-` and expense styling.
9. Equal timestamps preserve deterministic sequence/ID ordering.
10. An empty month shows exactly
    `No transactions recorded for this month.`
11. Narrow, wide, light, dark, pastel-accent, and increased-text-scale layouts
    do not clip, overlap, or hide signed amounts.

## Completion evidence

Record target, viewport sizes, selected months, empty/populated datasets, theme
variants, and text-scale variants reviewed in the implementation change.
