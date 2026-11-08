# Research: Type and Category Synchronization

## Decision: Open category selection on the current transaction type

**Rationale**: The Add Transaction form owns the authoritative current type.
Passing that type into category selection makes the initial tab deterministic
and avoids showing irrelevant choices.

**Alternatives considered**:

- Always open Expense: rejected because it ignores the current selection.
- Infer from the last category: rejected because it can conflict with a newly
  selected type.

## Decision: Commit only an explicitly selected category

**Rationale**: A selected item is an explicit user action and can carry its
category type back to the form. Backing out returns no selection, so temporary
tab changes cannot mutate the draft.

**Alternatives considered**:

- Return the active tab on every exit: rejected because browsing is not
  confirmation.
- Mutate shared draft state while browsing: rejected because cancellation must
  preserve the original pair.

## Decision: Treat category type as authoritative on selection

**Rationale**: Each category belongs to exactly one type group. Applying both
category and type together prevents an incompatible pair.

**Alternatives considered**:

- Reject selections from the other tab: rejected because cross-tab selection is
  explicitly supported.
- Keep the prior type: rejected because it allows a mismatch.

## Decision: Use contextual active styling and neutral inactive styling

**Rationale**: Income and Expense require distinct accents, while neutral
inactive styling avoids suggesting both choices are active. Labels and icons
provide meaning beyond color.

**Alternatives considered**:

- Hard-coded colors in every theme: rejected because contrast can fail.
- Color-only feedback: rejected by the accessibility requirement.

## Decision: Keep behavior in existing Flutter primitives

**Rationale**: Existing draft, route, segmented control, category, and theme
APIs provide the integration points without a package.

**Alternatives considered**:

- Add a state-management or UI package: rejected under minimal dependencies.
