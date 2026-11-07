# UI Contract: Dashboard Overview

## Balance Card

The Dashboard MUST display a high-visibility card before the recent activity list.

| Element | Contract |
|---|---|
| Label | `Current Balance` or `Net Worth` |
| Amount | Formatted wallet aggregate using the configured currency convention |
| Privacy control | One action toggles visible amount and non-numeric mask |
| Detail action | Opens wallet breakdown only when that destination is available |
| Styling | Uses an accessible pastel accent treatment in the active theme |

When masked, the card MUST NOT render numeric balance digits in visible text or
accessible semantics.

## Recent Transactions

The section header is `Recent Transactions` and includes a `View All` action.

Each displayed row contains:

- a category icon with color-coded, theme-readable styling;
- a merchant or description;
- a date or relative timestamp;
- a signed formatted amount.

The list contains at most three records, ordered by creation timestamp descending
with a stable tie-breaker. Expense rows use a minus sign and expense styling;
income rows use a plus sign and income styling. With no records, the section shows
a clear empty state and keeps View All available.

## Navigation

- `View All` selects the existing Transactions destination in one action.
- Dashboard remains the first primary destination.
- The balance visibility choice remains unchanged when navigating away and returning.

## Responsive and Theme Behavior

- Balance content, recent rows, and actions remain usable at narrow and wide
  viewports.
- Long descriptions wrap or truncate without hiding the signed amount.
- Increased text scales do not clip labels, amounts, or actions.
- Light, dark, and pastel accent treatments maintain readable contrast.
