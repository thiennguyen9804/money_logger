# Implementation Plan: BLoC and SegmentedButton Architecture Refactor

**Branch**: `008-bloc-segmented-refactor` | **Date**: 2026-11-08 | **Spec**: [spec.md](./spec.md)

## Summary

Migrate all state management from handwritten stream controllers and
`setState`-driven updates to the official `flutter_bloc` package with
`Equatable`-based events and states, replace the custom Income/Expense segment
widget with Flutter's native Material 3 `SegmentedButton`, and reorganize
`lib/` from a single-file application into a feature-driven directory layout.
Behavior parity is the delivery goal: draft editing, save validation,
category-type synchronization, ledger grouping, and theme switching must behave
identically to the pre-refactor build.

## Technical Context

**Language/Version**: Dart ^3.13.7 (per `pubspec.yaml`), Flutter 3.47.8 stable
**Primary Dependencies**: flutter_sdk, flutter_bloc (new), equatable (new)
**Storage**: In-memory only (DashboardSessionData, TransactionDraft); no persistence
**Testing**: No automated tests (constitution); `dart format` + `flutter analyze` + manual runtime verification
**Target Platform**: Flutter mobile (existing emulator targets)
**Project Type**: Flutter mobile application (single project)

## Constitution Check

| Principle | Status | Notes |
|---|---|---|
| Clean Code | PASS | Blocs own business logic in `on<Event>` handlers; widgets purely presentational (FR-001) |
| Simple UX | PASS | No UX changes; behavior parity enforced by FR-008 |
| Responsive Design | PASS | No layout changes; visual parity verified by SC-003 |
| Minimal Dependencies | PASS | Only `flutter_bloc` + `equatable` added, both explicitly required by FR-001/FR-002 |
| No Automated Testing | PASS | Validation via `dart format`, `flutter analyze`, manual runtime scenarios |

**Gate verdict**: PASS — proceed to task generation.

## Project Structure

### Documentation (this feature)

```text
specs/008-bloc-segmented-refactor/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/
│   └── bloc-and-ui-contracts.md   # Phase 1 output
└── tasks.md             # Phase 2 output (/speckit-tasks)
```

### Source Code (repository root)

```text
lib/
├── main.dart                     # Composition root: MaterialApp, MultiBlocProvider, AppShell
├── shared/
│   ├── widgets/                  # Cross-screen reusable widgets
│   └── theme/
│       └── theme_data.dart       # Pastel theme system + ThemeData builders
├── blocs/                        # Event/State/Bloc triplets, one folder per feature
│   ├── theme/
│   ├── add_transaction/
│   ├── category_selection/
│   └── ledger/
└── screens/
    ├── dashboard/                # dashboard_screen.dart + widgets/
    ├── transactions/             # transactions_screen.dart + widgets/
    ├── add_transaction/          # add_transaction_screen.dart + widgets/
    ├── category_selection/       # category_selection_screen.dart + widgets/
    └── shell/                    # AppShell + primary navigation
```

**Structure Decision**: Single Flutter project, feature-driven layout. The composition
root (`main.dart`) hosts `MaterialApp` and `MultiBlocProvider`; each screen owns a
folder with its page layout plus screen-unique widgets; blocs with events/states used
by more than one screen live under `lib/blocs/`.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| None | N/A | N/A |

---

## Phase 0: Outline & Research

### Unknowns extracted from Technical Context

| # | Unknown | Research task |
|---|---|---|
| R1 | How to model multi-event blocs for transaction drafting while keeping states Equatable | Resolved — bloc-per-feature with minimal state families |
| R2 | Where in-flight draft state lives during navigation | Resolved — draft moves to `AddTransactionBloc` state |
| R3 | Whether theme switching needs a bloc or a cubit | Resolved — `Bloc` with events for uniformity with FR-002 |
| R4 | Provider wiring pattern for blocs consumed by multiple screens | Resolved — composition-root provider for long-lived blocs, route-scoped providers for navigation-bound blocs |

### Phase 0 Output: research.md

Full rationale and alternatives-considered recorded in [research.md](./research.md).

**Key decisions**:

1. **Bloc-per-feature, not one god-bloc** — union states from a single global
   bloc break Equatable value equality between unrelated features.
2. **Draft state moves into `AddTransactionBloc`** — widget state loses the
   draft when the category-selection route pushes over the screen.
3. **`Bloc` with events for theme, not `Cubit`** — uniform event/state pair
   per FR-001/FR-002; Cubit skips the event layer the rest of the migration
   standardizes on.
