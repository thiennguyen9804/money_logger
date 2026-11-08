# Quickstart: Type and Category Synchronization

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

1. Open Add Transaction with Expense selected and open Category Selection.
   Confirm Expense is initially active and only Expense categories are shown.
2. Return, switch the form to Income, and reopen categories. Confirm Income is
   initially active and only Income categories are shown.
3. With Expense selected, open categories, switch to Income, choose a category,
   and confirm the form changes to Income and displays that category.
4. Open categories, switch tabs, then press Back without selecting. Confirm the
   original type and category remain unchanged.
5. Change type while a category is selected. Confirm the incompatible category
   is cleared or replaced and cannot be saved as a mismatch.
6. Toggle Income and Expense in light, dark, and pastel themes. Confirm the
   active segment uses its contextual accent while the inactive segment remains
   neutral, with readable labels and icons.
7. Repeat with narrow width, increased text scale, long labels, and an empty
   category group. Confirm controls remain usable and the empty state is clear.

## Acceptance references

- UI behavior: [ui-contract.md](./contracts/ui-contract.md)
- State rules: [data-model.md](./data-model.md)
- Requirements: [spec.md](./spec.md)
