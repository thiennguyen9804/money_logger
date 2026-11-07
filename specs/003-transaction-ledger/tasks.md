# Tasks: Transaction Ledger

**Input**: Design documents from `specs/003-transaction-ledger/`

**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md),
[research.md](./research.md), [data-model.md](./data-model.md),
[contracts/ui-contract.md](./contracts/ui-contract.md), and
[quickstart.md](./quickstart.md)

**Testing policy**: No automated test tasks are included. The constitution
prohibits unit, integration, and end-to-end tests; validation uses formatting,
static analysis, manual runtime checks, and responsive/theme review.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare the existing shell and transaction session data for ledger
derivation without adding dependencies.

- [X] T001 Confirm `pubspec.yaml` uses Dart SDK `^3.13.7` and no new dependency is required
- [X] T002 [P] Review `lib/main.dart` transaction model, currency formatter, and Transactions destination integration points
- [X] T003 [P] Review `analysis_options.yaml` and preserve the configured Dart/Flutter lint rules

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Define deterministic month filtering and date-group derivation
before adding the ledger presentation.

- [X] T004 Define immutable `LedgerMonth` and selected-month identity in `lib/main.dart` with required year and month fields, where month MUST be between 1 and 12
- [X] T005 Define immutable `TransactionDateGroup` in `lib/main.dart` with required local date, ordered transaction list, and daily net minor-unit total
- [X] T006 Implement month derivation in `lib/main.dart` from transaction records, ordered chronologically, selecting the latest transaction month initially or the current local month when no records exist
- [X] T007 Implement selected-month filtering in `lib/main.dart` so every displayed transaction matches the selected year and month
- [X] T008 Implement non-mutating local-date grouping in `lib/main.dart`, ordering groups newest first and records by creation time, sequence descending, then ID descending
- [X] T009 Implement daily net total derivation in `lib/main.dart` as income sum minus expense sum using integer minor units
- [X] T010 Implement ledger month/date formatting helpers in `lib/main.dart` for readable month labels and date headings

**Checkpoint**: Ledger month, filtering, grouping, and daily-total rules are ready.

---

## Phase 3: User Story 1 - Review the transaction ledger (Priority: P1)

**Goal**: Show the full transaction history with a persistent balance header and
date-grouped records.

**Independent Test**: Open Transactions with records on multiple dates and
verify the balance, date groups, daily totals, and complete transaction rows.

### Implementation

- [X] T011 [US1] Replace the Transactions placeholder in `lib/main.dart` with a ledger view that receives shell session data and preserves its scroll state
- [X] T012 [US1] Add the current aggregate balance header to the Transactions ledger in `lib/main.dart` before scrollable history content
- [X] T013 [US1] Add date-group headers in `lib/main.dart` showing readable local dates and each group's daily net total
- [X] T014 [US1] Add ledger transaction rows in `lib/main.dart` showing category icon, description, category label, date context, and signed formatted amount
- [X] T015 [US1] Apply income plus-sign styling and expense minus-sign styling in `lib/main.dart` using theme-readable semantic colors and text labels
- [X] T016 [US1] Preserve existing balance privacy masking and numeric-free semantics in the Transactions balance header in `lib/main.dart`

**Checkpoint**: User Story 1 independently provides a complete, readable ledger.

---

## Phase 4: User Story 2 - Browse transactions by month (Priority: P1)

**Goal**: Let users select a calendar month and immediately filter the ledger.

**Independent Test**: Open Transactions with records from several months, select
each available month, and verify only matching records are displayed.

### Implementation

- [X] T017 [US2] Add a horizontally scrollable month selector to Transactions in `lib/main.dart` with chronological month labels
- [X] T018 [US2] Highlight exactly one selected month with the active theme accent and readable contrast in `lib/main.dart`
- [X] T019 [US2] Wire month tap and horizontal browsing interactions to update selected-month state and filtered groups in `lib/main.dart`
- [X] T020 [US2] Initialize the selector to the latest transaction month or current local month when no records exist in `lib/main.dart`
- [X] T021 [US2] Add the exact empty-month message `No transactions recorded for this month.` in `lib/main.dart` without fabricated groups or rows
- [X] T022 [US2] Reset or preserve a useful ledger scroll position when the selected month changes in `lib/main.dart`

**Checkpoint**: User Stories 1 and 2 independently support full monthly review.

---

## Phase 5: User Story 3 - Understand daily income and spending (Priority: P2)

**Goal**: Make daily totals and income/expense distinctions quick to scan.

**Independent Test**: Review a month containing income and expenses across several
dates and verify daily totals, ordering, signs, labels, and visual distinctions.

### Implementation

- [X] T023 [US3] Add readable daily net total labels and zero-total handling to date groups in `lib/main.dart`
- [X] T024 [US3] Ensure equal timestamps use sequence descending then ID descending ordering in every date group in `lib/main.dart`
- [X] T025 [US3] Add explicit category labels and non-color income/expense cues to ledger rows in `lib/main.dart`
- [X] T026 [US3] Make descriptions, category labels, and signed amounts resilient to long text and increased text scale in `lib/main.dart`
- [X] T027 [US3] Integrate ledger colors, typography, selected-month semantics, and touch targets with the active `ThemeBloc` theme in `lib/main.dart`

**Checkpoint**: All transaction ledger user stories are independently usable.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Validate the ledger against its contract and project governance.

- [X] T028 [P] Run `dart format lib` and resolve formatting changes in `lib/main.dart`
- [X] T029 [P] Run `flutter analyze` and resolve all analyzer errors in `lib/main.dart`
- [X] T030 Manually validate the ledger against `specs/003-transaction-ledger/contracts/ui-contract.md`
- [X] T031 Manually validate all month, grouping, empty-state, privacy, theme, and responsive scenarios using `specs/003-transaction-ledger/quickstart.md`
- [X] T032 Inspect the final diff for unnecessary dependencies, non-responsive layouts, incorrect month leakage, numeric privacy leakage, and prohibited automated test additions

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; T002 and T003 can run in parallel after T001.
- **Foundational (Phase 2)**: Depends on Setup; T004-T010 block all user stories.
- **User Story 1 (Phase 3)**: Depends on Phase 2 and is the MVP.
- **User Story 2 (Phase 4)**: Depends on Phase 2 and integrates with the ledger from US1.
- **User Story 3 (Phase 5)**: Depends on Phase 2 and integrates with US1/US2 presentation.
- **Polish (Phase 6)**: Depends on all desired user stories being complete.

### User Story Dependencies

- **US1 (P1)**: No dependency on another user story after Phase 2.
- **US2 (P1)**: Uses the Transactions ledger and grouping state from US1.
- **US3 (P2)**: Uses the completed grouped ledger and month-filtered rows from US1/US2.

### Parallel Opportunities

- T002 and T003 can run in parallel after T001.
- T004 and T005 can run in parallel because they define independent immutable views.
- T006 and T010 can run in parallel after the foundational model definitions.
- T028 and T029 can run in parallel after implementation.
- T030 and T031 can be performed in parallel once the app is running.

## Implementation Strategy

1. Complete Setup and Foundational phases.
2. Deliver US1 as the MVP: balance header, date groups, daily totals, and complete rows.
3. Add US2 month selection, filtering, selected state, and empty-month handling.
4. Add US3 scanability, accessibility, theme integration, and text-scale resilience.
5. Run formatting, analysis, manual runtime scenarios, and final policy review.

All tasks follow the required checklist format with a checkbox, sequential ID,
parallel marker where applicable, story label for story tasks, and an explicit
file path.
