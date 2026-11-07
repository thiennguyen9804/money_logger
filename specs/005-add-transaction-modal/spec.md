# Feature Specification: Add Transaction Modal

**Feature Branch**: `005-add-transaction-modal`

**Created**: 2026-11-07

**Status**: Draft

**Input**: User description: "Define the UI layout, presentation behavior, auto-focus mechanics, and form inputs for the Add Transaction creation flow. Triggered via the central button in the primary bottom navigation bar, this screen opens as a slide-up modal designed for high-speed expense/income logging."

## Clarifications

### Session 2026-11-07

- Q: After a valid transaction is saved, where should the user be taken? → A: Close the modal and return to the previously active destination with the new transaction immediately reflected in session state.
- Q: When the Add Transaction modal first opens, which transaction type and category should be selected by default? → A: Expense with the first available category selected.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Open and begin a transaction quickly (Priority: P1)

As a person recording money activity, I want the Add Transaction flow to open as a slide-up modal with the amount field ready for typing, so I can begin logging immediately.

**Why this priority**: Fast entry is the primary purpose of the flow and removes unnecessary taps from everyday money logging.

**Independent Test**: Tap the central Add Transaction control and verify that the modal slides up, the amount field is focused automatically, and the numeric/decimal keyboard is available.

**Acceptance Scenarios**:

1. **Given** the primary navigation is visible, **When** the user taps the central Add Transaction control, **Then** a slide-up modal opens with a visible backdrop and the amount field receives focus automatically.
2. **Given** the Add Transaction modal is open, **When** the keyboard appears, **Then** it is configured for numeric and decimal entry.
3. **Given** the modal is open, **When** the user drags it downward or taps outside the sheet, **Then** the modal dismisses without saving an incomplete transaction.

### User Story 2 - Enter transaction details (Priority: P1)

As a person recording money activity, I want to choose income or expense, select a category, and review the transaction date and time, so the saved record has useful context.

**Why this priority**: Transaction type, category, and timestamp are the minimum details needed to make a money entry understandable later.

**Independent Test**: Open the modal, enter a valid amount, choose each transaction type and a category, inspect the default timestamp, and verify that the controls expose the selected values.

**Acceptance Scenarios**:

1. **Given** the modal is open with the default state, **When** the user views the form, **Then** the type selector, category selector, and date/time control are visible.
2. **Given** the modal opens, **When** the user views the default selections, **Then** Expense and the first available category are selected.
3. **Given** the user selects Income or Expense, **When** the selection changes, **Then** exactly one transaction type is visibly selected.
4. **Given** the user chooses a category, **When** the selection is applied, **Then** the chosen category is visibly identified and remains associated with the form.
5. **Given** the modal opens, **When** the user views the date/time control, **Then** it defaults to the current timestamp.
6. **Given** the date/time control is visible, **When** the user taps it, **Then** a date-time picker opens and the chosen value is reflected in the form.

### User Story 3 - Add optional context and save safely (Priority: P2)

As a person recording money activity, I want optional event details and clear validation, so I can add context when useful without accidentally saving invalid data.

**Why this priority**: Optional detail improves organization, while validation protects the transaction ledger from unusable entries.

**Independent Test**: Open the modal, expand More Details, select an event, try invalid and valid amounts, and verify save availability and the resulting transaction behavior.

**Acceptance Scenarios**:

1. **Given** the default modal view is open, **When** the user taps `More Details`, **Then** the sheet expands smoothly and reveals an event or campaign selector.
2. **Given** the amount is empty, zero, malformed, or otherwise not a positive number, **When** the user views the save control, **Then** saving is disabled or provides clear soft validation and does not create a transaction.
3. **Given** a valid positive amount is entered, **When** the user taps Save, **Then** the transaction is accepted with the selected type, category, timestamp, and optional event context.
4. **Given** the user dismisses the modal before saving, **When** the modal closes, **Then** no partial transaction is created.
5. **Given** a valid transaction is saved, **When** the save completes, **Then** the modal closes, the user returns to the previously active destination, and the new transaction is immediately reflected there.

### Edge Cases

- The keyboard must not cover the amount field, save control, or currently focused picker while the sheet is expanded.
- Long event names and category labels must remain readable without clipping or horizontal overflow.
- A date-time picker must preserve the selected value when the user returns to the form.
- Reopening the modal after dismissal must start with a clean form rather than stale unsaved values.
- Switching between light, dark, and pastel themes must preserve readable sheet, backdrop, field, selector, and keyboard-adjacent styling.
- The form must remain usable at narrow widths and increased text scale.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The primary Add Transaction control MUST open the creation flow as a slide-up modal with a dismissible backdrop.
- **FR-002**: The modal MUST automatically focus the amount field after presentation completes.
- **FR-003**: The amount field MUST request numeric and decimal keyboard input.
- **FR-004**: The modal MUST provide mutually exclusive Income and Expense selection.
- **FR-005**: The modal MUST provide a visible category selector with available category names and icons.
- **FR-006**: The date/time control MUST default to the current timestamp and allow the user to choose a different date and time.
- **FR-007**: The modal MUST provide a `More Details` control that reveals an event or campaign selector.
- **FR-008**: The save action MUST reject empty, malformed, zero, and negative amounts.
- **FR-009**: A valid save MUST retain the selected amount, transaction type, category, date/time, and optional event context.
- **FR-010**: Dismissing the modal before a valid save MUST NOT create a partial transaction.
- **FR-011**: Each newly opened modal MUST start with a clean form state.
- **FR-012**: The modal MUST adapt to active light, dark, and pastel themes with readable contrast.
- **FR-013**: The modal MUST remain usable across supported screen widths and text scale settings without clipping or horizontal overflow.
- **FR-014**: The modal MUST preserve accessible labels, selected-state feedback, focus behavior, and usable touch targets for every form control.

### Key Entities

- **Transaction Draft**: The temporary form state containing amount, type, category, date/time, and optional event context before saving.
- **Transaction Entry**: The saved money record created from a valid draft.
- **Transaction Type**: The mutually exclusive Income or Expense choice.
- **Category**: A selectable transaction classification represented by a name and icon.
- **Event Context**: Optional event or campaign information attached through More Details.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In 95% of manual opening scenarios, the user can begin entering an amount without tapping the amount field a second time.
- **SC-002**: Users can reach a valid save state from a newly opened modal in three primary interactions or fewer after entering the amount.
- **SC-003**: 100% of manual invalid-amount scenarios prevent creation of a transaction and provide clear feedback or a disabled save control.
- **SC-004**: In manual reviews across narrow and wide layouts with increased text scale, 100% of form controls remain usable without horizontal overflow or clipped essential content.
- **SC-005**: In manual light, dark, and pastel theme reviews, all modal controls and selected states remain readable and distinguishable.
- **SC-006**: In 100% of manual dismissal-before-save scenarios, no partial transaction appears in the dashboard or ledger.

## Assumptions

- The existing central bottom-navigation Add Transaction destination is the entry point for this modal.
- Existing transaction categories and in-memory session state are reused.
- The initial form selection is Expense with the first available category.
- The default timestamp is the device's current local date and time.
- Event and campaign choices are available from a small in-memory list for the initial flow; creating new events is out of scope.
- Save behavior updates the existing session transaction list, closes the modal, and returns the user to the previously active destination.
- Automated tests remain out of scope because the project constitution prohibits unit, integration, and end-to-end tests.
- Persistence, synchronization, recurring transactions, attachments, and editing existing transactions are out of scope.
