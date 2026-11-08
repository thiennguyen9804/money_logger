# Feature Specification: Type and Category Synchronization

**Feature Branch**: `007-type-category-sync`

**Created**: 2026-11-07

**Status**: Draft

**Input**: User description: "Enhance state synchronization between transaction type and category selection across the Add Transaction screen and Category Selection screen, and define theme-aware active colors for the Income/Expense segmented control."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Filter categories from the selected type (Priority: P1)

As a person recording money activity, I want category selection to open in the
same type I selected, so I see relevant choices immediately.

**Why this priority**: Showing the correct category group prevents invalid
combinations and reduces navigation effort.

**Independent Test**: Select Expense, open categories, verify the Expense group
is active; repeat with Income and verify the Income group is active.

**Acceptance Scenarios**:

1. **Given** Expense is selected on the Add Transaction screen, **When** the
   user opens category selection, **Then** the Expense category group is active.
2. **Given** Income is selected on the Add Transaction screen, **When** the user
   opens category selection, **Then** the Income category group is active.
3. **Given** a category is already selected, **When** the user changes type,
   **Then** the selected category is cleared or replaced so it cannot conflict
   with the new type.

### User Story 2 - Synchronize a selected category back to type (Priority: P1)

As a person recording money activity, I want choosing a category from another
type to update the transaction type, so the final entry always reflects my
confirmed category choice.

**Why this priority**: The selected category is an explicit user decision and
must remain consistent with the transaction type.

**Independent Test**: Open categories, switch tabs, select a category from the
other type, and verify the main form changes to that category's type.

**Acceptance Scenarios**:

1. **Given** the category screen is open, **When** the user switches to the
   other type and selects a category, **Then** the main form type changes to
   match the selected category.
2. **Given** the category screen tab changed, **When** the user returns without
   selecting a category, **Then** the original main-form type and category are
   retained.
3. **Given** a category is selected, **When** the user returns to the main form,
   **Then** the selected category remains visible and matches the active type.

### User Story 3 - Understand type selection through contextual styling (Priority: P2)

As a person recording money activity, I want the active type to use a clear
contextual accent, so I can identify the selected state in any theme.

**Why this priority**: Distinct active styling reinforces the meaning of the
selection while preserving a neutral inactive state.

**Independent Test**: Toggle Income and Expense in light, dark, and pastel
themes and verify the active segment changes accent while the inactive segment
remains neutral.

**Acceptance Scenarios**:

1. **Given** Income is selected, **When** the segmented control is displayed,
   **Then** Income uses the pastel green/sage active accent and Expense remains
   neutral.
2. **Given** Expense is selected, **When** the segmented control is displayed,
   **Then** Expense uses the pastel red/rose active accent and Income remains
   neutral.
3. **Given** any supported theme, **When** the type changes, **Then** active and
   inactive states remain readable and distinguishable without color alone.

### Edge Cases

- Changing type with an incompatible selected category must never leave a
  mismatched pair.
- Returning from category selection without choosing an item must not propagate
  a temporary tab change.
- Selecting a category from either tab must update type and category together.
- Empty category groups must show a clear unavailable state without crashing.
- Long category names must remain readable without clipping or horizontal
  overflow.
- Active and inactive styling must preserve contrast in light, dark, and pastel
  themes.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The category selection screen MUST initially show the category
  group matching the transaction type on the Add Transaction screen.
- **FR-002**: Expense and Income category groups MUST contain only categories
  valid for their respective type.
- **FR-003**: Selecting a category MUST update the main form's selected category
  and transaction type together.
- **FR-004**: Returning from category selection without selecting a category
  MUST preserve the original transaction type and category.
- **FR-005**: Changing transaction type MUST clear or replace any incompatible
  selected category before a save can complete.
- **FR-006**: The active Income segment MUST use a pastel green or sage accent
  for its background, border, and text highlight.
- **FR-007**: The active Expense segment MUST use a pastel red or rose accent
  for its background, border, and text highlight.
- **FR-008**: The inactive segment MUST retain neutral styling while the other
  segment is active.
- **FR-009**: Type and category changes MUST update the visible form
  reactively across navigation transitions.
- **FR-010**: Active and inactive states MUST remain readable across light, dark,
  and pastel themes and MUST not rely on color alone.
- **FR-011**: Category selection MUST remain usable across supported widths and
  text scales without clipping or horizontal overflow.

### Key Entities

- **Transaction Type**: The Income or Expense choice controlling valid category
  groups and active segment styling.
- **Category**: A type-bound label and icon that can be selected in the matching
  category group.
- **Type-Category Selection**: The synchronized pair displayed on the main form.
- **Category Selection Session**: Temporary tab state that is committed only
  when the user selects a category.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In 100% of manual checks, opening category selection starts on
  the category group matching the current transaction type.
- **SC-002**: In 100% of manual cross-tab selections, the returned category and
  transaction type match.
- **SC-003**: In 100% of manual back-without-selection scenarios, the original
  type and category remain unchanged.
- **SC-004**: In 100% of manual theme reviews, the active segment is visibly
  distinct, the inactive segment remains neutral, and labels remain readable.
- **SC-005**: In 100% of manual narrow-width and increased-text-scale reviews,
  category labels and type controls remain usable without horizontal overflow.

## Assumptions

- The existing full-screen Add Transaction and Category Selection flows remain
  the entry points.
- Existing in-memory categories are assigned to Expense or Income groups; adding
  or editing categories is out of scope.
- Transaction validation and save behavior remain unchanged except for the
  synchronized type/category requirement.
- Temporary tab changes are not committed until a category is selected.
- No persistence, synchronization service, or new dependency is required.
- Automated tests remain out of scope under the project constitution.
