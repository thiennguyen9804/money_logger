# Data Model: BLoC and SegmentedButton Architecture Refactor

Entities are carried over unchanged from the pre-refactor implementation;
only their ownership moves from widget state to blocs. Field-level rules are
quoted to prevent implementation-time drift.

## TransactionType

```text
enum TransactionType { income, expense }
```

No change. Used as the type argument for `SegmentedButton<TransactionType>`.

## TransactionCategory

Cross-screen shared model (used by add_transaction, category_selection, dashboard).

| Field | Type | Rule |
|---|---|---|
| label | String | Non-empty display label |
| icon | IconData | Material icon |
| color | Color | Category accent |
| type | TransactionType | invariant: owning group type |

Equality: structural (existing semantics preserved — categories are const).

## TransactionDraft

Owned by `_AddTransactionPageState` (local widget state — status quo per R2).
Draft editing stays in widget `State` with `setState`; no
`AddTransactionBloc` is created. The committed `Transaction` returns to the
session via the existing typed route result (`Navigator.pop`).

| Field | Type | Rule |
|---|---|---|
| amountText | String | Must pass `parsePositiveMinorUnits` before save |
| type | TransactionType | drives compatible category group |
| category | TransactionCategory? | Nullable while incomplete; type must equal `type` when present |
| createdAt | DateTime | defaults to now |
| eventContext | String? | optional event/campaign label |
| isMoreDetailsExpanded | bool | local disclosure state |

Validation rules (unchanged from spec 007):
- Category must belong to the matching type group at save.
- Changing type clears or replaces an incompatible selected category.

## Transaction

| Field | Type | Rule |
|---|---|---|
| id | String | non-empty |
| sequence | int | insertion order |
| category | TransactionCategory | required |
| description | String | non-empty |
| amountMinorUnits | int | >= 0 |
| type | TransactionType | income or expense |
| createdAt | DateTime | local time; drives ledger grouping |

## LedgerMonth

| Field | Type | Rule |
|---|---|---|
| year | int | 1-9999 |
| month | int | 1-12 |

Derived grouping used to filter the ledger view.

## Event/State Families (bloc contracts)

### ThemeBloc
- Events: `ThemeModeChanged(mode)`
- State: `ThemeState(mode)` — Equatable

### CategorySelectionBloc

Dropped — category selection communicates via typed route results
(`Navigator.pop`), matching the status quo. No bloc is created.

### LedgerBloc

- Events: `LedgerMonthSelected(month)`, `LedgerRefreshed(transactions)`
- State: `LedgerState(visibleMonths, selectedMonth, groupedTransactions)` — Equatable

## Invariants (unchanged)

- Category type must equal draft type at save.
- Changing type clears or replaces an incompatible category.
- Tab changes alone are not committed form changes.
- Empty category groups show a clear unavailable state.

---

*Contract note: bloc-level interface contracts are documented in this file and apply to all screens; widget-facing behavior contracts are in `contracts/`.*
