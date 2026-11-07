# UI Contract: Transaction Ledger

## Balance Header

- Transactions displays the current aggregate wallet balance before the month
  selector and transaction groups.
- The balance uses the existing currency convention and remains available while
  ledger content scrolls.
- Existing session privacy masking remains effective without numeric leakage.

## Month Selector

- A horizontally scrollable selector displays available months chronologically.
- Each month has a readable month/year label.
- Exactly one month is selected at a time.
- The selected month uses the active accent with readable contrast.
- Tapping or swiping to a month updates the ledger in one interaction.
- The selector remains usable at narrow widths and increased text scale.

## Date Groups

- Groups appear newest date first.
- Each group has a distinct date heading and daily net total.
- Date headings remain visually distinct from transaction rows.

## Transaction Rows

- Each row includes category icon, description/merchant, category label, and
  signed formatted amount.
- Income uses a plus sign and theme-readable income styling.
- Expense uses a minus sign and theme-readable expense styling.
- Rows within a group are newest first with deterministic equal-time ordering.
- Long text wraps or truncates without hiding the signed amount.

## Empty and Boundary States

- A selected month with no records shows exactly:
  `No transactions recorded for this month.`
- The empty state does not fabricate groups or rows.
- Months with one or two records show every available record.
- A zero daily total remains visible and readable.

## Responsive and Accessibility Behavior

- Balance, selector, group headings, rows, and empty state remain usable on
  narrow and wide supported screens.
- Month controls expose clear selected semantics and usable touch targets.
- Amount signs and colors are not the sole means of distinguishing income and
  expense.
- Increased text scales do not clip headings, labels, amounts, or controls.
- Light, dark, and pastel accents maintain readable contrast.
