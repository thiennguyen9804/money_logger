---
description: "Executable task list for the Full-Screen Add Transaction Flow"
---

# Tasks: Full-Screen Add Transaction Flow

**Input**: Design documents from `specs/006-full-screen-add-transaction/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/ui-contract.md`, `quickstart.md`

**Validation policy**: No automated test tasks are included because the
constitution requires static analysis, formatting, manual review, and manual
runtime verification.

## Phase 1: Setup

**Purpose**: Confirm the existing Flutter structure and migration boundary.

- [X] T001 Confirm the full-screen Add Transaction migration is scoped to `lib/main.dart` and preserves Flutter/Dart versions from `pubspec.yaml`
- [X] T002 [P] Inventory the existing navigation, transaction session, amount validation, category, theme, and modal APIs in `lib/main.dart`
- [X] T003 [P] Record the full-screen and category-picker validation scenarios from `specs/006-full-screen-add-transaction/quickstart.md`

## Phase 2: Foundational

**Purpose**: Establish shared draft, category grouping, and route-result contracts
required by all user stories.

**Checkpoint**: The form can own a draft and exchange a selected category with
the secondary route without mutating session state.

- [X] T004 Define the full-screen `TransactionDraft` state in `lib/main.dart` with `amountText`, one `TransactionType`, nullable category, local `createdAt`, optional event context, and amount focus state
- [X] T005 Add grouped Expense and Income category collections with title and icon metadata in `lib/main.dart`, keeping category creation out of scope
- [X] T006 Define route result handling in `lib/main.dart` so category selection returns one category while category-route back returns no selection and preserves the main draft
- [X] T007 Reuse or extract positive amount parsing in `lib/main.dart`; Save must reject values that are not positive and parseable
- [X] T008 Define the session commit callback in `lib/main.dart` to append one saved transaction with absolute minor units, selected type/category/date/time/event, then restore the previous destination

## Phase 3: User Story 1 - Enter a transaction on a dedicated screen (Priority: P1) 🎯 MVP

**Goal**: Replace bottom-sheet presentation with a full-screen Add Transaction
page that supports explicit Back/Close, Save, and safe cancellation.

**Independent Test**: Open Add Transaction from the central control, verify the
full-screen header and actions, back out without saving, then save valid details
and confirm the previous destination is restored.

- [X] T009 [US1] Replace bottom-sheet invocation from the central Add Transaction control with a full-screen route push in `lib/main.dart`
- [X] T010 [US1] Create the full-screen Add Transaction page in `lib/main.dart` with safe-area layout, scrollable content, top-left Back/Close action, and top-right Save action
- [X] T011 [US1] Initialize a clean draft on every full-screen route opening in `lib/main.dart`, including empty amount, no category, current local date/time, and no event context
- [X] T012 [US1] Wire Back/Close handling in `lib/main.dart` to discard the draft and leave `DashboardSessionData` unchanged before a valid save
- [X] T013 [US1] Wire valid Save handling in `lib/main.dart` to close the route, update session state once, and restore the previously active destination

**Checkpoint**: User Story 1 is independently usable and manually verifiable.

## Phase 4: User Story 2 - Choose type and category with clear visual meaning (Priority: P1)

**Goal**: Provide directional Income/Expense indicators and a dedicated
two-tab category selection route that returns the chosen category.

**Independent Test**: Open the form, switch type indicators, open the category
field, switch Expense and Income tabs, select an item, and verify its icon and
title populate the main form.

- [X] T014 [P] [US2] Add mutually exclusive Income and Expense controls in `lib/main.dart`, using Expense with an up-arrow and soft rose/red styling and Income with a down-arrow and soft sage/green styling
- [X] T015 [US2] Add the empty `Select Category` field in `lib/main.dart`, retaining the exact placeholder until a category is chosen
- [X] T016 [US2] Create the dedicated category selection page in `lib/main.dart` with separate Expense and Income tabs or segmented sections
- [X] T017 [US2] Render category items with icons, titles, selected-state semantics, and adaptive wrapping/list behavior in `lib/main.dart` so long labels do not overflow
- [X] T018 [US2] Return the selected category from `lib/main.dart` to the Add Transaction page and populate the category field without losing amount, type, date/time, or event draft values
- [X] T019 [US2] Preserve predictable active-tab behavior in `lib/main.dart` when switching between Expense and Income category collections

