# Tasks: Initial Layout and Theme Setup

**Input**: Design documents from `specs/001-initial-layout-setup/`

**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md),
[research.md](./research.md), [data-model.md](./data-model.md),
[contracts/ui-contract.md](./contracts/ui-contract.md), and
[quickstart.md](./quickstart.md)

**Testing policy**: No automated test tasks are included. The project constitution
prohibits unit, integration, and end-to-end tests; validation uses formatting,
static analysis, manual runtime checks, and manual responsive/theme review.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Establish the Flutter entry point and implementation boundaries.

- [X] T001 Confirm the implementation uses the Dart SDK constraint `^3.13.7` and existing Flutter dependencies from `pubspec.yaml`
- [X] T002 [P] Configure the initial source structure under `lib/main.dart` for the application entry point and shell widgets
- [X] T003 [P] Review `analysis_options.yaml` and preserve the repository's configured Dart/Flutter lint rules

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Build the shared in-memory models and application shell foundation
required by all user stories.

- [X] T004 Define the ordered `NavigationDestination` metadata for Dashboard, Transactions, Add Transaction, Budgets, and Profile in `lib/main.dart`
- [X] T005 Define session-only `DestinationViewState` storage keyed by destination in `lib/main.dart`, preserving scroll position and active view state while destinations are hidden
- [X] T006 Implement the application root with Flutter's default `MaterialApp` and `Navigator` primitives in `lib/main.dart`
- [X] T007 Keep the five destination widgets alive in the shell so switching destinations does not discard their session state in `lib/main.dart`

**Checkpoint**: Shared shell foundation is ready; user-story work can proceed.

---

## Phase 3: User Story 1 - Navigate the primary money-management areas (Priority: P1) MVP

**Goal**: Provide exactly five ordered, visibly selectable primary destinations
that remain reachable throughout the application.

**Independent Test**: Manually launch the application on a mobile-sized and
web-sized viewport, select every destination from multiple starting destinations,
and verify the order, labels, active indicator, and one-action navigation.

### Implementation

- [X] T008 [US1] Implement the five-item primary navigation presentation in `lib/main.dart` with the exact order Dashboard, Transactions, Add Transaction, Budgets, Profile
- [X] T009 [US1] Add one-action destination selection and a visible active-navigation state in `lib/main.dart`
- [X] T010 [US1] Add placeholder destination views with the required headings and purposes in `lib/main.dart`
- [X] T011 [US1] Adapt the primary navigation layout for narrow and wide viewports without clipping or overlapping controls in `lib/main.dart`
- [X] T012 [US1] Preserve each destination's scroll position and active view state when returning to it in `lib/main.dart`

**Checkpoint**: User Story 1 is independently usable as the navigation-shell MVP.

---

## Phase 4: User Story 2 - Log a transaction quickly (Priority: P1)

**Goal**: Make Add Transaction a prominent, directly reachable primary action from
every destination.

**Independent Test**: Manually select Add Transaction from each of the other four
destinations and verify the transaction-entry destination opens in one action;
then return to a previous destination and verify it remains available.

### Implementation

- [X] T013 [US2] Make Add Transaction a visually prominent item in the primary navigation while preserving its third position in `lib/main.dart`
- [X] T014 [US2] Implement the Add Transaction placeholder destination with a clear transaction-entry heading and purpose in `lib/main.dart`
- [X] T015 [US2] Verify Add Transaction selection works from every primary destination without an extra confirmation step in `lib/main.dart`
- [X] T016 [US2] Preserve the previously visited destination's session view state after opening and leaving Add Transaction in `lib/main.dart`

**Checkpoint**: User Stories 1 and 2 are independently usable.

---

## Phase 5: User Story 3 - Choose a comfortable visual theme (Priority: P2)

**Goal**: Provide global light/dark theme management using a focused in-project
ThemeBloc without adding a state-management dependency.

**Independent Test**: Manually switch between light and dark modes from Profile,
navigate through all five destinations, and verify the theme remains consistent
without changing the active destination or preserved view state.

### Implementation

- [X] T017 [P] [US3] Define immutable `ThemeState` with light and dark modes in `lib/main.dart`
- [X] T018 [P] [US3] Define explicit `ThemeEvent` values for setting light mode, setting dark mode, and toggling mode in `lib/main.dart`
- [X] T019 [US3] Implement the focused in-project `ThemeBloc` with state emission and lifecycle disposal in `lib/main.dart`
- [X] T020 [US3] Provide `ThemeBloc` at the application root and rebuild `MaterialApp` theme configuration from the current `ThemeState` in `lib/main.dart`
- [X] T021 [US3] Add light and dark theme definitions covering navigation, destination content, controls, backgrounds, and text in `lib/main.dart`
- [X] T022 [US3] Add Profile theme controls that dispatch explicit ThemeBloc events in `lib/main.dart`
- [X] T023 [US3] Ensure theme changes preserve the active destination and all `DestinationViewState` values in `lib/main.dart`
- [X] T024 [US3] Verify theme controls and labels remain accessible at increased text scales in `lib/main.dart`

**Checkpoint**: All three user stories are independently usable.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Validate the complete feature and resolve cross-cutting quality issues.

- [X] T025 [P] Run `dart format lib` and resolve formatting changes in `lib/main.dart`
- [X] T026 [P] Run `flutter analyze` and resolve all analyzer errors in `lib/main.dart`
- [X] T027 Manually validate the completed shell against `specs/001-initial-layout-setup/contracts/ui-contract.md`
- [X] T028 Manually validate mobile-sized, web-sized, narrow, wide, and increased-text-scale layouts using `specs/001-initial-layout-setup/quickstart.md`
- [X] T029 Manually validate light/dark theme switching, destination preservation, and session view-state restoration using `specs/001-initial-layout-setup/quickstart.md`
- [X] T030 Inspect the final diff for unnecessary dependencies, unclear UX, non-responsive layouts, and prohibited automated test additions

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; T002 and T003 can run in parallel after T001 confirms the toolchain.
- **Foundational (Phase 2)**: Depends on Setup; T004-T007 block all user-story implementation.
- **User Story 1 (Phase 3)**: Depends on Phase 2 and is the MVP.
- **User Story 2 (Phase 4)**: Depends on Phase 2 and integrates with the navigation shell from US1.
- **User Story 3 (Phase 5)**: Depends on Phase 2 and integrates with the completed shell; T017-T018 can run in parallel.
- **Polish (Phase 6)**: Depends on all desired user stories being implemented.

### User Story Dependencies

- **US1 (P1)**: No dependency on another user story after Phase 2.
- **US2 (P1)**: Uses the navigation shell from US1 but remains independently verifiable once the shell exists.
- **US3 (P2)**: Uses the navigation shell from US1 and Add Transaction destination from US2 for complete cross-destination verification.

### Parallel Opportunities

- T002 and T003 can run in parallel after T001.
- T017 and T018 can run in parallel because they define separate ThemeBloc inputs.
- T025 and T026 can run in parallel after implementation is complete.
- Manual validation tasks T027-T029 can be performed in parallel when the application is available.

## Implementation Strategy

1. Complete Setup and Foundational phases.
2. Deliver US1 as the MVP: the five-destination shell with preserved session state.
3. Add US2's prominent Add Transaction destination.
4. Add US3's global ThemeBloc and light/dark presentation.
5. Run formatting, analysis, and manual cross-platform validation.

All tasks follow the required checklist format with a checkbox, sequential ID,
parallel marker where applicable, story label for story tasks, and an explicit
file path.
