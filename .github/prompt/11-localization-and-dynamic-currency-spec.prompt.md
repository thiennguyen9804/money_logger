# Feature Enhancement Specification: Internationalization (Localization) & Dynamic Currency Formatting

## 1. Executive Summary
Implement multi-language support (Vietnamese and English/US) leveraging the existing `flutter_localizations` package setup. Bind the selected application locale dynamically to the currency formatting logic: switching to Vietnamese (`vi`) automatically formats amounts in Vietnamese Dong (VND), while switching to English (`en`) formats amounts in US Dollars (`$`).

---

## 2. Localization Infrastructure (`flutter_localizations`)
* **Supported Locales:** Configure support for Vietnamese (`vi`) and English (`en`/`en_US`).
* **State & Persistence:** The active locale must be manageable via a global state provider or BLoC, allowing users to toggle languages seamlessly from a settings or profile screen, persisting preference across app sessions.
* **Localization Files:** Establish ARB (Application Resource Bundle) files (`app_en.arb`, `app_vi.arb`) or an equivalent localization delegate structure for all static UI texts (headers, buttons, transaction types, and categories).

---

## 3. Dynamic Currency Formatting Rules
Currency symbols and numeric formatting patterns must adapt reactively based on the active locale:

### 3.1 Vietnamese Locale (`vi`)
* **Currency Symbol:** `₫`.
* **Formatting Pattern:** Right-aligned, formatted with period separators for thousands (e.g., `150.000 ₫`).

### 3.2 English / US Locale (`en`)
* **Currency Symbol:** `$` (USD).
* **Formatting Pattern:** Left-aligned or standard currency symbol with comma separators for thousands and decimal places where applicable (e.g., `$150.00`).

---

## 4. UI & Ledger Integration
* **Reactive Updates:** All screens displaying monetary values (Dashboard totals, Transaction Ledger list items, Add/Edit Transaction inputs, and Budgets) must instantly reflect the correct currency symbol and number format when the app language changes.
* **Input Validation:** Currency input fields on the "Add Transaction" screen should adapt their hint text and formatting masks according to the active currency unit.