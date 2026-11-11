# Feature Specification: Standardized Category List and Slide-Up Add Transaction Flow

**Feature Branch**: `009-enhance-add-transaction-categories`

**Created**: 2026-11-11

**Status**: Draft

**Input**: User description: "Update the Add Transaction flow and Category Selection module to incorporate a comprehensive pre-defined list of English-only categories split into explicit Expense and Income groups. Ensure the Add Transaction screen slides up from the bottom while preserving its full-screen interactive capabilities and bi-directional synchronization logic."

---

## Clarifications

### Session 2026-11-11

- Q: Should the expense category be labeled as "Food & Beverage" or "Dining"? → A: Food & Beverage
- Q: Should the Add Transaction screen use a full-screen page with slide-up transition animation, or a modal bottom sheet? → A: Full-screen page with custom slide-up animation
- Q: Should the specification explicitly list Material Icons for each category, or should icon selection be left as an implementation detail? → A: Explicitly list Material Icons for all 24 categories
- Q: Should the assumption about "PageRouteBuilder with SlideTransition" be kept as-is, or should it be rephrased to avoid implementation-specific details? → A: Rephrase to remove Flutter-specific implementation details

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Standardized English Category Dataset (Priority: P1)

As a user recording financial transactions, I want to see a comprehensive, standardized list of English-only categories so that I can quickly and consistently categorize my income and expenses without confusion.

**Why this priority**: A standardized category list is the foundation for consistent transaction tracking. Without it, users may create duplicate or inconsistent categories, making financial analysis difficult.

**Independent Test**: Open the Category Selection screen and verify all 18 expense categories and 6 income categories are displayed with correct English labels.

**Acceptance Scenarios**:

1. **Given** the Category Selection screen is open on the Expense tab, **When** the user views the list, **Then** all 18 expense categories are displayed: Fuel, Transportation, Food & Beverage, Rent, Lending, Debt Repayment, Vehicle Repair, Phone Bills, Haircut, Healthcare, Entertainment & Leisure, Other Expenses, Online Services, Shopping, Transfer Out, Gifts, Vehicle Maintenance, Personal Care
2. **Given** the Category Selection screen is open on the Income tab, **When** the user views the list, **Then** all 6 income categories are displayed: Transfer In, Salary, Other Income, Gifts Received, Borrowing, Debt Collection
3. **Given** the Add Transaction screen is open, **When** the user taps the category selector, **Then** the Category Selection screen displays with the correct categories for the selected transaction type

---

### User Story 2 - Slide-Up Add Transaction Transition (Priority: P1)

As a user initiating a new transaction, I want the Add Transaction screen to slide up smoothly from the bottom of the screen so that I have a clear, intuitive entry point that maintains context with the current screen.

**Why this priority**: A smooth modal-style transition improves the user experience by providing visual continuity while clearly indicating a new focused task. The animation should not disrupt the user's mental model of the navigation hierarchy.

**Independent Test**: Tap the Add Transaction button in the bottom navigation bar and verify the screen animates upward from the bottom with a smooth transition.

**Acceptance Scenarios**:

1. **Given** the user is on any screen, **When** they tap the Add Transaction navigation item, **Then** the Add Transaction screen slides up from the bottom with a modal transition animation
2. **Given** the Add Transaction screen is animating in, **When** the animation completes, **Then** the screen is fully functional with all interactive elements accessible
3. **Given** the Add Transaction screen is open, **When** the user taps the back button, **Then** the screen slides down to dismiss with the reverse animation
4. **Given** the Add Transaction screen is open, **When** the user focuses on any input field, **Then** the keyboard appears and the screen handles unfocus behavior correctly
5. **Given** the Add Transaction screen is open, **When** the user completes a transaction, **Then** the screen dismisses with the slide-down animation and returns to the previous screen

---

### User Story 3 - Bi-Directional Type and Category Synchronization (Priority: P1)

As a user switching between transaction types or categories, I want the category and type selections to stay synchronized so that I never accidentally create a transaction with a mismatched type-category pair.

**Why this priority**: Maintaining synchronization between transaction type (Income/Expense) and category prevents data integrity issues. This is a critical business rule that must work flawlessly.

**Independent Test**: On the Add Transaction screen, change the transaction type and verify the category selection updates appropriately. Then select a category and verify the type matches.

**Acceptance Scenarios**:

1. **Given** the user has selected an Expense category, **When** they switch to Income type, **Then** the selected category is cleared and they must select an Income category
2. **Given** the user has selected an Income category, **When** they switch to Expense type, **Then** the selected category is cleared and they must select an Expense category
3. **Given** the user has selected a transaction type, **When** they navigate to Category Selection, **Then** only categories matching the selected type are available
4. **Given** the user selects a category from the Category Selection screen, **When** they return to Add Transaction, **Then** the transaction type automatically updates to match the category type
5. **Given** the user has a type and compatible category selected, **When** they tap Save, **Then** the transaction is created with the correct type-category pairing

