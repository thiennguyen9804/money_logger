# Architecture & Refactor Specification: Flutter BLoC, SegmentedButton Integration, and Project Structure

## 1. Executive Summary
Refactor the existing transaction management implementation to strictly use official `flutter_bloc` and `equatable` packages, replacing custom BLoC/State implementations. Additionally, replace custom segmented control widgets with Flutter's native `SegmentedButton`, align with standard Material 3 color schemes, and reorganize the codebase into a clean, feature-driven directory structure.

---

## 2. State Management Architecture (`flutter_bloc` + `equatable`)

### 2.1 Dependencies & Imports
* Use standard `flutter_bloc` and `equatable` package definitions (consume existing pubspec versions).
* Remove all custom/handwritten BLoC boilerplate, stream controllers, or manual state comparison implementations.
* Use BLoC instead of Cubit.

### 2.2 BLoC Definition Rules
* **Events:** All BLoC events must extend `Equatable` and override `props` to enforce deterministic state changes.
* **States:** All BLoC states must extend `Equatable` to prevent redundant UI rebuilds when state properties remain unchanged.
* **Separation of Concerns:** Business logic for transaction creation, type-category synchronization, and theme switching must reside strictly within BLoC handlers (`on<Event>`), keeping UI widgets purely presentational.

---

## 3. UI Component Modernization (`SegmentedButton`)

### 3.1 Migration from Custom Control
* Deprecate and remove custom `_TypeSegmentControl` implementations.
* Replace with Flutter's native `SegmentedButton<TransactionType>` widget.

### 3.2 Color & Styling Rules
* **Remove Custom Background Overrides:** Explicitly eliminate hardcoded custom red and green background overlays from the type segment control.
* **Material 3 Theme Defaulting:** Utilize native `SegmentedButton` theme defaults and active pastel color scheme bindings (`ColorScheme.primary`, `ColorScheme.secondaryContainer`, etc.) without manual backdrop overrides.

---

## 4. Directory & Module Organization Strategy

Reorganize the codebase into a clean, scalable folder architecture:

```text
lib/
├── shared/                         # Cross-screen shared UI components & utilities
│   ├── widgets/                    # Reusable widgets (e.g., buttons, inputs, icons)
│   └── theme/                      # App pastel theme system & palettes
|       └── bloc/                   # BLoC logic (events, states, bloc)
├── screens/
│   ├── add_transaction/
│   │   ├── add_transaction_screen.dart
│   │   └── widgets/
│   │       ├── amount_input_field.dart
│   │       └── category_selector_box.dart
│   ├── category_selection/
│   │   ├── category_selection_screen.dart
│   │   └── widgets/
│   │       ├── expense_category_grid.dart
│   │       └── income_category_grid.dart
│   └── dashboard/
│       ├── dashboard_screen.dart
│       └── widgets/
│           └── wallet_balance_card.dart
└── shared/
    ├── components/
    │   ├── transaction_list_item.dart
    │   └── custom_segmented_button.dart
    └── theme/
        └── theme_data.dart
```

### 4.1. Folder Rules
* **screens/:** Contains top-level screen routes. Each screen directory houses its main page layout alongside a dedicated widgets/ subfolder for components unique to that screen.

* **screens/<feature>/widgets/:** Private/local UI widgets consumed exclusively by that specific screen.

* **shared/:** Reusable components, common models, shared BLoCs, and global theme configurations accessed across multiple screens.

---

## 5. Global Rules
* **No side effect:** Ensure the refactoring will not introduce side effect or break current logic.
* **Minimal changes:** Minimalise the changes, do not introduce unnecessary changes