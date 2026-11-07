# Tasks: Dashboard Overview

**Input**: Design documents from `specs/002-dashboard-overview/`

**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md),
[research.md](./research.md), [data-model.md](./data-model.md),
[contracts/ui-contract.md](./contracts/ui-contract.md), and
[quickstart.md](./quickstart.md)

**Testing policy**: No automated test tasks are included. The constitution
prohibits unit, integration, and end-to-end tests; validation uses formatting,
static analysis, manual runtime checks, and manual responsive/theme review.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare the existing Flutter shell for dashboard session data and
presentation without adding dependencies.

- [X] T001 Confirm `pubspec.yaml` uses Dart SDK `^3.13.7` and no new dependency is required
- [X] T002 [P] Review `lib/main.dart` shell state ownership and identify the Dashboard/Transactions integration points
- [X] T003 [P] Review `analysis_options.yaml` and preserve the configured Dart/Flutter lint rules

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Define immutable dashboard data and deterministic derived activity
before adding user-facing dashboard stories.

- [X] T004 Define immutable `WalletSummary` in `lib/main.dart` with required integer minor units, currency code, and currency symbol fields
- [X] T005 Define immutable `Transaction` in `lib/main.dart` with required unique session id, sequence, category metadata, description, absolute minor-unit amount, income/expense type, and creation timestamp
- [X] T006 Define session-scoped `BalanceVisibilityState` and dashboard transaction data ownership in `lib/main.dart`
- [X] T007 Implement dependency-free currency formatting for zero, positive, and negative wallet/transaction amounts in `lib/main.dart`
- [X] T008 Implement a derived recent-activity selector in `lib/main.dart` that copies source data, sorts by creation timestamp descending, breaks equal timestamps by sequence descending, and takes at most three records without mutating the source

**Checkpoint**: Dashboard data and derived activity rules are ready for story work.

---

## Phase 3: User Story 1 - Review current wallet balance (Priority: P1) MVP

**Goal**: Show the current wallet balance prominently with session-preserved
privacy masking and a conditional detail action.

**Independent Test**: Manually open Dashboard with zero, positive, and negative
wallet totals; verify formatting, label, masking, reveal behavior, and detail-action
availability.

### Implementation

- [X] T009 [US1] Add a high-visibility balance card to the Dashboard destination in `lib/main.dart` with `Current Balance` or `Net Worth` label
- [X] T010 [US1] Render the wallet aggregate using the local currency formatter in `lib/main.dart`, including valid zero and negative values
- [X] T011 [US1] Add a privacy toggle in `lib/main.dart` that switches between the formatted amount and a non-numeric `••••••` mask
- [X] T012 [US1] Add accessible show/hide balance semantics in `lib/main.dart` without exposing numeric digits while masked
- [X] T013 [US1] Preserve balance visibility state at shell/session scope in `lib/main.dart` across destination and theme changes
- [X] T014 [US1] Add the wallet breakdown/detail action in `lib/main.dart` only when a real detail destination is available
- [X] T015 [US1] Apply accessible pastel balance-card accents derived from the active theme in `lib/main.dart`

**Checkpoint**: User Story 1 is independently usable as the dashboard balance MVP.

---

## Phase 4: User Story 2 - Preview recent transactions (Priority: P1)

**Goal**: Display a precise, readable preview of up to three newest transactions
and provide one-action access to the full ledger.

**Independent Test**: Manually provide zero, one, two, three, and more than three
transactions, including equal timestamps, and verify empty/limited/top-three,
ordering, row content, signed amounts, and View All behavior.

### Implementation

- [X] T016 [US2] Add the `Recent Transactions` section header and `View All` action to Dashboard in `lib/main.dart`
- [X] T017 [US2] Wire `View All` to select the existing Transactions destination in one action through the shell callback in `lib/main.dart`
- [X] T018 [US2] Render the derived activity list with no more than three transaction rows in `lib/main.dart`
- [X] T019 [US2] Render each transaction row with category icon, description/merchant, date or relative timestamp, and formatted signed amount in `lib/main.dart`
- [X] T020 [US2] Apply minus/expense styling and plus/income styling using theme-readable semantic colors in `lib/main.dart`
- [X] T021 [US2] Add explicit empty and fewer-than-three transaction states in `lib/main.dart` without inventing records
- [X] T022 [US2] Preserve long descriptions and signed amounts using flexible row layout, wrapping, or truncation in `lib/main.dart`

**Checkpoint**: User Stories 1 and 2 are independently usable.

---

## Phase 5: User Story 3 - Use the dashboard across themes and devices (Priority: P2)

**Goal**: Keep dashboard content readable and usable across active themes,
viewport sizes, and increased text scales.

**Independent Test**: Manually inspect Dashboard in light, dark, and pastel accent
states at narrow and wide sizes with enlarged text.

### Implementation

- [X] T023 [US3] Integrate dashboard colors and text styles with `Theme.of(context)` and active `ThemeBloc` color schemes in `lib/main.dart`
- [X] T024 [US3] Make balance, recent rows, action controls, and empty states responsive at narrow and wide viewports in `lib/main.dart`
- [X] T025 [US3] Ensure increased text scales keep dashboard labels, amounts, dates, and actions readable and reachable in `lib/main.dart`
- [X] T026 [US3] Verify masked balance semantics, contrast, and interactive touch targets manually in `lib/main.dart`

**Checkpoint**: All dashboard user stories are independently usable.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Validate the complete dashboard and preserve project governance.

- [X] T027 [P] Run `dart format lib` and resolve formatting changes in `lib/main.dart`
- [X] T028 [P] Run `flutter analyze` and resolve all analyzer errors in `lib/main.dart`
- [X] T029 Manually validate the dashboard against `specs/002-dashboard-overview/contracts/ui-contract.md`
- [X] T030 Manually validate all quickstart datasets, balance masking, View All navigation, and theme behavior using `specs/002-dashboard-overview/quickstart.md`
- [X] T031 Inspect the final diff for unnecessary dependencies, unclear UX, responsive defects, numeric leakage while masked, and prohibited automated test additions

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; T002 and T003 can run in parallel after T001.
- **Foundational (Phase 2)**: Depends on Setup; T004-T008 block all user stories.
- **User Story 1 (Phase 3)**: Depends on Phase 2 and is the MVP.
- **User Story 2 (Phase 4)**: Depends on Phase 2 and integrates with the Dashboard shell from US1.
- **User Story 3 (Phase 5)**: Depends on Phase 2 and integrates with the balance and recent-activity UI.
- **Polish (Phase 6)**: Depends on all desired user stories being complete.

### User Story Dependencies

- **US1 (P1)**: No dependency on another user story after Phase 2.
- **US2 (P1)**: Uses the dashboard destination and session data from US1.
- **US3 (P2)**: Uses the completed balance and recent-activity presentation from US1/US2.

### Parallel Opportunities

- T002 and T003 can run in parallel after T001.
- T004 and T005 can run in parallel because they define independent immutable models.
- T027 and T028 can run in parallel after implementation.
- T029 and T030 can be performed in parallel once the app is running.

## Implementation Strategy

1. Complete Setup and Foundational phases.
2. Deliver US1 as the MVP: balance card, formatting, privacy state, and conditional
   detail action.
3. Add US2's three-row recent activity preview and View All navigation.
4. Add US3's responsive, theme-aware accessibility polish.
5. Run formatting, analysis, manual scenario validation, and final policy review.

All tasks follow the required checklist format with a checkbox, sequential ID,
parallel marker where applicable, story label for story tasks, and an explicit
file path.