---

### Edge Cases

- If the user switches transaction type with a category selected, the incompatible category must be cleared to prevent invalid data
- The slide-up animation must work correctly on all supported screen sizes and orientations
- Category list must display correctly in both light and dark theme modes
- The Add Transaction screen must maintain full functionality when animated in (all buttons, inputs, and selectors work)
- Keyboard appearance must not interfere with the slide-up animation or screen layout
- The bi-directional synchronization must work consistently regardless of navigation path (direct navigation vs. from category selection)

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Category Selection module MUST display exactly 18 predefined Expense categories with the following English-only labels: Fuel, Transportation, Food & Beverage, Rent, Lending, Debt Repayment, Vehicle Repair, Phone Bills, Haircut, Healthcare, Entertainment & Leisure, Other Expenses, Online Services, Shopping, Transfer Out, Gifts, Vehicle Maintenance, Personal Care
- **FR-002**: The Category Selection module MUST display exactly 6 predefined Income categories with the following English-only labels: Transfer In, Salary, Other Income, Gifts Received, Borrowing, Debt Collection
- **FR-003**: The Add Transaction screen MUST animate in using a slide-up modal transition from the bottom of the screen
- **FR-004**: The Add Transaction screen MUST animate out using a slide-down modal transition when dismissed
- **FR-005**: The Add Transaction screen MUST maintain full-screen interactive functionality during and after the animation
- **FR-006**: The Add Transaction screen MUST preserve its un-focus mechanics (keyboard dismissal, input validation)
- **FR-007**: Category selection MUST be bi-directionally synchronized with transaction type selection
- **FR-008**: Selecting an Expense category MUST automatically set the transaction type to Expense
- **FR-009**: Selecting an Income category MUST automatically set the transaction type to Income
- **FR-010**: Switching transaction type MUST clear any selected category if it is incompatible with the new type
- **FR-011**: The native SegmentedButton behavior for type selection MUST be maintained
- **FR-012**: The right-aligned signless currency formatting MUST be preserved across Dashboard and Ledger screens
- **FR-013**: Theme-aware pastel color styling MUST be maintained across all screens

### Key Entities *(include if feature involves data)*

- **ExpenseCategory**: A predefined category for tracking expense transactions. Has a label, icon, and is associated with the Expense type.
- **IncomeCategory**: A predefined category for tracking income transactions. Has a label, icon, and is associated with the Income type.
- **TransactionType**: An enumeration with two values: Income and Expense. Determines which categories are compatible.
- **CategorySelectionSession**: Manages the active tab (Expense/Income) and selected category during the category selection flow.
- **TransactionDraft**: The in-progress transaction being composed, containing type, category, amount, and other details.

#### Category Icons (Material Icons)

**Expense Categories:**
- Fuel: `local_gas_station`
- Transportation: `commute`
- Food & Beverage: `restaurant`
- Rent: `home`
- Lending: `account_balance_wallet`
- Debt Repayment: `receipt_long`
- Vehicle Repair: `car_repair`
- Phone Bills: `phone_iphone`
- Haircut: `content_cut`
- Healthcare: `local_hospital`
- Entertainment & Leisure: `movie`
- Other Expenses: `category`
- Online Services: `public`
- Shopping: `shopping_bag`
- Transfer Out: `compare_arrows`
- Gifts: `redeem`
- Vehicle Maintenance: `build`
- Personal Care: `face`

**Income Categories:**
- Transfer In: `compare_arrows`
- Salary: `work`
- Other Income: `category`
- Gifts Received: `redeem`
- Borrowing: `money`
- Debt Collection: `credit_card`

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of predefined categories (18 Expense + 6 Income = 24 total) are displayed with correct English labels
- **SC-002**: Add Transaction screen slide-up animation completes in under 300ms with smooth 60fps rendering
- **SC-003**: Bi-directional synchronization prevents 100% of type-category mismatches
- **SC-004**: 100% of existing visual styling (SegmentedButton, currency formatting, theme colors) remains unchanged

## Assumptions

- All category labels are English-only as specified in the feature description
- The slide-up animation uses a smooth modal-style transition from the bottom of the screen
- The existing SegmentedButton implementation is maintained and not replaced
- The existing currency formatting (right-aligned, signless) is preserved
- Theme-aware styling continues to use the existing pastel color scheme
- The Add Transaction screen maintains its existing full-screen layout and functionality
- All existing navigation and state management patterns remain in place
- The category list is static and not user-configurable in this version
