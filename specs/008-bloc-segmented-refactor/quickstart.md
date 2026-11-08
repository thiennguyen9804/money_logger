# Quickstart: BLoC and SegmentedButton Architecture Refactor

## Prerequisites

- Flutter SDK ^3.13.7 (per `pubspec.yaml`)
- `flutter pub get` after pulling this branch (new dependencies: `flutter_bloc`, `equatable`)
- A connected emulator or device, or `flutter run -d <device>`

## Static Validation

```sh
dart format lib/
flutter analyze
```

Expected: formatter reports no changes after the refactor; analyzer reports
zero findings — including no references to the deleted custom segment widget
and no imports of `main.dart` from any file under `lib/`.

## Runtime Scenarios

1. Toggle the theme → full repaint without state loss; navigation, balance,
   and ledger remain intact.
2. Add a full transaction → appears in the dashboard and ledger immediately
   after save.
3. Change transaction type with a category selected → category compatibility
   enforced; an incompatible category is cleared or replaced, never saved.
4. Navigate between screens → draft state survives route changes.
5. Save-gating behavior identical to the pre-refactor build.

## SC-003 Visual Parity Check

At the same theme mode and text scale as the pre-refactor build, every screen
must render identically. Light and dark themes, both at default text scale —
side-by-side inspection against the pre-refactor build.

## Constitution Alignment

- No automated tests added (constitution mandate).
- No new dependencies beyond `flutter_bloc` + `equatable`.
- All user-visible behavior frozen — FR-008.
