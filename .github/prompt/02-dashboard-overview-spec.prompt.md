# Feature Specification: Dashboard Screen - Account Balance & Recent Transactions

## 1. Executive Summary
Define the requirements and UI components for the Dashboard screen (`/dashboard`). This screen serves as the primary financial overview, displaying the user's current net wallet balance and a preview list of their 3 most recent transactions.

---

## 2. UI Layout & Component Breakdown

### 2.1 Wallet Balance Card (Header Region)
* **Visual Container:** High-visibility summary card using the active theme's primary pastel background.
* **Information Display:**
  * Label: "Current Balance" (or "Net Worth").
  * Amount: Total formatted currency string (e.g., `$1,250.00` or `1,250,000 ₫`).
  * Privacy Toggle: An eye icon button to hide/show the numerical balance (e.g., mask with `••••••`).
* **Interactive Element:** Tap action to open wallet breakdown/detail view (if applicable).

### 2.2 Recent Transactions Section
* **Header:** Title "Recent Transactions" paired with a "View All" link/button that routes the user to the Transaction Ledger tab (`/transactions`).
* **List Constraints:** Display exactly the **top 3 most recent transactions** ordered by timestamp (`created_at` descending).
* **Transaction Item UI:**
  * **Category Icon:** Color-coded pastel icon matching the category (e.g., Food, Transportation, Salary).
  * **Title & Subtitle:** Transaction description/merchant name as main text; relative timestamp or date as secondary text.
  * **Amount Format:** 
    * Expense: `- $XX.XX` (styled with soft red/rose text).
    * Income: `+ $XX.XX` (styled with soft green/sage text).

---

## 3. Data & State Handling

### 3.1 Data Requirements
* Fetch current user wallet aggregate total.
* Fetch latest transactions with query limit `limit = 3`.

---

## 4. Accessibility & Styling
* Adhere to the app's dynamic pastel theme system (supporting Light, Dark, and Pastel variants).
* Maintain proper contrast ratios for text visibility over pastel card backgrounds.