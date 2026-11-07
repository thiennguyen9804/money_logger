# Implementation Plan: Add Transaction Modal

**Branch**: `005-add-transaction-modal` | **Date**: 2026-11-07 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

## Summary

Provide a fast Add Transaction creation flow from the existing central
navigation action. Use a modal bottom sheet with a clean draft state, automatic
amount focus, numeric/decimal input, type and category selectors, date/time
selection, progressive event details, validation, and an explicit save callback
that updates session state before returning to the previously active destination.

## Technical Context

**Language/Version**: Dart `^3.13.7` from `pubspec.yaml`

**Primary Dependencies**: Flutter SDK and existing dependencies; no new packages

**Storage**: Existing in-memory `DashboardSessionData`; no persistence changes

**Testing**: No automated tests; formatting, analyzer, runtime inspection, and manual review

**Target Platform**: Existing Flutter mobile emulator and supported form factors

**Project Type**: Flutter mobile application

**Performance Goals**: Modal opens promptly, focus is available after presentation, and form interactions remain immediate

**Constraints**: Keyboard-safe layout, narrow widths, increased text scale, clean dismissal, no new dependencies, no automated tests

**Scale/Scope**: One Add Transaction modal integrated with the existing shell and transaction session

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Clean code: PASS — separate draft state, validation, and modal sections with focused responsibilities.
- Simple UX: PASS — Expense and first category defaults reduce entry steps; More Details is progressive disclosure.
- Responsive design: PASS — account for keyboard insets, scrollable content, narrow widths, and text scale.
- Minimal dependencies: PASS — use existing Flutter primitives only.
- No automated testing: PASS — validation is manual and static.
- Flutter/Dart governance: PASS — use the SDK constraint in `pubspec.yaml`.

## Project Structure

### Documentation (this feature)

```text
specs/005-add-transaction-modal/
├── plan.md              # This file (/speckit-plan command output)
├── research.md          # Phase 0 output (/speckit-plan command)
├── data-model.md        # Phase 1 output (/speckit-plan command)
├── quickstart.md        # Phase 1 output (/speckit-plan command)
├── contracts/           # Phase 1 output (/speckit-plan command)
└── tasks.md             # Phase 2 output (/speckit-tasks command - NOT created by /speckit-plan)
```

### Source Code (repository root)
```text
lib/
└── main.dart

specs/005-add-transaction-modal/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── contracts/
    └── ui-contract.md
```

**Structure Decision**: Use the existing single-file Flutter application structure. Application changes
are limited to `lib/main.dart`; design and validation documents remain in this
feature directory. No test directory is created because automated tests are
prohibited by the constitution.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | Not applicable | The modal fits the existing shell and in-memory session without a constitutional exception. |
