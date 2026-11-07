# UI Contract: Full-Screen Add Transaction Flow

## Main Form Route

- Add Transaction opens a dedicated full-screen page.
- The top-left control is Back or Close; the top-right control is Save.
- The amount field requests numeric/decimal input and receives focus after
  presentation.
- Tapping neutral background space unfocuses the amount field and hides the
  keyboard.
- The category field initially reads `Select Category`.

## Type Indicators

- Expense is labeled Expense, uses an up-arrow icon, and uses a soft rose/red
  treatment.
- Income is labeled Income, uses a down-arrow icon, and uses a soft sage/green
  treatment.
- Selected state is communicated by label, icon, selection shape, and semantics,
  not color alone.

## Category Route

- The category route is a full-screen secondary page with Expense and Income
  tabs or segmented sections.
- Each category item exposes its icon and title and supports long labels without
  horizontal overflow.
- Selecting an item returns to the main form and visibly fills the category
  field.
- Back without selection returns to the form with all prior draft values intact.

## Save and Cancel

- Save is enabled only when amount and category are valid.
- Invalid save keeps the form open with clear feedback.
- Valid save retains amount, type, category, date/time, and optional event
  context, updates the session, and restores the previous destination.
- Back or Close discards unsaved values and leaves the session unchanged.

## Themes, Accessibility, and Responsiveness

- Surfaces, indicators, selected states, and controls adapt to active themes.
- Every action and field has a meaningful accessible label and selected state.
- Safe areas, scrollable content, and adaptive spacing keep the header and Save
  action usable at narrow widths and increased text scale.
