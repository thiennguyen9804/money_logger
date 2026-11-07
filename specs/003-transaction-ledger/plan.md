# Implementation Plan: Transaction Ledger

**Branch**: `003-transaction-ledger` | **Date**: 2026-11-07 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

## Summary

Add a full transaction ledger to the existing Transactions destination. The
ledger will reuse session transaction records and the wallet summary already
used by the dashboard, derive available calendar months, filter by the selected
month, group records by local calendar date, and display daily net totals.
Implementation remains inside the existing Flutter shell with no new package or
persistence layer.

## Technical Context

**Language/Version**: Dart SDK `^3.13.7`, as declared in `pubspec.yaml`

**Primary Dependencies**: Flutter SDK and existing dependencies; no new package

**State Management**: Existing shell-owned session data; selected month is local
Transactions destination state and does not require a new global BLoC

**Storage**: In-memory session data only; no persistence or synchronization

**Testing**: No unit, integration, or end-to-end tests. Use `dart format`,
`flutter analyze`, manual runtime verification, and responsive/theme review.

**Target Platform**: Existing Flutter mobile and web targets, including narrow
and wide viewports and increased text scale

**Project Type**: Cross-platform Flutter application

**Performance Goals**: Month selection updates visible records in one user
action; grouping and filtering remain immediate for the small session collection

**Constraints**: Integer minor currency units, local calendar dates,
newest-first ordering with sequence/ID tie-breakers, exact empty-month copy,
theme-readable styling, no new dependencies, and no automated tests

**Scale/Scope**: One Transactions destination, session-sized transaction data,
month selection, date grouping, daily totals, and responsive presentation

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Clean Code**: PASS. Reuse immutable transaction models and isolate month
  derivation, filtering, grouping, and presentation logic.
- **Simple UX**: PASS. Keep balance visible, make month selection direct, and
  provide a clear empty-month state.
- **Responsive Design**: PASS. Use flexible layouts, adaptive spacing, wrapping,
  and scrollable month selection.
- **Minimal Dependencies**: PASS. Use Flutter primitives and existing helpers;
  add no package or persistence layer.
- **No Automated Testing**: PASS. Use formatting, static analysis, manual runtime
  verification, and responsive/theme review only.
- **Technology Constraints**: PASS. Use the Dart and Flutter versions declared in
  `pubspec.yaml`.

## Phase 0: Research

Research decisions are recorded in [research.md](./research.md). The design
reuses the existing transaction model and currency formatter, stores selected
month state at the Transactions destination, derives months from transaction
data, groups by local calendar date, and presents the balance above the ledger.

## Phase 1: Design

Design artifacts:

- [data-model.md](./data-model.md) defines ledger months, date groups, daily
  totals, and selected-month state.
- [contracts/ui-contract.md](./contracts/ui-contract.md) defines balance,
  carousel, grouping, row, empty-state, accessibility, and responsive behavior.
- [quickstart.md](./quickstart.md) defines manual validation scenarios.

## Project Structure

### Documentation (this feature)

```text
specs/003-transaction-ledger/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── ui-contract.md
└── tasks.md              # Created by /speckit-tasks
```

### Source Code (repository root)

```text
lib/
└── main.dart             # Existing models, shell, Transactions ledger, helpers
```

**Structure Decision**: Extend the existing single-file application because the
shell, session models, theme BLoC, and destination widgets currently live in
`lib/main.dart`. Extract focused files only if implementation size requires it;
do not add a package, router, repository, or persistence layer.

## Complexity Tracking

No constitution violations or complexity exceptions require tracking.
