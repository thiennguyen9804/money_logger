# Component Specification: Shared Transaction Item Formatting & Alignment

## 1. Executive Summary
Define strict UI formatting guidelines and structural parity for transaction items across both the Dashboard preview list and the Transaction Ledger date-grouped list. This spec standardizes right-aligned monetary values, signless visual representations, and consistent income/expense color semantics across the application.

---

## 2. Layout & Formatting Rules

### 2.1 Numerical Representation & Right Alignment
* **Alignment:** The numerical transaction value must be strictly right-aligned on the right side of the transaction item row.
* **Signless Format:** Transaction amounts must be displayed as **absolute values without positive (`+`) or negative (`-`) prefix signs** (e.g., `$25.00` instead of `-$25.00` or `+$25.00`).

### 2.2 Color Semantics
While mathematical signs are omitted, type distinction relies entirely on soft pastel text color coding:
* **Expense Amount:** Rendered in soft pastel red / rose text color.
* **Income Amount:** Rendered in soft pastel green / sage text color.

---

## 3. Cross-Screen Parity Requirement

### 3.1 Shared Component (`TransactionListItem`)
* Both the **Dashboard** (`/dashboard`) recent transactions list and the **Transaction Ledger** (`/transactions`) date-grouped list must consume the exact same underlying UI component (`TransactionListItem`).
* **Consistency Check:** Font size, weight, right-side alignment padding, and color palette mapping for numerical amounts must remain 100% identical across all screens where transaction rows are rendered.

---

## 4. Example Output Layout

```text
[ Category Icon ]   Merchant / Category Name      25.00  (Pastel Red Text, Right-Aligned)
                    Nov 7, 2026 • Cash

[ Category Icon ]   Salary Deposit              1,500.00  (Pastel Green Text, Right-Aligned)
                    Nov 1, 2026 • Bank Transfer