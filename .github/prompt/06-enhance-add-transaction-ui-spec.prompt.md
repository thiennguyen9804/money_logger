# Feature Enhancement Specification: Full-Screen Add Transaction & Category Selection Flow

## 1. Executive Summary
Enhance the existing Add Transaction creation experience by migrating from a modal bottom sheet to a dedicated **Full-Screen Navigation Route**. This specification updates input focus behaviors, introduces icon-direction semantics for Income/Expense types, transforms the category picker into a dedicated multi-tab selection screen, and refined tap-outside un-focus mechanics.

---

## 2. Updated Add Transaction Screen Architecture (Full Screen)

### 2.1 Navigation & Presentation Mode
* **Route Type:** Dedicated full-screen route (replacing the previous slide-up modal bottom sheet).
* **Header Bar:** Displays a standard top bar with a Back / Close button on the top-left and a Save action on the top-right.

### 2.2 Un-focus Mechanics & Touch Behavior
* **Dismiss Keyboard / Out of Focus:** Tapping anywhere on an empty or neutral background area of the screen must remove focus from the **Money-Input field** and hide the soft numeric keyboard.

### 2.3 Income / Expense Visual Direction Rules
* **Expense Type Indicator:** Features an **Up-Arrow icon** (`↑`) paired with soft pastel red/rose styling to indicate outgoing funds.
* **Income Type Indicator:** Features a **Down-Arrow icon** (`↓`) paired with soft pastel green/sage styling to indicate incoming funds.

---

## 3. Category Input & Navigation Flow

### 3.1 Category Selector Field (Main Screen)
* **Initial State:** Displays an **empty box/placeholder input** (e.g., *"Select Category"*).
* **Navigation Trigger:** Tapping this category box navigates the user directly to a secondary dedicated screen: **Category Selection Screen**.

### 3.2 Category Selection Screen Structure
* **Layout Structure:** Dedicated selection screen split into **2 distinct tab views or segmented sections**:
  1. **Expense Categories Tab:** Displays a grid/list of expense categories (e.g., Food & Dining, Transportation, Shopping, Bills).
  2. **Income Categories Tab:** Displays a grid/list of income categories (e.g., Salary, Investments, Gifts, Freelance).
* **Selection Behavior:** Tapping any category item highlights the choice, automatically navigates back to the main Add Transaction screen, and populates the category box with the selected icon and title.

---

## 4. State & Parity Requirements
* Retain auto-focus behavior on initial entry to the main Add Transaction screen, opening the numeric pad immediately.
* Ensure all elements seamlessly integrate with the app's dynamic Light, Dark, and Pastel theme palettes.