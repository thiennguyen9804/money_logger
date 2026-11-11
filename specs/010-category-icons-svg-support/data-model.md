# Data Model: Category Icons and SVG Support

## Category

Represents one of the application's predefined transaction categories.

| Field | Type | Required | Meaning and constraints |
|---|---|---:|---|
| `id` | String | Yes | Existing unique category identifier; unchanged by this feature. |
| `label` | String | Yes | Existing display label; unchanged. |
| `type` | TransactionType | Yes | Existing income or expense classification; unchanged. |
| `icon` | IconData | Yes | Native icon retained for existing behavior and as fallback when an SVG is missing or invalid. |
| `iconAssetPath` | String? | No | Optional path to an app-bundled SVG under `assets/icons/`; null means render the native icon. |

### Relationships

- Each `ExpenseCategory` and `IncomeCategory` is a `Category` and may reference one bundled SVG.
- Transactions refer to their existing `Category`; they do not copy or persist icon data.
- SVG artwork is packaged with the app and referenced by its asset path; users do not add or assign assets.

### Validation and rendering rules

1. Category IDs remain unique under existing category-list rules.
2. A non-null `iconAssetPath` must identify a registered bundled asset under `assets/icons/`.
3. If an asset path is null, render `icon`.
4. If an asset path is set and loads, render the SVG.
5. If an asset path is set but fails to load or parse, render `icon` and keep the category row available.
6. Icon content is constrained within the shared badge; badge colors and icon tint must remain legible in light and dark themes.

## Category icon badge

A presentation-only widget derived from the category plus requested size/style context. It is not stored in category or transaction data.

- Inputs: category's native icon, optional SVG path, optional badge dimensions/style overrides if required by existing surfaces.
- Output: circular or rounded colored badge with centered artwork and a native fallback.
- No persistence, lifecycle, or state transitions.