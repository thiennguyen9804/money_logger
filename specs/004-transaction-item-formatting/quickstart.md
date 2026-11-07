# Quickstart: Transaction Item Formatting

## Prerequisites

- Flutter/Dart versions supported by `pubspec.yaml`
- A connected Flutter emulator or device
- Repository root: `C:\Users\thienhnnguyen\Downloads\money_logger`

## Static validation

```powershell
dart format lib/main.dart
flutter analyze
git diff --check
```

Expected results: formatting completes, analyzer reports no issues, and diff
check reports no whitespace errors.

## Runtime scenarios

1. Launch the app and open Dashboard.
2. Confirm recent transaction amounts are right-aligned, absolute, and contain
   no plus or minus prefix.
3. Confirm income and expense rows include explicit type cues and distinct,
   readable semantic colors.
4. Open Transactions and compare equivalent rows with the dashboard.
5. Switch between light and dark themes and confirm both lists retain readable
   amount contrast and identical type mapping.
6. Use a narrow viewport and increased text scale. Confirm descriptions adapt
   without clipping, overlap, or moving amounts away from the trailing edge.
7. Review zero-value and unusually large amounts if available. Confirm they
   remain signless and readable, with neutral treatment for zero.
8. Confirm empty-state messages remain unchanged when a list has no records.

## Acceptance references

- Presentation requirements: [ui-contract.md](./contracts/ui-contract.md)
- Entity and formatting rules: [data-model.md](./data-model.md)
- User-facing outcomes: [spec.md](./spec.md)
