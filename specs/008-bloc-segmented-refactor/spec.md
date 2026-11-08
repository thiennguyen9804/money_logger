# Feature Specification: BLoC and SegmentedButton Architecture Refactor

**Feature Branch**: `008-bloc-segmented-refactor`

**Created**: 2026-11-08

**Status**: Draft

**Input**: User description: "Refactor the existing transaction management implementation to strictly use official flutter_bloc and equatable packages, replacing custom BLoC/State implementations. Additionally, replace custom segmented control widgets with Flutter's native SegmentedButton, align with standard Material 3 color schemes, and reorganize the codebase into a clean, feature-driven directory structure."

---

## Executive Summary

The application currently manages state with hand-rolled stream controllers and
manual state comparison, and renders the Income/Expense selector through a
custom segment widget with hard-coded colors. This feature replaces both:
all state management moves to the official `flutter_bloc` package with
`Equatable`-based events and states, and the custom type selector is replaced
by Flutter's native Material 3 `SegmentedButton`. The codebase is reorganized
from a single-file application into a feature-driven directory layout. No
user-visible behavior may change as a result of any of these structural
changes — behavior parity is the delivery goal.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Adopt official flutter_bloc with Equatable states (Priority: P1)

As a developer maintaining the money logger, I want all state management to use
the official `flutter_bloc` package with `Equatable`-based events and states,
so that state changes use proven value-comparison semantics, eliminate
redundant widget rebuilds, and follow a widely documented pattern instead of
custom stream-controller boilerplate.

**Why this priority**: State management is the foundation of the refactor.
Every other change (UI modernization, directory restructuring) depends on a
stable, well-known state layer being in place first.

**Independent Test**: Open the app, toggle the theme, add a transaction, and
change the selected type. Verify every rebuild is driven by a `Bloc`/`Cubit`
state emission, every event and state class extends `Equatable`, and no
handwritten `StreamController` or manual state-diff code remains.

**Acceptance Scenarios**:

1. **Given** the app is running, **When** the theme is toggled, **Then** the
   rebuild is triggered by a state emission from a `Bloc`/`Cubit`, not by a
   manual `setState` in the app shell.
2. **Given** any state class in the codebase, **When** inspected, **Then** it
   extends `Equatable` and two states with identical field values compare
   equal.
3. **Given** any state-changing user action (theme switch, transaction
   creation, type/category selection), **When** the action completes, **Then**
   the new state was emitted through a `Bloc`/`Cubit` handler (`on<Event>`),
   and no handwritten `StreamController` or manual state-diff code remains.

---

### User Story 2 - Modernize the type selector on Material 3 SegmentedButton (Priority: P1)

As a person recording money activity, I want the Income/Expense selector to use
Flutter's native Material 3 `SegmentedButton`, so the control looks and behaves
consistently with standard Material 3 applications and carries no hard-coded
red/green background overrides.

**Why this priority**: The custom segment widget duplicates built-in Material 3
behavior (accessibility, ripple, theming) and carries hard-coded color values
that conflict with theme palettes. Replacing it removes maintenance surface
with zero functional change.

**Independent Test**: Open the Add Transaction screen and verify the selector
renders as a native Material 3 `SegmentedButton`, receives all colors from the
theme's `ColorScheme` (no hard-coded `Colors.red`/`Colors.green` backgrounds),
and that selection, category-type compatibility, and save gating behave exactly
as before the refactor.

**Acceptance Scenarios**:

1. **Given** the Add Transaction screen is open, **When** the type selector is
   displayed, **Then** it is a Material 3 `SegmentedButton` with segment
   highlight colors derived from `ThemeData.colorScheme`, with no manual
   background overrides.
2. **Given** either segment is selected, **When** the user taps the other
   segment, **Then** the selection state, category-type compatibility, and
   save gating behave exactly as before the refactor.
3. **Given** any supported theme (light, dark, increased text scale),
   **When** the selector is displayed, **Then** active and inactive segments
   remain readable and distinguishable without relying on color alone.

---

### User Story 3 - Reorganize the codebase into a feature-driven layout (Priority: P2)

As a developer, I want the single-file application split into modular
directories per screen and shared scope, so that screens, screen-specific
widgets, and reusable shared components are discoverable and independently
maintainable.

**Independent Test**: List the `lib/` tree and verify every file lives under
`lib/screens/<feature>/`, `lib/shared/widgets/`, or `lib/shared/theme/`, with
each screen directory housing its main page layout alongside a dedicated
`widgets/` subfolder for components unique to that screen.

