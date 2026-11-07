# Feature Specification: Full-Screen Add Transaction Flow

**Feature Branch**: `006-full-screen-add-transaction`

**Created**: 2026-11-07

**Status**: Draft

**Input**: User description: "Enhance the existing Add Transaction creation experience by migrating from a modal bottom sheet to a dedicated full-screen navigation route. Update focus behavior, add directional Income/Expense styling, and make category selection a dedicated two-tab screen."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Enter a transaction on a dedicated screen (Priority: P1)

As a person recording money activity, I want Add Transaction to open as a
dedicated full-screen page, so I can review the form without a constrained
bottom sheet.

**Why this priority**: The full-screen flow is the primary architectural change
and provides the foundation for every other interaction in this feature.

**Independent Test**: Open Add Transaction from the central navigation control
and verify a full-screen page with a Back/Close action and Save action appears.

**Acceptance Scenarios**:

1. **Given** the primary navigation is visible, **When** the user taps Add
   Transaction, **Then** a dedicated full-screen page replaces the prior view.
2. **Given** the Add Transaction page is open, **When** the user taps Back or
   Close, **Then** the page closes without saving an incomplete transaction.
3. **Given** the Add Transaction page is open, **When** the user taps Save with
   valid details, **Then** the transaction is saved and the user returns to the
   previously active destination.

### User Story 2 - Choose type and category with clear visual meaning (Priority: P1)

As a person recording money activity, I want clear directional styling and a
dedicated category picker, so I can understand and choose the transaction type
and category quickly.

**Why this priority**: Correct type and category selection is essential for
understandable ledger entries.

**Independent Test**: Open the page, switch type indicators, open the category
field, switch between the two category tabs, select an item, and verify the
choice appears on the main form.

**Acceptance Scenarios**:

1. **Given** the form is open, **When** the user views Expense, **Then** it has
   an up-arrow indicator and soft pastel red/rose styling.
2. **Given** the form is open, **When** the user views Income, **Then** it has
   a down-arrow indicator and soft pastel green/sage styling.
3. **Given** no category has been chosen, **When** the user views the category
   field, **Then** an empty Select Category placeholder is shown.
4. **Given** the category field is visible, **When** the user taps it, **Then**
   a dedicated category screen opens with Expense and Income tabs.
5. **Given** a category tab is open, **When** the user selects a category,
   **Then** the category screen closes and the selected icon and title appear
   in the form.

### User Story 3 - Start typing and manage focus naturally (Priority: P2)

As a person recording money activity, I want the amount field ready when the
page opens and easy to unfocus, so entry remains fast without trapping focus.

**Why this priority**: Fast amount entry is central to the logging experience,
while predictable unfocus behavior prevents keyboard obstruction.

**Independent Test**: Open the page, verify the numeric keyboard is available,
then tap neutral background space and verify focus and keyboard are dismissed.

**Acceptance Scenarios**:

1. **Given** the full-screen page opens, **When** presentation completes, **Then**
   the amount field receives focus and the numeric keyboard appears.
2. **Given** the amount field is focused, **When** the user taps empty or neutral
   page space, **Then** the amount field loses focus and the keyboard hides.

### Edge Cases

- Back or Close must discard incomplete data and leave the session unchanged.
- Returning from the category screen must preserve the amount, type, and other
  draft values.
- Category lists with long labels must remain readable without horizontal
  overflow.
- The selected category tab must remain predictable when switching between
  Expense and Income.
- Light, dark, and pastel themes must preserve readable contrast for both type
  indicators and selected categories.
- Narrow screens and increased text scale must keep the header, form controls,
  category field, and Save action usable.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Add Transaction control MUST open a dedicated full-screen
  creation page instead of a bottom sheet.
- **FR-002**: The full-screen page MUST provide a Back or Close action on the
  top-left and a Save action on the top-right.
- **FR-003**: Tapping Back or Close before a valid save MUST discard the draft
  and leave the existing transaction session unchanged.
- **FR-004**: A valid Save MUST update the session with the selected amount,
  type, category, date/time, and optional event context, then return to the
  previously active destination.
- **FR-005**: The Expense type indicator MUST use an up-arrow icon and soft
  pastel red or rose visual styling.
- **FR-006**: The Income type indicator MUST use a down-arrow icon and soft
  pastel green or sage visual styling.
- **FR-007**: The form MUST show a Select Category placeholder until a category
  is chosen.
- **FR-008**: Tapping the category field MUST open a dedicated category
  selection page with separate Expense and Income tabs or segmented sections.
- **FR-009**: The category selection page MUST show category icons and titles,
  highlight the selected item, and return the selection to the form.
- **FR-010**: The amount field MUST receive focus after full-screen presentation
  completes and request numeric/decimal keyboard input.
- **FR-011**: Tapping neutral background space MUST remove amount focus and hide
  the soft keyboard.
- **FR-012**: The form MUST retain draft values when returning from category
  selection.
- **FR-013**: The feature MUST remain usable across supported widths and text
  scales without clipping or horizontal overflow.
- **FR-014**: The feature MUST adapt its surfaces, controls, selected states,
  and directional indicators to light, dark, and pastel themes.
- **FR-015**: Every interactive control MUST expose a meaningful accessible
  label and selected state beyond color alone.

### Key Entities

- **Transaction Draft**: Unsaved amount, type, category, date/time, and optional
  event details held while the full-screen form is open.
- **Transaction Type Indicator**: The selected Income or Expense state with its
  directional icon and semantic color treatment.
- **Category Selection**: A category title and icon grouped under an Expense or
  Income tab.
- **Transaction Entry**: The saved record created when the draft passes
  validation.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In at least 95% of manual opening scenarios, users can begin
  entering the amount without a second tap.
- **SC-002**: Users can reach either category list and return with a selected
  category in no more than three primary taps after opening the form.
- **SC-003**: 100% of manual Back, Close, and neutral-background dismissal
  scenarios leave incomplete drafts unsaved.
- **SC-004**: 100% of manual reviews across narrow and wide layouts and
  increased text scale keep all essential controls usable without horizontal
  overflow.
- **SC-005**: In manual light, dark, and pastel theme reviews, Expense and
  Income indicators remain distinguishable and readable without relying on
  color alone.

## Assumptions

- The existing Add Transaction control remains the entry point.
- The current in-memory transaction session and amount validation are reused.
- The category selection screen starts with a fixed set of existing and
  representative in-memory categories; creating categories is out of scope.
- Date/time and More Details behavior from the current Add Transaction flow
  remains available unless explicitly replaced by this feature.
- The previously active destination is restored after a successful save.
- Automated tests remain out of scope under the project constitution.
- Persistence, synchronization, recurring transactions, attachments, and
  editing existing transactions remain out of scope.
