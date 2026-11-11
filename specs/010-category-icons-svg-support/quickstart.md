# Quickstart: Category Icons and SVG Support

This guide validates the feature without automated tests, in line with the project constitution.

## Prerequisites

- Flutter and Dart versions compatible with `pubspec.yaml` (`sdk: ^3.13.7`).
- Dependencies already resolved for the repository.
- A device, emulator, or desktop target supported by the current application.

## Static validation

From the repository root, run:

```powershell
dart format --output=none --set-exit-if-changed lib
flutter analyze
```

Expected result: formatter reports no files needing changes, and static analysis reports no issues introduced by the feature.

## Manual runtime review

1. Start the app with `flutter run` on a supported target.
2. Open Dashboard and inspect recent transaction category badges.
3. Open Ledger and inspect transaction category badges; confirm they match Dashboard.
4. Open the add transaction flow and inspect category selection rows for both Expense and Income.
5. Confirm at least one category with bundled SVG artwork and one native-icon-only category render correctly.
6. Repeat in light and dark themes. Check badge contrast, centering, and consistent sizing.
7. Review a narrow viewport and increased text scaling; ensure rows remain readable and badges do not overlap or clip.
8. Temporarily point a development category at a missing or malformed SVG asset, run the app, and confirm the native icon fallback appears and the category remains selectable/renderable. Restore the valid reference before closing review.

Expected result: all three specified surfaces show consistent badges, local SVGs render, native icons remain visible, and invalid SVG assets fail gracefully without disrupting the screen.

## Related design

- [Data model and fallback rules](data-model.md)
- [Feature requirements](spec.md)