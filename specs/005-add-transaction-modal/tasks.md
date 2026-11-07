---
description: "Executable task list for the Add Transaction Modal feature"
---

# Tasks: Add Transaction Modal

**Input**: Design documents from `specs/005-add-transaction-modal/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/ui-contract.md`, `quickstart.md`

**Validation policy**: No automated test tasks are included. The constitution
requires formatting, static analysis, manual runtime verification, and manual
review instead.

## Phase 1: Setup

**Purpose**: Confirm the existing Flutter structure and establish the feature
implementation boundary.

- [X] T001 Confirm the Add Transaction implementation remains scoped to `lib/main.dart` and preserve the existing Flutter/Dart versions declared in `pubspec.yaml`
- [X] T002 [P] Inventory the existing `Transaction`, `TransactionCategory`, `DashboardSessionData`, `AppShell`, and central navigation APIs in `lib/main.dart`
- [X] T003 [P] Record the manual validation scenarios from `specs/005-add-transaction-modal/quickstart.md` for runtime review

## Phase 2: Foundational

**Purpose**: Add shared state and callback seams required by every modal interaction.

**Checkpoint**: The modal can receive the active session and navigation context
without changing unrelated destination behavior.

- [X] T004 Add reusable in-memory category and event choices in `lib/main.dart`, reusing the existing `TransactionCategory` shape and keeping event creation out of scope
- [X] T005 Define a local transaction-draft model or equivalent focused state in `lib/main.dart` with `amountText`, `TransactionType`, selected category, local `createdAt`, optional event context, and collapsed `isMoreDetailsExpanded`
- [X] T006 Add positive minor-unit amount parsing and validation in `lib/main.dart`; reject empty, malformed, zero, and negative input while preserving the existing absolute integer currency representation
- [X] T007 Extend `AppShell` callbacks in `lib/main.dart` so the central Add Transaction action can open the modal while retaining the previously active destination index
- [X] T008 Define the save callback in `lib/main.dart` to append one valid transaction to `DashboardSessionData.transactions`, preserve selected type/category/date/context, and return a new immutable session value

## Phase 3: User Story 1 - Open and begin a transaction quickly (Priority: P1) 🎯 MVP

**Goal**: Open a dismissible slide-up modal from the central navigation control
with the amount field ready for numeric entry.

**Independent Test**: Tap the central Add Transaction control and verify the
sheet, backdrop, automatic amount focus, numeric/decimal keyboard, and
non-saving dismissal behavior.

- [X] T009 [US1] Replace the central Add Transaction destination action in `lib/main.dart` with modal presentation that uses a slide-up bottom sheet and a dismissible backdrop
- [X] T010 [US1] Create the modal form widget in `lib/main.dart` with a clean draft initialized on every opening and a scrollable, keyboard-inset-aware layout
- [X] T011 [US1] Add the prominent amount `TextField` in `lib/main.dart` with a dedicated `FocusNode`, numeric/decimal keyboard configuration, accessible label, and automatic focus after presentation completes
- [X] T012 [US1] Add modal dismissal handling in `lib/main.dart` for outside taps and downward drags, ensuring cancellation discards the draft and does not mutate `DashboardSessionData`
- [X] T013 [US1] Add the modal header, drag affordance, close semantics, and responsive spacing in `lib/main.dart` without fixed dimensions that can clip on narrow screens

**Checkpoint**: User Story 1 is independently usable and manually verifiable.

## Phase 4: User Story 2 - Enter transaction details (Priority: P1)

**Goal**: Capture type, category, and local date/time details with clear
selected-state feedback.

**Independent Test**: Open the modal, enter a valid amount, switch between both
transaction types, choose a category, inspect the current timestamp, and change
it through a date-time picker.

- [X] T014 [P] [US2] Add mutually exclusive Income and Expense controls in `lib/main.dart`, defaulting every new draft to Expense and exposing selected state beyond color alone
- [X] T015 [P] [US2] Add the category selector in `lib/main.dart` using available category names and icons, defaulting to the first available category and preventing horizontal overflow for long labels
- [X] T016 [US2] Add a date/time control in `lib/main.dart` that initializes from the device's current local timestamp and opens Flutter date and time pickers
- [X] T017 [US2] Preserve the selected date/time and category/type values in the modal draft across picker completion and rebuilds in `lib/main.dart`
- [X] T018 [US2] Add the Save action in `lib/main.dart` with accessible selected-state feedback and a disabled or clearly invalid state while the amount is not a positive number

