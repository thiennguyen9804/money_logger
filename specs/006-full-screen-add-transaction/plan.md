# Implementation Plan: Full-Screen Add Transaction Flow

**Branch**: `006-full-screen-add-transaction` | **Date**: 2026-11-07 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

## Summary

Replace the current Add Transaction bottom sheet with a dedicated full-screen
route. Preserve a local draft while the user moves between the main form and a
two-tab category picker. Use clear directional type indicators, focus the
amount field after entry, dismiss focus from neutral background taps, and commit
only validated saves to the existing session.

## Technical Context

**Language/Version**: Dart `^3.13.7` from `pubspec.yaml`

**Primary Dependencies**: Existing Flutter SDK and current packages; no new dependencies

**Storage**: Existing in-memory `DashboardSessionData`

**Testing**: No automated tests; formatting, analyzer, manual review, and runtime verification

**Target Platform**: Existing Flutter mobile emulator and supported form factors

**Project Type**: Flutter mobile application

**Performance Goals**: Full-screen navigation and category return feel immediate; keyboard focus is ready after presentation

**Constraints**: Preserve draft across route changes, support narrow widths and text scale, no new dependencies or automated tests

**Scale/Scope**: One full-screen transaction form and one category selection page integrated into the existing shell

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Clean code: PASS — separate full-screen form, category selection, draft, and save responsibilities.
- Simple UX: PASS — the header makes navigation and saving explicit; category selection is direct.
- Responsive design: PASS — use scrollable/adaptive layouts, safe areas, and keyboard-aware focus handling.
- Minimal dependencies: PASS — use existing Flutter navigation, inputs, tabs, and theme primitives.
- No automated testing: PASS — only manual and static validation are planned.
- Flutter/Dart governance: PASS — use versions declared in `pubspec.yaml`.

## Project Structure

### Documentation (this feature)

```text
specs/006-full-screen-add-transaction/
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

specs/006-full-screen-add-transaction/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── contracts/
    └── ui-contract.md
```

**Structure Decision**: Keep the existing single-file application structure. Application changes remain
in `lib/main.dart`; feature design artifacts are stored in this directory. No
test directory is created because automated tests are prohibited.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | Not applicable | Existing Flutter primitives and in-memory session state are sufficient. |
