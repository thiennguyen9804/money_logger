# Feature Specification: Transaction Item Formatting

**Feature Branch**: `004-transaction-item-formatting`

**Created**: 2026-11-07

**Status**: Draft

**Input**: User description: "Define strict UI formatting guidelines and structural parity for transaction items across both the Dashboard preview list and the Transaction Ledger date-grouped list. Standardize right-aligned monetary values, signless visual representations, and consistent income/expense color semantics across the application."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Scan transaction amounts consistently (Priority: P1)

As a person reviewing my finances, I want transaction amounts to appear in the same position and visual format wherever transactions are shown, so I can compare entries quickly.

**Why this priority**: Consistent amount placement and formatting are essential to making both the dashboard preview and full ledger easy to scan.

**Independent Test**: Review transaction rows in both the dashboard preview and the transaction ledger, and verify that the amount is right-aligned and uses the same visual treatment in both places.

**Acceptance Scenarios**:

1. **Given** a transaction with an expense amount, **When** it appears in either transaction list, **Then** the absolute amount is displayed on the far right without a minus sign.
2. **Given** a transaction with an income amount, **When** it appears in either transaction list, **Then** the absolute amount is displayed on the far right without a plus sign.
3. **Given** transaction rows with different description lengths, **When** they are displayed, **Then** their amounts remain aligned to the same right-side boundary without clipping or overlap.

### User Story 2 - Distinguish income from expenses at a glance (Priority: P1)

As a person reviewing my finances, I want income and expenses to have consistent non-numeric visual cues, so I can understand transaction type without relying on signs.

**Why this priority**: Removing signs makes color and accessible labeling the primary way to distinguish transaction types.

**Independent Test**: Review at least one income and one expense in each transaction list and verify that their amount colors and type cues are distinct and consistent.

**Acceptance Scenarios**:

1. **Given** an expense transaction, **When** its row is displayed, **Then** its amount uses the approved soft red or rose semantic color and the row provides a non-color expense cue.
2. **Given** an income transaction, **When** its row is displayed, **Then** its amount uses the approved soft green or sage semantic color and the row provides a non-color income cue.
3. **Given** a user who cannot distinguish the semantic colors, **When** they inspect a transaction row, **Then** the transaction type remains understandable from text or another non-color cue.

### User Story 3 - Preserve parity across transaction lists (Priority: P2)

As a person moving between the dashboard and ledger, I want transaction rows to behave and look the same, so the interface feels coherent.

**Why this priority**: Cross-screen parity reduces relearning and prevents conflicting interpretations of the same transaction.

**Independent Test**: Compare equivalent transaction rows shown on the dashboard and ledger and verify matching amount alignment, typography, spacing, and type-color mapping.

**Acceptance Scenarios**:

1. **Given** the same transaction is visible in both lists, **When** the user compares the rows, **Then** amount alignment, text hierarchy, spacing, and semantic color mapping are consistent.
2. **Given** a theme change, **When** the same transaction lists are viewed, **Then** both lists retain equivalent readable contrast and semantic distinctions.

### Edge Cases

- Long descriptions or category labels must truncate or wrap without moving the amount away from the right edge or causing overflow.
- Very large amounts must remain readable and fit within the available row width on narrow screens.
- A transaction amount of zero must remain signless and use the neutral amount treatment.
- Increased text size must preserve readable separation between transaction details and the amount.
- If a list has no transactions, the existing empty-state presentation must remain clear and must not show a fabricated transaction row.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Transaction rows in the dashboard preview and transaction ledger MUST display monetary values at the right side of the row.
- **FR-002**: Transaction amounts MUST be displayed as absolute values without positive or negative prefix signs.
- **FR-003**: Expense amounts MUST use the approved soft red or rose semantic text color.
- **FR-004**: Income amounts MUST use the approved soft green or sage semantic text color.
- **FR-005**: Each transaction row MUST provide a non-color cue that identifies whether the transaction is income or expense.
- **FR-006**: Equivalent transaction rows across the dashboard and ledger MUST use consistent amount typography, alignment, spacing, and color mapping.
- **FR-007**: Transaction rows MUST preserve right-side amount alignment when descriptions or category labels vary in length.
- **FR-008**: Transaction rows MUST remain usable without clipping, overlap, or horizontal overflow on supported screen sizes and text scales.
- **FR-009**: Zero-value transactions MUST use the absolute signless format and a neutral semantic treatment.
- **FR-010**: Existing transaction details, including category, description, and date context, MUST remain available after formatting changes.
- **FR-011**: Empty transaction lists MUST retain a clear empty-state message and MUST NOT display placeholder transaction data.

### Key Entities

- **Transaction Item**: A visual representation of a transaction containing its category, description, date context, type, and monetary amount.
- **Transaction Type**: The classification of a transaction as income, expense, or neutral when the amount is zero.
- **Amount Presentation**: The displayed monetary value, including absolute numeric formatting, right-side placement, typography, and semantic color.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In a review of 20 transaction rows across the dashboard and ledger, 100% of monetary values are right-aligned to their list's common trailing boundary.
- **SC-002**: In a review of 20 income and expense rows, 100% of displayed amounts omit positive and negative prefix signs.
- **SC-003**: Users can correctly identify income versus expense from a transaction row without relying on color alone in at least 95% of manual review scenarios.
- **SC-004**: No transaction row produces clipping, overlap, or horizontal overflow at the supported narrow layout and increased text scale during manual review.
- **SC-005**: Equivalent transactions shown on both screens receive matching amount typography, spacing, alignment, and semantic color treatment in 100% of comparison scenarios.

## Assumptions

- The existing dashboard preview and transaction ledger remain the in-scope transaction list surfaces.
- Existing currency symbols, decimal precision, category details, date context, and transaction data remain unchanged.
- The application continues to use its existing light and dark visual themes.
- Soft red/rose and green/sage colors will be selected from the existing theme-aware semantic palette while maintaining readable contrast.
- Manual visual and runtime review is the validation method because the project constitution prohibits automated tests.
- Editing, sorting, persistence, and transaction-entry behavior are out of scope for this formatting feature.
