# Feature Specification: Transaction Ledger

**Feature Branch**: `003-transaction-ledger`

**Created**: 2026-11-07

**Status**: Draft

**Input**: User description: "Feature Specification: Transaction Ledger Screen - Hierarchical Grouping & Monthly Carousel"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Review the transaction ledger (Priority: P1)

As a money logger user, I want to open a complete transaction ledger so that I
can review my financial history beyond the dashboard preview.

**Why this priority**: A complete history is the primary purpose of the ledger
and provides the foundation for all filtering and grouping interactions.

**Independent Test**: Open the Transactions destination with a session containing
transactions and verify that the current balance remains visible while the
ledger lists transactions grouped by calendar date.

**Acceptance Scenarios**:

1. **Given** a session with transactions, **When** the user opens Transactions,
   **Then** the current aggregate wallet balance is visible above the ledger.
2. **Given** transactions on multiple calendar dates, **When** the ledger is
   displayed, **Then** records are grouped under distinct date headings in
   newest-date-first order.
3. **Given** a date group, **When** it is displayed, **Then** its heading shows
   the formatted date and the net amount for that date.
4. **Given** a transaction record, **When** it is displayed, **Then** the row
   shows its category visual, description, category label, date context, and
   signed amount.

---

### User Story 2 - Browse transactions by month (Priority: P1)

As a money logger user, I want to choose a month from a chronological month
selector so that I can focus on the transactions for that period.

**Why this priority**: Monthly filtering is the main way users narrow a complete
history into a manageable period for review.

**Independent Test**: Open Transactions with records from several months, choose
different months, and verify that only records from the selected calendar month
are shown.

**Acceptance Scenarios**:

1. **Given** records from several months, **When** the ledger opens, **Then**
   available months are presented in chronological order and one month is
   selected.
2. **Given** a month selector, **When** the user taps or swipes to another
   month, **Then** that month becomes visibly selected and the ledger updates.
3. **Given** a selected month, **When** its records are shown, **Then** no
   transaction from another calendar month appears in the list.
4. **Given** a selected month with no records, **When** the filter is applied,
   **Then** the message "No transactions recorded for this month." is shown.

---

### User Story 3 - Understand daily income and spending (Priority: P2)

As a money logger user, I want daily totals and clear income or expense styling
so that I can quickly understand how my money changed on each day.

**Why this priority**: Daily context and signed styling turn a chronological
history into information users can scan and interpret confidently.

**Independent Test**: Review a month containing income and expense records on
multiple days and verify daily totals, ordering, signs, and visual distinctions.

**Acceptance Scenarios**:

1. **Given** income and expense records on one day, **When** that date group is
   displayed, **Then** its daily net total equals income minus expenses.
2. **Given** income records, **When** their rows are displayed, **Then** amounts
   have a plus sign and income styling.
3. **Given** expense records, **When** their rows are displayed, **Then** amounts
   have a minus sign and expense styling.
4. **Given** multiple records within a date group, **When** the group is
   displayed, **Then** records are ordered newest first.

### Edge Cases

- When there are no transactions at all, the ledger shows the empty-month
  message without fabricated date groups or records.
- When a month has fewer than three records, all records for that month are
  shown.
- When two records share the same timestamp, their stable sequence ordering is
  retained.
- When a date group has a zero net total, the total is shown as zero with
  neutral or theme-readable styling.
- When a description or category label is long, it wraps or truncates without
  hiding the signed amount.
- When the selected month is changed after scrolling, the ledger returns to a
  useful position for the newly selected month.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Transactions destination MUST display the aggregate wallet
  balance before the transaction history.
- **FR-002**: The balance summary MUST remain available while the user reviews
  transaction records.
- **FR-003**: The ledger MUST present available calendar months in chronological
  order through a horizontally browsable month selector.
- **FR-004**: The month selector MUST visibly identify the selected month using
  the active visual accent.
- **FR-005**: Selecting or browsing to a month MUST filter the ledger to records
  whose calendar month and year match the selected month.
- **FR-006**: The initially selected month MUST be the latest available month,
  or the current month when no records exist.
- **FR-007**: The ledger MUST group filtered records by calendar date.
- **FR-008**: Date groups MUST be ordered newest date first.
- **FR-009**: Each date-group heading MUST show a readable date and the net
  total for that date.
- **FR-010**: Each transaction row MUST show a category visual, description,
  category label, and signed formatted amount.
- **FR-011**: Income amounts MUST use a plus sign and income styling; expense
  amounts MUST use a minus sign and expense styling.
- **FR-012**: Transactions within each date group MUST be ordered newest first,
  using the existing stable sequence ordering when timestamps are equal.
- **FR-013**: A selected month with no records MUST show the exact message
  "No transactions recorded for this month."
- **FR-014**: The ledger MUST show all records in a selected month, including
  months with fewer than three records.
- **FR-015**: Long descriptions and category labels MUST remain usable without
  obscuring the signed amount.
- **FR-016**: Balance, month selection, date groups, and transaction rows MUST
  remain usable across narrow and wide supported screens and increased text
  sizes.
- **FR-017**: The selected month and grouped records MUST update without
  requiring the user to leave the Transactions destination.

### Key Entities

- **Ledger Month**: A calendar month available for selection, identified by year
  and month and ordered chronologically.
- **Transaction Group**: A calendar date within the selected month containing
  matching transactions and their calculated daily net total.
- **Ledger Transaction**: An existing income or expense record presented with
  category, description, timestamp, amount, and transaction type.
- **Daily Net Total**: The sum of income amounts minus expense amounts for one
  calendar date.
- **Selected Month State**: The currently focused month used to filter the
  ledger during the current session.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can open the Transactions destination and identify the
  selected month, current balance, and first date group within 5 seconds.
- **SC-002**: Changing the selected month updates the visible records in one
  user action without opening another screen.
- **SC-003**: 100% of displayed records belong to the selected calendar month.
- **SC-004**: 100% of displayed date groups show a correct daily net total when
  reviewed against their records.
- **SC-005**: Users can distinguish income from expenses by sign and styling with
  at least 90% accuracy during manual review.
- **SC-006**: The ledger remains readable without clipping or overlapping content
  at narrow and wide supported screen sizes and at increased text scale.

## Assumptions

- Transaction records are available in the current in-memory session data used
  by the dashboard.
- The latest transaction month is selected initially when at least one record
  exists; otherwise the current calendar month is selected.
- Calendar grouping uses the device's local calendar date.
- Existing currency formatting and income/expense conventions are reused.
- The balance summary is session-scoped and does not introduce persistence.
- Automated unit, integration, and end-to-end tests are out of scope because
  project governance requires manual validation, formatting, and static analysis.
