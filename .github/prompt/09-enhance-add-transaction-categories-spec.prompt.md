# Feature Enhancement Specification: Standardized Category List & Slide-Up Add Transaction Flow

## 1. Executive Summary
Update the Add Transaction flow and Category Selection module to incorporate a comprehensive pre-defined list of English-only categories split into explicit Expense and Income groups. Ensure the Add Transaction screen slides up from the bottom while preserving its full-screen interactive capabilities and bi-directional synchronization logic.

---

## 2. Presentation & Transition Behavior
* **Slide-Up Transition:** When navigating to the Add Transaction screen, it must animate by sliding up smoothly from the bottom of the screen (modal-transition style), while maintaining full-screen functionality, layout hierarchy, and un-focus mechanics.

---

## 3. Standardized Category Dataset (English-Only Labels)

All category items must be displayed

### 3.1 Expense Categories
* Fuel
* Transportation
* Food & Beverage (or Dining)
* Rent
* Lending
* Debt Repayment
* Vehicle Repair
* Phone Bills
* Haircut
* Healthcare
* Entertainment & Leisure
* Other Expenses
* Online Services
* Shopping
* Transfer Out
* Gifts
* Vehicle Maintenance
* Personal Care

### 3.2 Income Categories
* Transfer In
* Salary
* Other Income
* Gifts Received
* Borrowing
* Debt Collection

---

## 4. State & Parity Requirements
* **Bi-directional Sync:** The selected category must dynamically synchronize with the transaction type (Expense/Income) following the established tab-switching and type-matching rules.
* **Segmented Control & UI Consistency:** Maintain native `SegmentedButton` behavior, right-aligned signless currency formatting, and theme-aware pastel color styling across Dashboard and Ledger screens.