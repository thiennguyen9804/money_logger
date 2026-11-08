# Tasks: BLoC and SegmentedButton Architecture Refactor

**Input**: Design documents from `/specs/008-bloc-segmented-refactor/`
**Prerequisites**: plan.md, research.md, data-model.md, contracts/bloc-and-ui-contracts.md, quickstart.md

**Tests**: Excluded per constitution (No Automated Testing). Validation is `dart format`, `flutter analyze`, and manual runtime verification against `quickstart.md`.

**Organization**: Tasks are grouped by user story. Phases map to US1 (flutter_bloc adoption), US2 (SegmentedButton modernization), US3 (directory reorganization), and a final polish/validation phase.

---

## Phase 1: Setup (Shared Infrastructure)

- [ ] T001 Add `flutter_bloc` and `equatable` to `pubspec.yaml` dependencies at versions compatible with the Dart SDK constraint `^3.13.7`, then run `flutter pub get` to resolve and lock them
- [ ] T002 Capture pre-refactor baseline behavior for parity checks: run `dart format lib/main.dart --output none --set-exit-if-changed 2>&1 || dart format lib/main.dart` and `flutter analyze lib/main.dart`, and record the current findings count as the comparison point for the zero-findings target
- [ ] T003 [P] Create empty module directories: `lib/models/`, `lib/blocs/theme/`, `lib/blocs/ledger/`, `lib/shared/widgets/`, `lib/shared/theme/`, `lib/screens/dashboard/widgets/`, `lib/screens/transactions/widgets/`, `lib/screens/add_transaction/widgets/`

**Checkpoint**: Dependencies resolved; module skeleton in place.

---

## Phase 2: Foundational (US1 —flutter_bloc + Equatable State Layer)

**Goal**: Every event and state class extends `Equatable`; handwritten `StreamController` state management is removed; blocs are provided at the composition root. (FR-001, FR-002, FR-003, SC-001)

- [ ] T004 Create `lib/blocs/theme/theme_event.dart` with `ThemeModeChanged(mode)` extending `Equatable`, props derived from constructor arguments (FR-002)
- [ ] T005 Create `lib/blocs/theme/theme_state.dart` with `ThemeState(mode)` extending `Equatable` (FR-003)
- [ ] T006 Create `lib/blocs/theme/theme_bloc.dart` as a `flutter_bloc` `Bloc<ThemeEvent, ThemeState>`; business logic (mode switching) lives strictly in `on<ThemeModeChanged>` handlers (FR-001)
- [ ] T007 Create `lib/blocs/ledger/ledger_event.dart` with `LedgerMonthSelected(month)` and `LedgerRefreshed(transactions)` extending `Equatable` (FR-002)
- [ ] T008 Create `lib/blocs/ledger/ledger_state.dart` with `LedgerState(visibleMonths, selectedMonth, groupedTransactions)` extending `Equatable` (FR-003, value equality must prevent redundant ledger rebuilds)
- [ ] T009 Create `lib/blocs/ledger/ledger_bloc.dart` as a `flutter_bloc` `Bloc<LedgerEvent, LedgerState>`; ledger grouping and month filtering business logic lives strictly in `on<LedgerEvent>` handlers (FR-001)
- [ ] T010 Delete the handwritten `ThemeBloc` class (StreamController-based) from `lib/main.dart`; remove all manual state-diff and stream-closing boilerplate it contained (FR-001, SC-001)
- [ ] T011 Wire `MultiBlocProvider` in `main.dart` as the composition root, providing `ThemeBloc` and `LedgerBloc` above `MaterialApp` (FR-001, R4 decision in research.md)
- [ ] T012 Verify zero references to `StreamController`, manual `.add()` state diffs, or handwritten bloc classes remain under `lib/` (SC-001)

**Checkpoint**: All state flows through `flutter_bloc` blocs; every event/state extends `Equatable`; no StreamController remains.

---

## Phase 3: US2 — Standardize the Type Selector on Material 3 SegmentedButton (Priority: P1)

**Goal**: The Income/Expense selector is a native Material 3 `SegmentedButton<TransactionType>` with colors derived from `ThemeData.colorScheme` — no hard-coded `Colors.red`/`Colors.green` backgrounds (FR-004, FR-005)

**Independent Test**: Open the Add Transaction screen and verify the selector renders as a Material 3 `SegmentedButton` receiving colors from the theme's `ColorScheme`, with selection, category-type compatibility, and save gating behaving exactly as before the refactor.

### Implementation

