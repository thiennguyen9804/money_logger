# Tasks: Transaction Item Formatting

**Input**: Design documents from `specs/004-transaction-item-formatting/`

**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md),
[research.md](./research.md), [data-model.md](./data-model.md),
[contracts/ui-contract.md](./contracts/ui-contract.md), and
[quickstart.md](./quickstart.md)

**Testing policy**: No automated test tasks are included. Validation uses
formatting, static analysis, manual runtime inspection, and responsive/theme
review per the project constitution.

## Phase 1: Setup

**Purpose**: Confirm the existing Flutter/Dart setup and implementation surface.

- [X] T001 Confirm Dart SDK `^3.13.7`, existing Flutter dependencies, and no new package requirement in `pubspec.yaml`
- [X] T002 [P] Review existing dashboard and ledger row widgets and transaction formatting helpers in `lib/main.dart`
- [X] T003 [P] Review active theme color roles and responsive layout conventions in `lib/main.dart`

---

## Phase 2: Foundational

**Purpose**: Define shared amount and type presentation rules before applying
them to either list surface.

- [X] T004 Define shared transaction-item presentation inputs in `lib/main.dart`, preserving category icon, description, secondary context, transaction type, and non-negative amount fields
- [X] T005 Define signless amount formatting in `lib/main.dart` using the existing currency formatter and the data-model rule that the numeric value is an absolute currency amount with existing symbol and precision
- [X] T006 Define theme-aware income, expense, and zero-value color selection in `lib/main.dart`, using readable positive, negative, and neutral theme roles
- [X] T007 Define explicit `Income`, `Expense`, or `Neutral` text cues and semantics in `lib/main.dart` so transaction type is understandable without color
- [X] T008 Define flexible trailing amount layout in `lib/main.dart` so detail text adapts before the amount loses its right-side boundary

**Checkpoint**: Shared presentation behavior is ready for both transaction lists.

## Phase 3: User Story 1 - Scan transaction amounts consistently (Priority: P1)

**Goal**: Show absolute, signless amounts at a stable right-side boundary in
both transaction lists.

**Independent Test**: Review dashboard and ledger rows containing income and
expense transactions with varied description lengths; verify amounts are
right-aligned, signless, readable, and free of overlap.

### Implementation

- [X] T009 [US1] Create the shared transaction row widget in `lib/main.dart` with category icon, description, secondary context, and trailing amount regions
- [X] T010 [US1] Render the existing currency symbol and precision as an absolute amount without `+` or `-` prefixes in the shared row widget in `lib/main.dart`
- [X] T011 [US1] Replace the dashboard recent transaction row implementation with the shared transaction row widget in `lib/main.dart`
- [X] T012 [US1] Replace the transaction ledger row implementation with the shared transaction row widget in `lib/main.dart`
- [X] T013 [US1] Preserve dashboard date context and ledger category context when passing secondary text to the shared row widget in `lib/main.dart`
- [X] T014 [US1] Apply flexible detail and trailing amount constraints in both transaction-list contexts in `lib/main.dart` to prevent clipping, overlap, and horizontal overflow

**Checkpoint**: User Story 1 independently provides consistent, signless,
right-aligned transaction amounts across both lists.

## Phase 4: User Story 2 - Distinguish income from expenses at a glance (Priority: P1)

**Goal**: Make transaction type clear through consistent semantic colors and
explicit non-color cues.

**Independent Test**: Review income, expense, and zero-value rows on the
dashboard and ledger; verify distinct readable colors, explicit type text, and
neutral zero-value treatment.

### Implementation

- [X] T015 [US2] Apply theme-aware positive semantic color to income amounts and explicit `Income` cues in the shared row widget in `lib/main.dart`
- [X] T016 [US2] Apply theme-aware negative semantic color to expense amounts and explicit `Expense` cues in the shared row widget in `lib/main.dart`
- [X] T017 [US2] Apply neutral semantic color and `Neutral` cue to zero-value amounts in the shared row widget in `lib/main.dart`
- [X] T018 [US2] Add transaction-row semantics in `lib/main.dart` that expose description, type cue, and absolute amount without relying on color
- [X] T019 [US2] Verify existing light and dark theme readability for income, expense, and neutral amount states in `lib/main.dart`

**Checkpoint**: User Story 2 independently communicates transaction type without
numeric signs or color-only meaning.

## Phase 5: User Story 3 - Preserve parity across transaction lists (Priority: P2)

**Goal**: Keep typography, spacing, alignment, colors, and behavior equivalent
when the same transaction appears on dashboard and ledger.

**Independent Test**: Compare equivalent rows across both screens in light and
dark themes and verify matching amount typography, trailing spacing, alignment,
and semantic color mapping.

### Implementation

- [X] T020 [US3] Align shared transaction-row padding, typography, and trailing spacing between dashboard and ledger usages in `lib/main.dart`
- [X] T021 [US3] Preserve category icon, description, date/category context, and existing touch/semantic behavior in both row call sites in `lib/main.dart`
- [X] T022 [US3] Verify empty transaction states remain unchanged and no placeholder rows are introduced in `lib/main.dart`
- [X] T023 [US3] Verify long descriptions, long category labels, large amounts, narrow widths, and increased text scale through responsive layout handling in `lib/main.dart`

**Checkpoint**: User Story 3 independently preserves cross-screen transaction
row parity and responsive behavior.

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Validate the complete feature against its design artifacts and
project governance.

- [X] T024 [P] Run `dart format lib/main.dart` and resolve formatting changes
- [X] T025 [P] Run `flutter analyze` and resolve all analyzer issues in `lib/main.dart`
- [X] T026 Manually validate the shared row contract in `specs/004-transaction-item-formatting/contracts/ui-contract.md`
- [X] T027 Manually execute the scenarios in `specs/004-transaction-item-formatting/quickstart.md`, including themes, responsive layouts, and signless values
- [X] T028 Inspect the final diff for unnecessary dependencies, duplicated row presentation, sign leakage, privacy regressions, overflow, and prohibited automated test additions

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; T002 and T003 can run in parallel after T001.
- **Foundational (Phase 2)**: Depends on Setup; T004-T008 block all user stories.
- **User Story 1 (Phase 3)**: Depends on Phase 2 and is the MVP.
- **User Story 2 (Phase 4)**: Depends on the shared row from Phase 2 and the list integrations from User Story 1.
- **User Story 3 (Phase 5)**: Depends on User Stories 1 and 2.
- **Polish (Phase 6)**: Depends on all desired user stories being complete.

### User Story Dependencies

- **US1 (P1)**: Depends only on foundational shared presentation rules.
- **US2 (P1)**: Uses the shared row created for US1 but can be validated independently after integration.
- **US3 (P2)**: Uses completed dashboard and ledger row parity from US1 and US2.

### Parallel Opportunities

- T002 and T003 can run in parallel after T001.
- T005, T006, and T007 can run in parallel after T004.
- T015, T016, and T017 can run in parallel after T014 if they remain focused on separate presentation rules.
- T024 and T025 can run in parallel after implementation.
- T026 and T027 can run in parallel once the app is running.

## Implementation Strategy

1. Complete setup and foundational presentation rules.
2. Deliver User Story 1 as the MVP: one shared row with right-aligned,
   signless amounts on dashboard and ledger.
3. Add User Story 2 semantic colors, explicit type cues, and accessibility
   semantics.
4. Complete User Story 3 parity and responsive review.
5. Run formatting, analyzer, manual runtime validation, and final diff review.
