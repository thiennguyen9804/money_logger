# Feature Specification: Add Transaction Bottom Sheet / Slide-up Modal

## 1. Executive Summary
Define the UI layout, presentation behavior, auto-focus mechanics, and form inputs for the "Add Transaction" creation flow. Triggered via the central button in the primary bottom navigation bar, this screen opens as a slide-up modal (bottom sheet) designed for high-speed expense/income logging.

---

## 2. Presentation & Transition Behavior

### 2.1 Modal Type & Animation
* **Presentation:** Slide-up modal / Modal Bottom Sheet.
* **Dismissal:** Drag-down gesture or tap outside (scrim/backdrop overlay) to dismiss.

### 2.2 Focus Management & Keyboard UX
* **Auto-Focus:** Immediately upon modal slide-up completion, the **Amount Input field must gain focus automatically**.
* **Keyboard Type:** The software keyboard must default strictly to a **Numeric / Decimal Pad** configuration to enable instant typing without manual tap-to-focus.

---

## 3. UI Component Breakdown & Form Inputs

### 3.1 Primary Form Inputs (Default View)
1. **Amount Input (Primary Field)**
   * Large numeric display auto-focused on launch.
   * Supports decimal entry formatted according to active locale settings.
2. **Type & Category Selector**
   * Income / Expense toggle switch (or tab bar).
   * Category selector (grid or horizontal scrollable list displaying pastel category icons, e.g., Food, Shopping, Transport, Salary).
3. **Date & Time Picker Input**
   * Defaults to current timestamp (`Now`).
   * Tapping opens a quick date-time selection picker.

### 3.2 Progressive Disclosure Section ("More Details")
* **Trigger:** A prominent text button labeled **"More Details"** (styled in active pastel theme accent).
* **Behavior:** Tapping expands the bottom sheet smoothly to reveal secondary inputs inline.
* **Expanded Fields:**
  * **Event / Campaign Picker:** Dropdown or selector field allowing the user to attach the transaction to a specific event (e.g., *Summer Trip 2026*, *Birthday Party*).

---

## 4. State & Accessibility Constraints
* **Validation:** The save button remains disabled or handles soft validation until a valid positive numeric amount is entered.
* **Theme Support:** Modal backdrop, sheet container, input fields, and dynamic keyboard styling must adapt seamlessly to Light, Dark, and active Pastel color themes.