- [ ] T013 Replace the custom `_TypeSegmentedControl` and `_TypeSegment` widgets in `lib/main.dart` (or the extracted add-transaction screen file) with Flutter's built-in `SegmentedButton<TransactionType>` (FR-004)
- [ ] T014 Bind segment selected/foreground colors to `ThemeData.colorScheme` (e.g. `colorScheme.primary`, `colorScheme.secondaryContainer`) with zero hard-coded `Colors.red`/`Colors.green` values (FR-005)
- [ ] T015 [P] Verify selection state still synchronizes type and category per feature 007 rules: changing type clears or replaces an incompatible selected category, and back-without-selection preserves the original pair (FR-008 behavior parity)
- [ ] T016 [P] Verify active/inactive segments remain readable and distinguishable in light and dark themes without relying on color alone (SC-003 visual parity)

**Checkpoint**: US2 deliverable — the selector is a native Material 3 widget; no custom segment control code remains under `lib/`.

---

## Phase 4: US3 — Reorganize the Codebase into a Feature-Driven Layout (Priority: P2)

**Goal**: Split the single-file application into modular directories per the structure decision in plan.md: `lib/screens/<feature>/` with per-screen `widgets/` folders, `lib/shared/widgets/` for cross-screen components, `lib/models/` for shared models, and `lib/blocs/` for state management.

### Implementation

- [ ] T017 Extract `Transaction`, `TransactionCategory`, `TransactionDraft`, `WalletSummary`, `LedgerMonth`, and `TransactionDateGroup` models into `lib/models/` with barrel-file exports
- [ ] T018 Extract cross-screen reusable widgets shared by two or more screens (e.g., `TransactionListItem`, `TransactionDateGroupView`, `LedgerMonthSelector`, `RecentTransactionRow`, balance/visibility controls) into `lib/shared/widgets/`
- [ ] T019 Split the Dashboard view into `lib/screens/dashboard/dashboard_screen.dart` plus a per-screen `widgets/` subfolder for dashboard-unique components (e.g., `WalletBalanceCard`)
- [ ] T020 Split the Transactions ledger view into `lib/screens/transactions/transactions_screen.dart` plus per-screen widgets
- [ ] T021 Split the Add Transaction and Category Selection pages into `lib/screens/add_transaction/add_transaction_screen.dart` and `lib/screens/category_selection/category_selection_screen.dart`
- [ ] T022 Split the App Shell, primary navigation, and destination routing into `lib/screens/shell/` with per-screen widgets in an adjacent `widgets/` folder
- [ ] T023 [P] Verify no file under `lib/` imports `main.dart` (FR-007) and no feature-specific widget file remains at the `lib/` root (SC-004)
- [ ] T024 [P] Verify every widget used by more than one screen resolves to `lib/shared/widgets/`, not a screen-specific folder (FR-006)

**Checkpoint**: US3 deliverable — `lib/` contains only `main.dart` (composition root) plus the modular `screens/`, `shared/`, `blocs/`, and `models/` trees; no orphaned files.

---

## Phase 5: Polish & Cross-Cutting Validation

- [ ] T025 [P] Run `dart format lib/` and resolve any formatting changes
- [ ] T026 [P] Run `flutter analyze` and confirm zero findings across all refactored files
- [ ] T027 [P] Manually verify quickstart.md runtime scenarios 1-5: theme toggle repaints without state loss; adding a transaction updates dashboard and ledger immediately; type/category compatibility enforced; draft content survives navigation; `flutter analyze` reports zero findings
- [ ] T028 [P] Verify SC-001 through SC-004: Equatable adoption, no deleted-widget references, visual parity in light and dark themes, and no feature-specific widget files at the `lib/` root

**Checkpoint**: All refactor work complete; behavior parity confirmed; codebase ready for `/speckit-implement`.

---

## Dependencies & Execution Order

- **Phase 1 (Setup)**: T001-T003 must complete before any bloc or screen work — the `flutter_bloc` package and `equatable` must be resolved first.
- **Phase 2 (US1)**: T004-T009 bloc file creation can proceed in parallel once dependencies resolve; T010 (delete handwritten bloc) and T011 (provider wiring) depend on the new blocs existing.
- **Phase 3 (US2)**: Depends on Phase 2 blocs being wired so the SegmentedButton can dispatch events.
- **Phase 4 (US3)**: File-reorganization tasks can begin once Phases 2-3 compile; T023/T024 verification depends on all prior splits.
- **Phase 5 (Polish)**: Validation sweep depends on all prior phases completing.

## Parallel Opportunities

- T017, T018 model/widget extraction can run in parallel with each other and with T022 shell splitting.
- T013-T016 (US2 widget work) can proceed in parallel with US3 model extraction since they touch different files.
- All [P]-marked verification tasks in Phase 5 are independent.

## Suggested MVP Scope

**User Story 1 only** (Phases 1-2): repository gains `flutter_bloc` + `equatable` with all state flowing through blocs, clearing the way for US2/US3 in subsequent passes.

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing — constitution mandates NO automated tests, so validation is `dart format` + `flutter analyze` + manual runtime verification exclusively
- Commit after each task or logical group
