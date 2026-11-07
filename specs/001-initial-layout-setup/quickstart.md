# Quickstart: Initial Layout and Theme Setup

## Prerequisites

- Flutter and Dart versions compatible with the repository's `pubspec.yaml`.
- A connected mobile device/emulator or a browser target for web validation.

## Static validation

From the repository root, run:

```powershell
dart format lib
flutter analyze
```

Expected result: formatting completes, and static analysis reports no errors.
Do not add or run unit, integration, or end-to-end tests; that is prohibited by the
project constitution.

## Manual runtime validation

Launch the application using the normal Flutter run command for the selected target.
Verify the following against [ui-contract.md](contracts/ui-contract.md):

1. The shell displays exactly five destinations in the required order.
2. Each destination can be selected in one action and shows a visible active state.
3. Add Transaction is reachable from every destination.
4. Switching between destinations preserves each destination's visible scroll and
   active view state.
5. Profile theme controls switch between light and dark themes immediately.
6. Theme changes apply to the full shell without changing the active destination.
7. The same behavior is usable on a mobile-sized viewport and a web-sized viewport.
8. Narrow widths, wide widths, and increased text scale do not clip or overlap
   required controls.

## Completion evidence

Record the target used, viewport sizes reviewed, theme modes reviewed, and any
manual issues found in the implementation change description. Resolve all analyzer
errors and all visible layout defects before considering the feature ready.
