# Data Model: Add Transaction Modal

## Transaction Draft

Temporary state owned by one open modal session.

| Field | Type | Rules |
|---|---|---|
| `amountText` | string | Raw editable input; must parse to a positive number before save |
| `type` | Income or Expense | Exactly one value; defaults to Expense |
| `category` | category value | Required selection; defaults to the first available category |
| `createdAt` | local date/time | Defaults to the current timestamp; editable through date/time selection |
| `eventContext` | optional event value | Null until More Details is expanded and an event is selected |
| `isMoreDetailsExpanded` | boolean | Starts false; controls optional event field visibility |

## Transaction Entry

The existing saved transaction model created from a valid draft.

| Field | Source | Rules |
|---|---|---|
| `amountMinorUnits` | parsed `amountText` | Positive, absolute integer minor units |
| `type` | draft type | Preserved exactly |
| `category` | draft category | Preserved exactly |
| `createdAt` | draft date/time | Preserved exactly |
| `eventContext` | draft event context | Preserved when selected; otherwise absent |

## State Transitions

1. **Opened**: initialize a clean draft with Expense, first category, current
   timestamp, empty amount, and collapsed More Details.
2. **Editing**: update draft fields without changing the saved session list.
3. **Expanded**: reveal event context while retaining all existing draft values.
4. **Invalid**: keep the draft unsaved and show disabled-save or clear validation.
5. **Saved**: create one transaction entry, update session state, close the
   modal, and return to the previously active destination.
6. **Dismissed**: discard the draft and leave session state unchanged.

## Validation Rules

- Empty, malformed, zero, and negative amounts cannot be saved.
- Amount parsing must preserve decimal precision required by the existing
  currency representation.
- A selected category and transaction type are always present in the draft.
- Dismissal never commits a partial draft.
