# UI Contract: Type and Category Synchronization

## Category Route Entry

- The category page opens on the tab matching the form's current type.
- Each tab shows only categories in its type group.
- Switching tabs changes only temporary browsing state.

## Category Selection

- Selecting an item returns its category and owning type together.
- The main form updates type and category in one visible state change.
- Back without selecting preserves the original type/category pair.
- Selection is conveyed with icon, label, treatment, and semantics.

## Type Segmented Control

- Expense active state uses a pastel red/rose accent; Income is neutral.
- Income active state uses a pastel green/sage accent; Expense is neutral.
- Directional icons and text labels remain visible so meaning does not depend on
  color.

## Themes and Responsiveness

- Active and inactive states adapt to light, dark, and pastel themes.
- Text, icons, borders, and selected states remain readable.
- Long labels wrap or truncate safely without horizontal overflow.
- Controls remain usable at narrow widths and increased text scale.