**Acceptance Scenarios**:

1. **Given** the refactored codebase, **When** the `lib/` directory is listed,
   **Then** `screens/`, `shared/`, and `theme/` subfolders exist and no
   feature-specific widget file remains at the `lib/` root.
2. **Given** each screen (dashboard, transactions, add transaction, category
   selection, theme settings), **When** its screen file is opened, **Then**
   any widget used exclusively by that screen is imported from its adjacent
   `widgets/` folder, and any widget used by more than one screen resolves to
   `lib/shared/widgets/`.

---

## Edge Cases

- Partial migration states are unacceptable in the final deliverable: no file
  under `lib/` may import `main.dart` or reference the deleted custom segment
  widget after the refactor completes (intermediate commits containing
  transitional barrel/compatibility files are permitted, but not the final
  state).
- No state may be lost during the migration: in-progress draft content
  (amount text, selected category, selected type, selected date/time) must
  survive navigation between screens exactly as before.
- Visual layouts must not regress at narrow widths, large text scales, or in
  dark theme as a consequence of widget reorganization.
- Theme switching must emit through the state layer and repaint all dependent
  widgets without requiring a restart.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: All application state management MUST use `flutter_bloc`'s
  `Bloc`/`Cubit` primitives; business logic for transaction creation,
  type-category synchronization, and theme switching MUST reside strictly
  within bloc event handlers, keeping UI widgets purely presentational.
- **FR-002**: All BLoC events MUST extend `Equatable` and override `props` to
  enforce deterministic state changes.
- **FR-003**: All BLoC states MUST extend `Equatable` to prevent redundant UI
  rebuilds when state properties remain unchanged.
- **FR-004**: The custom `_TypeSegmentControl` widget MUST be deleted and
  replaced by Flutter's built-in `SegmentedButton<TransactionType>` widget.
- **FR-005**: Hard-coded custom red and green background overrides on segment
  widgets MUST be eliminated; segment highlight colors MUST come from the
  theme's `ColorScheme` without manual backdrop overrides.
- **FR-006**: The project MUST be reorganized into the feature-driven
  structure: `lib/screens/<feature>/` (each housing its main page layout plus
  an adjacent `widgets/` subfolder for screen-unique components),
  `lib/shared/widgets/` for components used by multiple screens, and
  `lib/shared/theme/` for theme data and palettes.
- **FR-007**: No file under `lib/` may import `main.dart` after the refactor;
  shared code MUST be imported from its new location.
- **FR-008**: No user-visible functionality present before the refactor may be
  removed or changed: draft editing, save validation, category-type
  synchronization, ledger grouping, and theme switching MUST behave
  identically to the pre-refactor build.

### Key Entities *(include if feature involves data)*

- **TransactionDraft**: The in-progress transaction being composed on the Add
  Transaction screen (amount text, selected category, selected type, selected
  date/time). Owned by the add-transaction bloc; unchanged in behavior.
- **Transaction**: A committed record with an id, category, amount, type,
  timestamp, and derived description. Unchanged in behavior.
- **LedgerMonth**: A derived calendar-month grouping used to filter the
  transaction ledger view. Unchanged in behavior.
- **ThemeSettings**: The supported theme modes (light, dark) surfaced through
  the dedicated theme bloc.
- **BlocEvent / BlocState**: `Equatable`-derived event and state families,
  one per feature bloc (add transaction, theme, ledger filtering).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of state classes emitted by blocs extend `Equatable`; zero
  handwritten `StreamController`, manual state-diff, or custom
  comparison implementations remain in the codebase.
- **SC-002**: Zero references to the deleted custom segment control remain
  anywhere under `lib/`.
- **SC-003**: 100% of screens render identically to the pre-refactor build at
  the same theme mode and text scale (visual parity in light and dark themes,
  verified by side-by-side inspection).
- **SC-004**: Every widget file lives under `lib/screens/<feature>/`,
  `lib/shared/widgets/`, or `lib/shared/theme/` — no feature-specific widget
  files remain at the `lib/` root, and no file under `lib/` imports
  `main.dart`.

## Assumptions

- The `flutter_bloc` and `equatable` packages are added as new dependencies in
  `pubspec.yaml` at their latest stable versions compatible with the
  project's declared Dart SDK constraint; no other dependencies are added.
- The application remains a single Flutter application with no new platform
  targets; persistence behavior (in-memory transactions) is unchanged.
- Screen composition, navigation entry points, category-type synchronization
  rules, and all user flows are frozen — this is a structural and state-layer
  refactor only, not a behavior change.
