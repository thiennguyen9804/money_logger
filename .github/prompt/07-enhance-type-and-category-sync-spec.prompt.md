# Feature Enhancement Specification: Two-Way Type/Category Synchronization & Custom Segmented Control Styling

## 1. Executive Summary
Enhance the state synchronization between Transaction Type (Income vs. Expense) and Category Selection across both the main **Add Transaction Screen** and the secondary **Category Selection Screen**. Additionally, define custom theme-aware color states for the Income/Expense Segmented Control.

---

## 2. Two-Way State Synchronization Rules

### 2.1 Type-to-Category Filtering (Forward Sync)
* When **Expense** is selected on the main screen, navigating to the Category Selection Screen must automatically open and default to the **Expense Categories Tab**.
* When **Income** is selected on the main screen, navigating to the Category Selection Screen must automatically open and default to the **Income Categories Tab**.
* If a category is selected, it must match the active transaction type.

### 2.2 Category-to-Type Propagation (Reverse Sync)
* **Tab-Switch Propagation:** If the user opens the Category Selection Screen, switches from the Expense tab to the Income tab (or vice versa), and selects a category:
  * Upon returning to the Add Transaction screen, the transaction type must **automatically switch to match the newly selected category's type**.
* **Type Retention:** If the user switches tabs in the Category Selection Screen but navigates back *without* picking a category, the main screen's transaction type should revert or remain as originally selected unless an explicit category selection confirmed the change.

---

## 3. Segmented Control UI & Color Semantics

### 3.1 Independent Segment Active Colors
The Income / Expense segmented toggle must use distinct, contextual accent colors for its active state while preserving neutral/default styling for the inactive segment:

* **Income Segment Active:** 
  * Background/Border & Text highlight switches to the designated **Pastel Green / Sage accent color**.
  * The Expense segment remains in its default neutral/unselected state.
* **Expense Segment Active:** 
  * Background/Border & Text highlight switches to the designated **Pastel Red / Rose accent color**.
  * The Income segment remains in its default neutral/unselected state.

---

## 4. State Management Constraints
* State updates for `transactionType` (`INCOME` | `EXPENSE`) and `selectedCategory` must remain reactive across screen navigation transitions.
* Ensure all active/inactive colors smoothly adapt to Light, Dark, and current Pastel Theme variants.