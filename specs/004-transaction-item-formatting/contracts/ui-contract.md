# UI Contract: Transaction Item Formatting

## Shared Transaction Row

Both the dashboard recent-transactions preview and the transaction ledger must
render transaction rows with equivalent presentation rules.

### Required content

- Category icon remains visible.
- Description remains visible, with safe truncation or wrapping for long text.
- Category or date context remains visible according to the containing list.
- Monetary amount is visible at the trailing/right side.
- Amount has no `+` or `-` prefix.
- Income and expense have explicit non-color type cues.

### Amount presentation

- Income uses the theme's readable positive semantic color.
- Expense uses the theme's readable negative semantic color.
- Zero-value amounts use a neutral semantic color.
- Typography, weight, alignment, and trailing spacing remain equivalent between
  dashboard and ledger rows.

### Responsive behavior

- Detail text may shrink, truncate, or wrap before the amount loses its trailing
  boundary.
- Rows must not clip, overlap, or create horizontal scrolling at narrow widths.
- Increased text scale must preserve separation between details and amount.

### Accessibility and themes

- Type meaning remains understandable from text or another non-color cue.
- Light and dark themes preserve readable contrast for all amount states.
- Existing semantic labels and touch targets remain available.

## Empty States

Existing empty-state messages remain unchanged and no placeholder transaction
rows are introduced.