**Checkpoint**: User Stories 1 and 2 are independently usable and manually
verifiable.

## Phase 5: User Story 3 - Add optional context and save safely (Priority: P2)

**Goal**: Reveal optional event context, reject invalid amounts, and commit valid
transactions while returning to the previously active destination.

**Independent Test**: Expand More Details, select an event, exercise invalid
amounts, save a valid entry, and verify the session and destination behavior.

- [X] T019 [P] [US3] Add the `More Details` control in `lib/main.dart` with progressive expansion and accessible expanded/collapsed state
- [X] T020 [P] [US3] Add the event or campaign selector in `lib/main.dart` using the small in-memory event list, retaining the selected optional context in the draft
- [X] T021 [US3] Connect valid Save handling in `lib/main.dart` to the `AppShell` session callback, creating one transaction with a positive absolute minor-unit amount and all selected draft values
- [X] T022 [US3] Close the modal after a valid save and restore the previously active destination index in `lib/main.dart`, allowing the updated dashboard or ledger to rebuild immediately
- [X] T023 [US3] Show clear amount validation feedback in `lib/main.dart` for empty, malformed, zero, and negative values without creating a transaction
- [X] T024 [US3] Ensure reopening after dismissal or save creates a fresh draft in `lib/main.dart` with Expense, the first category, current timestamp, empty amount, and collapsed More Details

**Checkpoint**: All requested Add Transaction behavior is complete and
independently manually verifiable.

## Phase 6: Polish and Cross-Cutting Concerns

**Purpose**: Validate quality, accessibility, themes, and responsive behavior
across the complete feature.

- [X] T025 [P] Add meaningful semantics and accessible labels for amount, type, category, date/time, event, dismissal, and Save controls in `lib/main.dart`
- [X] T026 [P] Adapt modal colors, fields, selectors, backdrop, and selected states to the existing light and dark themes in `lib/main.dart` while preserving readable contrast
- [X] T027 [P] Review `lib/main.dart` modal layout at narrow widths and increased text scale, ensuring keyboard insets keep the focused field and Save control reachable without clipping or horizontal overflow
- [X] T028 Run `dart format lib/main.dart` and inspect the resulting diff for unrelated changes
- [X] T029 Run `flutter analyze` and resolve all analyzer issues caused by the feature in `lib/main.dart`
- [X] T030 Run `git diff --check` and manually execute every scenario in `specs/005-add-transaction-modal/quickstart.md`
- [X] T031 Perform manual runtime verification on a connected Flutter emulator, including hot reload or hot restart, runtime error inspection, modal focus, invalid saves, valid saves, dismissal, themes, narrow layout, and increased text scale

## Dependencies and Execution Order

### Phase dependencies

- Phase 1 has no prerequisites.
- Phase 2 depends on Phase 1 and blocks all user-story work.
- User Stories 1 and 2 depend on Phase 2; they are both P1 but share the modal foundation, so implement them sequentially in task order.
- User Story 3 depends on the modal and save controls from User Stories 1 and 2.
- Phase 6 depends on all desired user stories.

### Story dependencies

```text
Phase 1 -> Phase 2 -> US1 -> US2 -> US3 -> Phase 6
```

### Parallel opportunities

- T002 and T003 can run in parallel.
- T014 and T015 can run in parallel after T010 is in place.
- T019 and T020 can run in parallel after T010 is in place.
- T025, T026, and T027 can run in parallel after US3.

## Implementation Strategy

1. Deliver the MVP with Phase 1, Phase 2, and User Story 1: opening the modal,
   automatic amount focus, numeric entry, and safe dismissal.
2. Add User Story 2 for the minimum complete transaction details.
3. Add User Story 3 for optional context and valid session commits.
4. Finish with manual static and runtime validation; do not add automated tests.
