# Quickstart: Full-Screen Add Transaction Flow

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

1. Open the app and tap the central Add Transaction control. Confirm a
   dedicated full-screen page appears with Back/Close on the left and Save on
   the right.
2. Confirm the amount field receives focus after presentation and the numeric
   keyboard is available.
3. Tap neutral background space. Confirm amount focus is removed and the
   keyboard hides without changing form values.
4. Confirm Expense displays an up-arrow with soft rose/red styling and Income
   displays a down-arrow with soft sage/green styling. Verify labels and icons
   communicate the distinction without color alone.
5. Confirm the category field initially says `Select Category`. Open it and
   verify separate Expense and Income tabs.
6. Switch category tabs, choose an item, and confirm the category screen closes
   with the selected icon and title visible on the form.
7. Enter a valid amount, select a category, and save. Confirm one transaction
   appears in session state and the previous destination is restored.
8. Back out of the main form and category screen without saving. Confirm no
   incomplete transaction appears and the draft values are preserved when
   returning from category selection.
9. Repeat in light, dark, and pastel themes, at narrow width, and with
   increased text scale. Confirm no header, field, category label, or Save
   control is clipped.

## Acceptance references

- UI behavior: [ui-contract.md](./contracts/ui-contract.md)
- Draft and route lifecycle: [data-model.md](./data-model.md)
- Requirements: [spec.md](./spec.md)
