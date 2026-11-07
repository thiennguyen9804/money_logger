# Quickstart: Add Transaction Modal

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

1. Open the app and tap the central Add Transaction navigation control.
2. Confirm a slide-up modal and backdrop appear, the amount field is focused,
   and the numeric/decimal keyboard is shown.
3. Confirm the clean initial state: empty amount, Expense selected, first
   available category selected, current date/time, and collapsed More Details.
4. Switch between Income and Expense and choose another category. Confirm only
   one type is selected and the category selection is visible.
5. Open the date/time picker, choose a different value, and confirm the form
   reflects it after returning.
6. Expand More Details and select an event or campaign. Confirm the selected
   event remains visible.
7. Try empty, malformed, zero, and negative amounts. Confirm no transaction is
   created and the save control is disabled or provides clear validation.
8. Enter a valid amount, save, and confirm the modal closes, the app returns to
   the previously active destination, and the new transaction appears there.
9. Dismiss by dragging down and by tapping outside. Confirm no partial
   transaction appears.
10. Repeat with light, dark, and pastel themes, a narrow viewport, and
    increased text scale. Confirm no essential control is clipped or obscured
    by the keyboard.

## Acceptance references

- Interaction contract: [ui-contract.md](./contracts/ui-contract.md)
- Draft and lifecycle rules: [data-model.md](./data-model.md)
- Requirements and measurable outcomes: [spec.md](./spec.md)
