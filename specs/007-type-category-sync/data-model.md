# Data Model: Type and Category Synchronization

## Transaction Type

One of `Income` or `Expense`. It controls the initial category tab and active
segment accent.

## Category

A selectable item with a label, icon, owning type group, and supporting color.
Each category belongs to exactly one type group.

## Type-Category Selection

The committed pair shown on the Add Transaction form.

| Field | Rule |
|---|---|
| `type` | Always one valid transaction type |
| `category` | Nullable while incomplete; required for save |
| compatibility | Category type must equal `type` when present |

## Category Selection Session

Temporary state owned by the category page.

| Field | Rule |
|---|---|
| `initialType` | Form type at route entry |
| `activeTab` | May change while browsing |
| `selectedCategory` | Returned only after explicit item selection |

## State Transitions

1. Open: copy the form type and category into route-entry state.
2. Browse: active tab changes locally; form state is unchanged.
3. Select: return category and owning type together.
4. Apply: update form category and type atomically.
5. Back without selection: return no result and retain the original pair.
6. Change type on form: clear or replace an incompatible category.

## Validation Rules

- Expense groups contain only Expense categories; Income groups contain only
  Income categories.
- A selected category cannot remain paired with a different type.
- A tab change alone is not a committed form change.
- Empty groups show a clear unavailable state.
