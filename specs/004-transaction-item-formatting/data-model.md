# Data Model: Transaction Item Formatting

## Transaction Item

The existing transaction record rendered in either list.

| Field | Type | Rules |
|---|---|---|
| `id` | string | Existing stable identifier |
| `category` | category value | Existing icon, label, and category color |
| `description` | string | Preserved; may truncate or wrap |
| `amountMinorUnits` | non-negative integer | Rendered as an absolute currency value |
| `type` | income or expense | Determines semantic color and explicit type cue |
| `createdAt` | date/time | Preserved for list-specific date context |

## Amount Presentation

Derived from a transaction and wallet currency settings.

| Attribute | Rule |
|---|---|
| Numeric value | Absolute currency amount with existing symbol and precision |
| Prefix sign | Never shown |
| Alignment | Trailing/right aligned within the row |
| Income color | Theme-aware positive semantic color |
| Expense color | Theme-aware negative semantic color |
| Zero color | Neutral theme-aware text color |
| Type cue | Visible `Income`, `Expense`, or neutral treatment where applicable |

## Relationships

- Each transaction item has one amount presentation.
- The same transaction item may appear in the dashboard preview and ledger.
- Both list surfaces use the same presentation rules.

## Validation Rules

- Amounts remain non-negative at the transaction data boundary.
- Display formatting must not mutate transaction data.
- Descriptions, categories, and date context remain available.
- Layout adapts to narrow width and increased text scale without clipping or
  horizontal overflow.
