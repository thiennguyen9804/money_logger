# Implementation Plan: Type and Category Synchronization

**Branch**: `007-type-category-sync` | **Date**: 2026-11-07 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

## Summary

Keep the selected transaction type and category synchronized across the
full-screen Add Transaction form and the category selection route. The category
route opens on the current type, temporary tab changes remain uncommitted until
selection, and selecting a category propagates both category and type back to
the form. The type segmented control uses contextual active accents with
neutral inactive styling.

## Technical Context

**Language/Version**: Dart `^3.13.7` from `pubspec.yaml`

**Primary Dependencies**: Existing Flutter SDK and current packages; no new dependencies

**Storage**: Existing in-memory `DashboardSessionData` and local `TransactionDraft`

**Testing**: No automated tests; formatting, analyzer, manual review, and runtime verification

**Target Platform**: Existing Flutter mobile emulator and supported form factors

**Project Type**: Flutter mobile application

**Performance Goals**: Type/category updates feel immediate when changing segments or returning from category selection

**Constraints**: Preserve unselected-back behavior, prevent mismatched pairs, support themes and text scale, and add no dependencies

**Scale/Scope**: Synchronization logic and segmented-control styling across the existing Add Transaction and category pages

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Clean code: PASS — keep type/category synchronization at the draft and route-result boundaries.
- Simple UX: PASS — open the relevant category group automatically and commit only explicit selections.
- Responsive design: PASS — preserve adaptive category layout and readable controls at narrow widths and increased text scale.
- Minimal dependencies: PASS — use existing Flutter state, navigation, and theme primitives.
- No automated testing: PASS — validation remains static and manual.
- Flutter/Dart governance: PASS — follow `pubspec.yaml` SDK constraints.

## Project Structure

### Documentation (this feature)

```text
specs/007-type-category-sync/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── contracts/
    └── ui-contract.md
```

### Source Code (repository root)

```text
lib/
└── main.dart
```

**Structure Decision**: Preserve the existing single-file Flutter application.
Only the design artifacts are added for this planning phase; application code
is intentionally unchanged because the user requested planning without coding.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| None | Not applicable | Existing state and Flutter primitives satisfy the feature. |
