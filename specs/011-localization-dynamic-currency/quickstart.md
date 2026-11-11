# Quickstart: Localization and Dynamic Currency

This guide validates the feature without automated tests, in line with the project constitution.

## Prerequisites

- Flutter and Dart versions compatible with `pubspec.yaml` (`sdk: ^3.13.7`).
- Dependencies resolved for the repository.
- An Android/iOS emulator, device, or supported desktop target.

## Generate and statically validate

From the repository root, run:

```powershell
flutter pub get
flutter gen-l10n
dart format --output=none --set-exit-if-changed lib
flutter analyze
```

Expected result: localization resources generate successfully, formatting reports no changed files, and static analysis reports no issues introduced by this feature.

## Manual runtime review

1. Launch the app with `flutter run` on a supported target.
2. Open Profile and select Vietnamese. Confirm visible navigation and screen text update without restarting.
3. Open Dashboard and Transactions. Confirm the sample monetary amount uses VND, period grouping, no fractional digits, and a trailing `₫`.
4. Open Add Transaction. Confirm its amount hint and validation use VND whole-number entry. Enter a value, change language, and confirm the unsaved value remains.
5. Select English (US) in Profile. Confirm visible labels update and monetary values use `$`, comma grouping, a period decimal separator, and two fractional digits.
6. In Add Transaction, confirm English input accepts up to two fractional digits and rejects malformed or over-precision input.
7. Restart the app and confirm the selected language is restored.
8. With no saved selection, use an unsupported device language and confirm English (US) is selected.
9. Review translated category names and longer Vietnamese copy at a narrow viewport and increased text scale. Confirm text remains readable and layout does not clip.
10. Confirm changing language changes presentation only; stored minor-unit transaction values are not converted or rewritten.

Expected result: both locales are selectable and persistent; all visible static text and category labels switch languages; amount formatting and input rules follow the locale; no stored numeric value or unsaved input is lost.

## Related design

- [Data model and locale rules](data-model.md)
- [Feature requirements](spec.md)