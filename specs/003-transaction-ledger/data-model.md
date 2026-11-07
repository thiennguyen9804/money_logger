# Data Model: Transaction Ledger

The ledger uses session-only data and derives view state from the existing
transaction collection. No entity is persisted by this feature.

## LedgerMonth

Represents one selectable calendar month.

| Field | Type | Rules |
|---|---|---|
| year | integer | Required; part of calendar identity |
| month | integer | Required; must be between 1 and 12 |
| label | display text | Derived from year/month for the active locale |

Months are ordered chronologically. The latest transaction month is selected
initially; if no transactions exist, the current local month is selected.

## SelectedMonthState

Represents the month currently applied to the ledger filter.

| Field | Type | Rules |
|---|---|---|
| year | integer | Required; matches a LedgerMonth |
| month | integer | Required; matches a LedgerMonth |

Changing this state updates visible groups without leaving the destination.

## LedgerTransaction

References an existing session `Transaction` and exposes category, description,
amount minor units, income/expense type, creation timestamp, sequence, and ID.
The amount is absolute; income renders with `+` and expense with `-`.

## TransactionDateGroup

Represents selected-month records for one local calendar date.

| Field | Type | Rules |
|---|---|---|
| date | local calendar date | Required; year/month/day identity |
| transactions | ordered list | Required; newest first with deterministic ties |
| daily net total minor units | integer | Income sum minus expense sum |

Date groups are ordered newest first. The source collection must not be mutated
while deriving groups.

## Derived Relationships and Invariants

- Every displayed transaction belongs to the selected year and month.
- A date group exists only when at least one matching transaction exists.
- A daily net total equals income minus expense for that local date.
- Equal timestamps are ordered by sequence descending, then ID descending.
- An empty selected month has zero groups and displays exactly:
  `No transactions recorded for this month.`
- Long descriptions and category labels remain usable without hiding the signed
  amount.
