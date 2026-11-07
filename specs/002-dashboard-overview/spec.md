# Feature Specification: Dashboard Overview

**Feature Branch**: `002-dashboard-overview`

**Created**: 2026-11-06

**Status**: Draft

**Input**: User description: "Define the Dashboard screen (`/dashboard`) with a current wallet balance, privacy toggle, wallet detail entry point, and exactly three most recent transactions."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Review current wallet balance (Priority: P1)

As a person tracking my finances, I want to see my current net wallet balance at a
glance so that I understand my financial position when opening the application.

**Why this priority**: The current balance is the primary purpose of the dashboard
and provides immediate financial context.

**Independent Test**: Manually open Dashboard with a known wallet total and confirm
the balance label, formatted amount, active theme styling, and privacy control.

**Acceptance Scenarios**:

1. **Given** the user opens Dashboard with a wallet total available, **When** the
   screen finishes loading, **Then** a high-visibility card shows the label
   "Current Balance" or "Net Worth" and the formatted total.
2. **Given** the balance is visible, **When** the user selects the privacy control,
   **Then** the numerical amount is replaced by a non-numerical mask.
3. **Given** the balance is masked, **When** the user selects the privacy control
   again, **Then** the formatted numerical amount is shown again.
4. **Given** the user selects the balance card, **When** the detail action is
   available, **Then** the wallet breakdown/detail view opens.

---

### User Story 2 - Preview recent transactions (Priority: P1)

As a person reviewing my spending, I want to see my latest transactions on Dashboard
so that I can understand recent activity without opening the full ledger.

**Why this priority**: Recent activity gives the dashboard immediate practical value
and supports quick financial review.

**Independent Test**: Manually provide more than three transactions with distinct
timestamps and verify the Dashboard list contains only the three newest records in
descending timestamp order.

**Acceptance Scenarios**:

1. **Given** the user has at least three transactions, **When** Dashboard displays
   recent activity, **Then** exactly the three newest transactions are shown.
2. **Given** transactions have different creation timestamps, **When** the recent
   list is displayed, **Then** records appear from newest to oldest.
3. **Given** a transaction is an expense, **When** it appears in the list, **Then**
   its amount uses a minus sign and the expense styling.
4. **Given** a transaction is income, **When** it appears in the list, **Then** its
   amount uses a plus sign and the income styling.
5. **Given** the user selects "View All", **When** the action completes, **Then** the
   Transactions destination opens.

---

### User Story 3 - Use the dashboard across themes and devices (Priority: P2)

As a person using the app in different environments, I want the dashboard to remain
readable and usable across themes and viewport sizes so that financial information
does not become hidden or confusing.

**Why this priority**: Consistent readability protects the usefulness of the overview
while the application supports light, dark, and pastel presentations.

**Independent Test**: Manually inspect Dashboard in each supported theme, on narrow
and wide viewports, and with enlarged text.

**Acceptance Scenarios**:

1. **Given** the user switches between supported themes, **When** Dashboard is
   displayed, **Then** the balance card, transaction list, icons, and text retain
   readable contrast.
2. **Given** the viewport is narrow or wide, **When** Dashboard is displayed, **Then**
   the balance card, recent list, and actions remain visible and usable without
   overlap or clipping.
3. **Given** the user increases text size, **When** Dashboard is displayed, **Then**
   labels, amounts, dates, and actions remain readable and reachable.

### Edge Cases

- When the wallet total is zero, Dashboard shows a valid zero currency amount rather
  than an empty or ambiguous value.
- When there are fewer than three transactions, Dashboard shows every available
  transaction and does not invent placeholder transactions.
- When there are no transactions, the recent section shows a clear empty state and
  retains the "View All" path to the ledger.
- When two transactions have the same timestamp, their ordering remains stable for
  the duration of the displayed result.
- When a transaction description is long, it truncates or wraps without hiding its
  amount or making the row unusable.