4. **Blocs at the composition root for cross-screen state** — matches data
   lifecycle to provider lifecycle; route-scoped providers only for state
   that dies with the route.
5. **Rebuild discipline** — all bloc states override `==`/`hashCode` via
   `Equatable` so `BlocBuilder` rebuilds only when meaningful fields change
   (value equality replaces wholesale `setState` rebuilds).

## Constitution Check re-evaluation (post-Phase 1): PASS

| Principle | Status | Evidence |
|---|---|---|
| Clean Code | PASS | Blocs own business logic; widgets presentational (FR-001) |
| Simple UX | PASS | Behavior parity frozen by FR-008 |
| Responsive Design | PASS | Visual parity verified by SC-003; no layout changes |
| Minimal Dependencies | PASS | Only `flutter_bloc` + `equatable` added, both required by FR-001/FR-002 |
| No Automated Testing | PASS | `dart format` + `flutter analyze` + manual runtime scenarios only |

---

## Phase 1: Design & Contracts

### Data Model (entities, fields, relationships)

Extracted from the current single-file implementation — entities carry over
unchanged in behavior; only their ownership moves to blocs:

**TransactionCategory**
| Field | Type | Rule |
|---|---|---|
| label | String | Non-empty display label |
| icon | IconData | Material icon for list/grid rendering |
| color | Color | Category accent |
| type | TransactionType | invariant: category type must equal owning transaction type |

**Transaction**
| Field | Type | Rule |
|---|---|---|
| id | String | Unique, non-empty |
| sequence | int | Insertion order within ledger grouping |
| category | TransactionCategory | type must match transaction type |
| description | String | Non-empty; falls back to category label |
| amountMinorUnits | int | > 0 at construction; negative rejected by assert |
| type | TransactionType | income or expense |
| createdAt | DateTime | Local time; drives ledger grouping |

**TransactionDraft** — in-progress composition state, owned by
`AddTransactionBloc` state after migration
| Field | Type | Rule |
|---|---|---|
| amountText | String | Validated by `parsePositiveMinorUnits` before save |
| type | TransactionType | drives compatible category groups |
| category | TransactionCategory? | Nullable until selected; must match type at save |
| createdAt | DateTime | defaults to now |
| eventContext | String? | optional event/campaign label |
| isMoreDetailsExpanded | bool | local disclosure state |

**DashboardSessionData** — aggregate root
| Field | Type | Rule |
|---|---|---|
| walletSummary | WalletSummary | currency code + symbol + minor units |
| transactions | List<Transaction> | unmodifiable view; source for ledger grouping |

### Event/State Families (bloc contracts)

All events and states extend `Equatable`; props fully derive from
constructor arguments (FR-002, FR-003).

- **ThemeBloc**: `ThemeModeChanged(mode)` → `ThemeState(mode)`
- **LedgerBloc**: `LedgerMonthSelected(month)`, `LedgerRefreshed(transactions)`
  → `LedgerState(visibleMonths, selectedMonth, groupedTransactions)`

Non-bloc state (status quo): the `TransactionDraft` remains local widget state
in `_AddTransactionPageState`, communicated via the existing typed route
result — no draft bloc is created.

### UI Responsiveness Contract

- No layout or accessibility behavior changes; adaptive ledger layout and
  readable controls preserved exactly.
- Rebuild scope narrows: only widgets depending on changed state rebuild
  (bloc value equality replaces wholesale `setState` screen rebuilds).
- Visual parity at every supported theme mode and text scale is mandated by
  SC-003.

### Navigation Contract

- Routing and widget composition are unchanged; only state plumbing moves.
- No file under `lib/` may import `main.dart` (FR-007).
- Draft state survives navigation (route push/pop) — no in-progress draft
  content may be lost.

### Quickstart Validation Scenarios (summary — full guide in quickstart.md)

1. Toggle theme → navigation, balance, ledger repaint without state loss.
2. Add a full transaction → appears in dashboard + ledger immediately.
3. Change transaction type with a category selected → compatibility
   enforced, never saved as a mismatched pair.
4. Navigate between screens → draft state survives route changes.
5. `flutter analyze` reports zero findings after the refactor.

### Phase 1 Attribution

- plan.md structure adapted from plan-template.md
- research.md records R1-R4 decisions with alternatives considered
- data-model.md records entity/field/validation inventories
- contracts/bloc-and-ui-contracts.md records bloc-side interface contracts

---

*Plan Complete.* Contract and quickstart artifacts follow in `contracts/` +
`quickstart.md` under this feature directory.
