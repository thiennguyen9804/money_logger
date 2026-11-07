# Research: Full-Screen Add Transaction Flow

## Decision: Use a dedicated full-screen route with a local draft

**Rationale**: A route provides the requested full-screen workspace and lets the
system handle back navigation, safe areas, and keyboard layout. Keeping draft
values local to the form prevents partial data from reaching the session when
the user backs out.

**Alternatives considered**:

- Keep the bottom sheet and expand it to full height: rejected because the
  feature explicitly replaces the sheet with a dedicated route.
- Mutate session state during editing: rejected because cancellation must never
  create a partial transaction.

## Decision: Use a second route for category selection

**Rationale**: A dedicated category screen gives the user a focused grid/list
and supports separate Expense and Income tabs without crowding the form.
Returning a selected category through route completion preserves the main form
draft.

**Alternatives considered**:

- Inline expansion below the category field: rejected because the requirement
  calls for direct navigation to a secondary screen.
- A dialog: rejected because it is less suitable for long labels and narrow
  screens.

## Decision: Use semantic directional indicators with soft theme-aware colors

**Rationale**: Expense and Income must be distinguishable through icon direction
and labels as well as color. Soft red/rose and green/sage treatments communicate
meaning while remaining adaptable to the active theme.

**Alternatives considered**:

- Color-only type selection: rejected by the accessibility requirement.
- Hard-coded colors in all themes: rejected because contrast can fail in dark
  or pastel palettes.

## Decision: Dismiss focus through an outer gesture detector

**Rationale**: A neutral background tap can unfocus the amount field and hide
the keyboard without affecting controls that need their own gestures. The form
remains scrollable and keyboard-safe.

**Alternatives considered**:

- Require the keyboard action button: rejected because it does not support the
  requested neutral-background behavior.
- Dismiss focus on every tap: rejected because it interferes with form fields.

## Decision: Reuse the current session, validation, and dependency-free Flutter primitives

**Rationale**: The existing transaction model and positive amount validation
already satisfy the session contract. Flutter's routes, tabs, focus nodes,
pickers, semantics, and theme APIs cover the feature without a package.

**Alternatives considered**:

- Add a navigation or category package: rejected under the minimal-dependency
  principle.
- Introduce persistence: rejected because this feature only changes entry UX.
