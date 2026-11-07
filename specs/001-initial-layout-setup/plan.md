# Implementation Plan: Initial Layout and Theme Setup

**Branch**: `001-initial-layout-setup` | **Date**: 2026-10-31 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

## Summary

Create the initial Flutter application shell for a personal expense tracker. The
shell will expose five consistently ordered primary destinations, provide light and
dark themes, adapt its navigation presentation to mobile and web-sized viewports,
and preserve each destination's in-session view state. Global theme changes will be
managed by a focused in-project `ThemeBloc` using Flutter/Dart primitives. Navigation
will use Flutter's default `MaterialApp` and `Navigator` primitives without a
navigation package.

## Technical Context

**Language/Version**: Dart SDK `^3.13.7`, as declared in `pubspec.yaml`

**Primary Dependencies**: Flutter SDK and existing `cupertino_icons`; no new package
is required

**State Management**: Focused in-project `ThemeBloc` with immutable theme state and
explicit theme events/methods; no external BLoC package

**Navigation**: Flutter default `MaterialApp`/`Navigator` primitives, with an
indexed destination shell to retain each destination's session view state

**Storage**: In-memory session state only; persistent storage is out of scope

**Testing**: No unit, integration, or end-to-end tests. Use `dart format`, `flutter
analyze`, manual runtime verification, and manual responsive/theme review.

**Target Platform**: Flutter mobile and web viewports, with existing generated
desktop targets remaining build-compatible

**Project Type**: Cross-platform Flutter application

**Performance Goals**: Primary destination selection and theme switching are
immediate to the user, with no unnecessary loading step for the shell

**Constraints**: Exactly five primary destinations; adaptive layout must avoid
clipping and overflow at supported sizes and increased text scales; state is
session-scoped; no additional dependencies or automated tests

**Scale/Scope**: One application shell, five placeholder destination views, two
visual themes, one global theme BLoC, and per-destination in-session view state

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Clean Code**: PASS. Use focused widgets, immutable state, explicit events, and
  clear destination models with one responsibility each.
- **Simple UX**: PASS. Keep the primary navigation fixed to five labeled destinations
  and make Add Transaction directly reachable.
- **Responsive Design**: PASS. Use adaptive layout rules and manually review narrow,
  wide, and enlarged-text presentations.
- **Minimal Dependencies**: PASS. Implement the narrow theme BLoC with Flutter/Dart
  primitives; add no package.
- **No Automated Testing**: PASS. The plan excludes unit, integration, and
  end-to-end test files and commands.
- **Technology Constraints**: PASS. Dart and Flutter versions come from
  `pubspec.yaml`.

## Phase 0: Research

Research decisions are recorded in [research.md](./research.md). The main decision
is to use a small in-project `ThemeBloc` rather than add `flutter_bloc`, because the
current feature has one simple global state and the constitution requires minimal
dependencies. Flutter's default navigation primitives remain sufficient.

## Phase 1: Design

Design artifacts:

- [data-model.md](./data-model.md) defines destination metadata, session view state,
  and theme BLoC state/events.
- [contracts/ui-contract.md](./contracts/ui-contract.md) defines the user-facing
  shell and navigation contract.
- [quickstart.md](./quickstart.md) defines formatter, analyzer, and manual runtime
  validation.

## Project Structure

### Documentation (this feature)

```text
specs/001-initial-layout-setup/
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
└── main.dart             # Application entry point, ThemeBloc, and layout shell
```

The initial shell may remain in the existing single entry point because the
repository currently contains only `lib/main.dart`. Extract `ThemeBloc`, state, and
destination widgets into focused files if implementation size makes that clearer,
without introducing a new architectural package.

**Structure Decision**: Use Flutter SDK primitives and a narrow BLoC abstraction.
Use `MaterialApp`/`Navigator` for navigation and preserve destination widgets in an
indexed shell so switching tabs does not discard their session state.

## Complexity Tracking

No constitution violations or complexity exceptions require tracking.
