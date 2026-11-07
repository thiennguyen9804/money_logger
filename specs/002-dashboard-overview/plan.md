# Implementation Plan: Dashboard Overview

**Branch**: `002-dashboard-overview` | **Date**: 2026-11-06 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

## Summary

Add a dashboard presentation to the existing Flutter shell. The dashboard will
show a session-backed wallet balance with privacy masking, a deterministic preview
of up to three newest transactions, signed income/expense amounts, and a View All
action that selects the Transactions destination. It will reuse the existing
in-project `ThemeBloc`, default navigation shell, and Flutter primitives without
adding dependencies.

## Technical Context

**Language/Version**: Dart SDK `^3.13.7`, as declared in `pubspec.yaml`

**Primary Dependencies**: Flutter SDK and existing dependencies; no new package

**State Management**: Existing in-project `ThemeBloc` for global theme state;
session dashboard data and balance visibility remain owned by the application shell

**Storage**: In-memory session data only; no persistence or synchronization

**Testing**: No unit, integration, or end-to-end tests. Use `dart format`,
`flutter analyze`, manual runtime verification, and responsive/theme review.

**Target Platform**: Existing Flutter mobile and web targets, including narrow and
wide viewports and increased text scale

**Project Type**: Cross-platform Flutter application

**Performance Goals**: Dashboard content is available immediately from in-memory
data; balance masking and navigation respond in one user action

**Constraints**: Currency arithmetic uses integer minor units; recent activity is
limited to three records sorted newest-first with deterministic ties; masked
balances render no numeric digits; no new dependencies or automated tests

**Scale/Scope**: One dashboard destination, one session wallet summary, a small
in-memory transaction collection, balance visibility state, and dashboard-only
recent activity derivation

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Clean Code**: PASS. Use immutable wallet/transaction models, focused dashboard
  widgets, and explicit derived recent-activity logic.
- **Simple UX**: PASS. Present balance first, limit activity to three rows, and keep
  View All and privacy actions direct.
- **Responsive Design**: PASS. Use flexible cards/rows, wrapping or ellipsis for
  long descriptions, and manual narrow/wide/text-scale review.
- **Minimal Dependencies**: PASS. Use Flutter primitives and a local currency
  formatter; add no package.
- **No Automated Testing**: PASS. Validation is limited to formatting, analyzer,
  manual review, and manual runtime verification.
- **Technology Constraints**: PASS. Use the Dart and Flutter versions declared in
  `pubspec.yaml`.

## Phase 0: Research

Research decisions are recorded in [research.md](./research.md). The design uses
integer minor units for currency, immutable session models, explicit stable
top-three sorting, presentation-only masking, and the existing indexed navigation.
Pastel is treated as an accessible pastel accent treatment within the existing
light/dark themes rather than a new persisted theme mode.

## Phase 1: Design

Design artifacts:

- [data-model.md](./data-model.md) defines wallet, transaction, visibility, and
  recent-activity state.
- [contracts/ui-contract.md](./contracts/ui-contract.md) defines the dashboard
  balance, privacy, recent activity, and navigation contract.
- [quickstart.md](./quickstart.md) defines static and manual validation scenarios.

## Project Structure

### Documentation (this feature)

```text
specs/002-dashboard-overview/
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
└── main.dart             # Session models, dashboard widgets, and shell integration
```

**Structure Decision**: Extend the existing single-file application because the
repository currently keeps the shell, theme BLoC, and destination widgets in
`lib/main.dart`. Extract focused model or widget files only if implementation size
requires it; do not introduce a package or persistence layer.

## Complexity Tracking

No constitution violations or complexity exceptions require tracking.
