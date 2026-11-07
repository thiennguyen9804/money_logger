# UI Contract: Add Transaction Modal

## Entry and Presentation

- The central Add Transaction navigation control opens a slide-up modal.
- A visible backdrop allows outside-tap dismissal.
- A downward drag dismisses the modal without saving an incomplete draft.
- Each opening creates a clean draft with Expense and the first available
  category selected.

## Amount and Keyboard

- The amount input is visually prominent and automatically focused after the
  modal finishes presenting.
- The keyboard requests numeric and decimal entry.
- The form moves or scrolls with keyboard insets so the focused field and Save
  control remain reachable.

## Required Controls

- Exactly one Income or Expense option is selected.
- Category choices show names and icons; the selected category is apparent.
- Date/time shows the current timestamp initially and reflects picker changes.
- Save is disabled or clearly invalid for empty, malformed, zero, or negative
  amounts.

## Progressive Details

- `More Details` is visible in the default view.
- Activating it expands the sheet and reveals an event or campaign selector.
- Long event and category names adapt without clipping or horizontal overflow.

## Save and Dismissal

- A valid save creates one transaction with all selected draft values.
- Save updates session state, closes the modal, and returns to the previously
  active destination.
- Dismissal discards the draft and leaves the session transaction list unchanged.

## Accessibility, Themes, and Responsive Behavior

- Every field and action has a meaningful accessible label.
- Selected type, category, and event values are conveyed beyond color alone.
- Light, dark, and pastel themes retain readable contrast.
- Touch targets remain usable at narrow widths and increased text scale.
