# Data Model: Dashboard Overview

The dashboard uses session-only data. No entity is persisted by this feature.

## WalletSummary

Represents the aggregate balance shown in the balance card.

| Field | Type | Rules |
|---|---|---|
| amount minor units | integer | Required; supports zero and negative balances without floating-point arithmetic |
| currency code | configured text | Required for formatting; uses the existing application default when no preference exists |
| currency symbol | configured text | Required for the initial display convention |

## Transaction

Represents one income or expense record.

| Field | Type | Rules |
|---|---|---|
| id | stable text | Required; unique within the session |
| sequence | integer | Required; stable tie-breaker for equal timestamps |
| category | category metadata | Required; supplies the color-coded icon |
| description | text | Required; merchant or transaction description |
| amount minor units | integer | Required; stored as an absolute value |
| type | income or expense | Required; controls sign and semantic styling |
| created at | timestamp | Required; authoritative recent ordering value |

## BalanceVisibilityState

Controls whether the balance card renders its amount.

| Value | Meaning |
|---|---|
| visible | Render the formatted currency amount |
| masked | Render only a non-numeric mask such as `••••••` |

The state is session-scoped and MUST NOT be included in the masked accessible
label as a numeric amount.

## DashboardRecentActivity

Derived view data containing at most three transactions:

1. Copy the session transaction collection.
2. Sort by `created at` descending.
3. Break equal timestamps by stable `sequence` descending.
4. Take the first three records.

The source transaction collection MUST NOT be mutated by this derivation.

## Relationships and Invariants

- `WalletSummary` is the aggregate represented by the balance card.
- `DashboardRecentActivity` references existing `Transaction` records.
- A transaction amount is always rendered with a `+` sign for income and `-` for
  expense.
- The dashboard shows all available records when fewer than three exist.
- The dashboard shows an explicit empty state when no records exist.
- The balance visibility state survives navigation and theme changes during the
  current session.