**Checkpoint**: User Stories 1 and 2 are independently usable and manually
verifiable.

## Phase 5: User Story 3 - Start typing and manage focus naturally (Priority: P2)

**Goal**: Make amount entry immediate and allow neutral background taps to
dismiss focus and the keyboard without disrupting form controls.

**Independent Test**: Open the full-screen page, verify amount focus and numeric
keyboard availability, then tap neutral background space and verify focus and
keyboard dismissal.

- [X] T020 [US3] Add a dedicated amount `FocusNode` and numeric/decimal `TextField` configuration in `lib/main.dart`
- [X] T021 [US3] Request amount focus after full-screen route presentation completes in `lib/main.dart` and expose an accessible amount label
- [X] T022 [US3] Wrap neutral form background in `lib/main.dart` with focus dismissal behavior that clears amount focus and hides the keyboard without intercepting field, category, picker, Back, or Save taps
- [X] T023 [US3] Preserve existing date/time and More Details controls in `lib/main.dart` while retaining all draft values when focus changes or the category route returns

**Checkpoint**: All requested Add Transaction behavior is complete and
independently manually verifiable.

## Phase 6: Polish and Cross-Cutting Concerns

**Purpose**: Validate themes, accessibility, responsive layouts, and the complete
manual flow.

- [X] T024 [P] Add meaningful semantics and selected-state labels for Back/Close, Save, amount, type indicators, category field, tabs, category items, date/time, event, and neutral focus dismissal in `lib/main.dart`
- [X] T025 [P] Adapt full-screen surfaces, directional indicators, category tabs, selected states, and controls to the existing light, dark, and pastel themes in `lib/main.dart`
- [X] T026 [P] Review `lib/main.dart` at narrow widths and increased text scale, ensuring safe areas, scroll behavior, long category labels, header actions, and Save remain usable without horizontal overflow
- [X] T027 Run `dart format lib/main.dart` and inspect the diff for unrelated changes
- [X] T028 Run `flutter analyze` and resolve all analyzer issues caused by the full-screen flow in `lib/main.dart`
- [X] T029 Run `git diff --check` and manually execute every scenario in `specs/006-full-screen-add-transaction/quickstart.md`
- [X] T030 Perform manual runtime verification on a connected Flutter emulator, including hot reload or hot restart, runtime error inspection, full-screen route, focus dismissal, category tabs, invalid save, valid save, dismissal, themes, narrow layout, and increased text scale

## Dependencies and Execution Order

### Phase dependencies

- Phase 1 has no prerequisites.
- Phase 2 depends on Phase 1 and blocks all user-story work.
- User Story 1 depends on Phase 2 and establishes the full-screen route.
- User Story 2 depends on the route and draft from User Story 1.
- User Story 3 depends on the form from User Stories 1 and 2.
- Phase 6 depends on all requested stories.

### User story dependency graph

```text
Phase 1 -> Phase 2 -> US1 -> US2 -> US3 -> Phase 6
```

### Parallel opportunities

- T002 and T003 can run in parallel.
- T014 and T015 can run in parallel after the full-screen form exists.
- T016 and T017 can run in parallel after the category data contract exists.
- T024, T025, and T026 can run in parallel after US3.

## Implementation Strategy

1. Deliver the MVP with Phase 1, Phase 2, and User Story 1: a full-screen route,
   clean draft, safe cancellation, and valid save return.
2. Add User Story 2 for directional type meaning and dedicated category tabs.
3. Add User Story 3 for automatic amount focus and neutral-background unfocus.
4. Finish with manual static and runtime validation; do not add automated tests.