- When the balance is masked, no numerical balance digits remain visible in the
  balance card.
- When a theme has a pastel balance background, foreground text and controls remain
  legible against that background.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Dashboard MUST provide a high-visibility balance card containing
  the label "Current Balance" or "Net Worth".
- **FR-002**: The balance card MUST display the current wallet aggregate as a
  formatted currency amount.
- **FR-003**: The Dashboard MUST provide a privacy control that masks and unmasks the
  numerical balance amount.
- **FR-004**: The masked balance MUST NOT display any numerical balance digits.
- **FR-005**: The balance card MUST provide an action to open the wallet breakdown or
  detail view when that view is available.
- **FR-006**: The Dashboard MUST provide a "Recent Transactions" section.
- **FR-007**: The recent section MUST display no more than three transactions.
- **FR-008**: When more than three transactions exist, the recent section MUST show
  the three records with the newest creation timestamps.
- **FR-009**: Recent transactions MUST be ordered by creation timestamp descending.
- **FR-010**: Each transaction item MUST show a category icon, description or
  merchant name, date or relative timestamp, and formatted amount.
- **FR-011**: Expense amounts MUST use a minus sign and visually distinct expense
  styling.
- **FR-012**: Income amounts MUST use a plus sign and visually distinct income
  styling.
- **FR-013**: The recent section MUST provide a "View All" action that opens the
  Transactions destination.
- **FR-014**: The Dashboard MUST show a clear empty state when no transactions are
  available.
- **FR-015**: The Dashboard MUST show all available transactions when fewer than
  three exist.
- **FR-016**: Balance, transaction content, icons, and actions MUST remain readable
  in light, dark, and pastel themes with sufficient contrast.
- **FR-017**: The Dashboard MUST remain usable across supported narrow and wide
  viewports and increased text scales without clipping or overlap.
- **FR-018**: Dashboard state MUST preserve the user's balance visibility choice for
  the current application session.
- **FR-019**: The feature MUST be validated through formatting, static analysis,
  manual review, and manual runtime verification; it MUST NOT add unit, integration,
  or end-to-end automated tests.

### Key Entities

- **Wallet Summary**: The current aggregate wallet amount shown on the balance card.
- **Transaction**: A financial record with category, description or merchant,
  timestamp, amount, and income/expense type.
- **Balance Visibility State**: The session-level choice controlling whether the
  wallet amount is shown or masked.
- **Dashboard Recent Activity**: The ordered subset of up to three newest
  transactions displayed on Dashboard.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In manual review, users can identify the current balance and its
  visibility state within 2 seconds of opening Dashboard.
- **SC-002**: In manual review, the Dashboard displays exactly three transactions
  when at least three exist, and they are the three newest records.
- **SC-003**: In manual review, 100% of displayed transaction rows include a category
  icon, description, timestamp, and signed amount.
- **SC-004**: In manual review, users can mask or reveal the balance in one action,
  with no balance digits visible while masked.
- **SC-005**: In manual review, "View All" opens the Transactions destination in one
  action from Dashboard.
- **SC-006**: In manual review, no dashboard content or action is clipped, overlapped,
  or unreachable across supported viewport sizes and increased text scales.
- **SC-007**: In manual review, balance and transaction text remain readable in light,
  dark, and pastel themes.

## Assumptions

- The Dashboard is the existing default primary destination at `/dashboard`.
- Wallet and transaction data are available from the application's current session;
  this feature does not define account authentication or data synchronization.
- Currency formatting follows the user's configured currency; when no preference
  exists, the application uses its existing default currency convention.
- A transaction's creation timestamp is the authoritative value for recent ordering.
- The wallet detail view may be a separate follow-up feature; Dashboard only needs to
  expose the entry action when that view exists.
- The existing primary navigation and session-state behavior remain unchanged.
- Pastel is a supported visual variant of the existing theme system and does not
  require a new persistence mechanism.
