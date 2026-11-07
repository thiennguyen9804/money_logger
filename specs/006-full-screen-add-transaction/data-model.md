# Data Model: Full-Screen Add Transaction Flow

## Transaction Draft

Local unsaved state owned by the full-screen form.

| Field | Type | Rules |
|---|---|---|
| `amountText` | string | Parsed as a positive amount before save |
| `type` | Income or Expense | Exactly one value; retains the user's selection |
| `category` | optional category | Null initially; required before a valid save |
| `createdAt` | local date/time | Preserved from the existing form flow |
| `eventContext` | optional event | Preserved when selected |
| `focusedField` | amount or none | Amount receives focus after route presentation; neutral taps clear it |

## Category Selection

| Field | Type | Rules |
|---|---|---|
| `activeTab` | Expense or Income | Determines the visible category collection |
| `categories` | category list | Each item has a title, icon, and type grouping |
| `selectedCategory` | optional category | Selecting it returns to the form and fills the category field |

## Transaction Entry

Created only after valid Save.

- Amount is converted to positive absolute minor units.
- Selected type, category, local date/time, and optional event context are
  retained.
- The session receives one entry and the previous destination is restored.

## State Transitions

1. **Opened**: create a clean draft with empty amount, Expense type, no
   category, current date/time, and no focused field until presentation ends.
2. **Focused**: focus amount and show numeric/decimal keyboard.
3. **Editing**: update amount, type, category, date/time, and event context.
4. **Selecting Category**: navigate to category route while retaining the draft.
5. **Category Selected**: return selected category to the form.
6. **Unfocused**: neutral tap clears amount focus and hides the keyboard.
7. **Invalid**: retain the draft and show clear validation; do not save.
8. **Saved**: append one transaction, close the route, and restore the prior
   destination.
9. **Cancelled**: close the route and discard the draft.

## Validation Rules

- Amount must be positive and parseable.
- Category is required before Save.
- Type is always selected.
- Cancellation and route back never commit partial data.
