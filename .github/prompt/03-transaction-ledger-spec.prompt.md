# Feature Specification: Transaction Ledger Screen - Hierarchical Grouping & Monthly Carousel

## 1. Executive Summary
Define the layout, hierarchy, and data interaction requirements for the Transaction Ledger screen (`/transactions`). This screen provides a comprehensive historical view of all financial transactions, structured with a running balance header, a horizontal month-selection carousel, and a date-grouped transaction list.

---

## 2. Screen Architecture & Visual Hierarchy (Top to Bottom)

### 2.1 Total Balance Header (Top Section)
* **Purpose:** Always-visible financial summary anchored at the top of the transaction ledger.
* **Content:** Displays the current aggregated net wallet balance across all accounts.
* **Behavior:** Remains sticky or pinned at the top while scrolling through transaction records.

### 2.2 Horizontal Month Carousel (Middle Section)
* **Component:** Swipeable horizontal list (`Horizontal ScrollView` / Carousel).
* **Behavior:** 
  * Displays a chronological list of months (e.g., *Oct 2026, Nov 2026, Dec 2026*).
  * The currently active/selected month is visually highlighted using the active pastel theme accent.
  * Tapping or scrolling a month updates the transaction list below to filter and display only records belonging to that selected month.

### 2.3 Date-Grouped Transaction List (Bottom/Main Section)
* **Structure:** A vertically scrolling list where transactions are systematically **grouped by calendar date** (e.g., *Today, Yesterday, Nov 5, 2026*).
* **Group Header:** Each date group features a sticky or distinct sub-header displaying the formatted date and the daily net total (total spent/earned on that specific day).
* **Transaction Item UI:**
  * Category pastel icon, title/merchant name, category tag.
  * Amount formatted cleanly with conditional income/expense color coding.

---

## 3. Data Flow & State Management

### 3.1 Filtering Logic
* Selecting a month in the horizontal carousel triggers a state update (`selectedMonth`), fetching or filtering the local state to display transactions belonging to that date range.
* Within the selected month, transactions must be automatically sorted descending by timestamp and grouped into chronological day buckets (`Map<String, List<Transaction>>`).

### 3.2 Edge Cases & UI States
* **Empty Month:** If a selected month contains no records, display an empty state placeholder: *"No transactions recorded for this month."*