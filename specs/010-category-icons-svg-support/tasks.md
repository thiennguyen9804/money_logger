---

description: "Task list for Category Icons and SVG Support"
---

# Tasks: Category Icons and SVG Support

**Input**: Design documents from `/specs/010-category-icons-svg-support/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: No automated test tasks are included because the project constitution prohibits automated testing. Validation uses formatting, static analysis, and manual runtime review.

**Organization**: Tasks are grouped by user story. User Story 2 builds on the shared native badge and surface integration from User Story 1.

## Phase 1: Setup

**Purpose**: Project initialization and basic structure

No project setup is required; the Flutter application, package configuration, and source directories already exist.

---

## Phase 2: Foundational

**Purpose**: Shared category icon presentation required by all user stories

- [X] T001 Create a reusable native-icon badge widget with centered artwork and theme-aware circular or rounded background in `lib/shared/widgets/category_icon.dart`.

**Checkpoint**: The shared badge can render a category's required native icon before either user story integrates or extends it.

---

## Phase 3: User Story 1 - Recognize Categories at a Glance (Priority: P1) 🎯 MVP

**Goal**: Present native category icons consistently on Dashboard, Ledger, and category selection surfaces.

**Independent Test**: Run the app with native-icon categories and inspect Dashboard recent transactions, Ledger rows, and Expense and Income category selection rows in light and dark themes. Confirm consistent badge size, alignment, and readable contrast.

### Implementation for User Story 1

- [X] T002 [P] [US1] Replace the transaction category `CircleAvatar` icon rendering with the shared badge in `lib/shared/widgets/transaction_list_item.dart`.
- [X] T003 [P] [US1] Replace direct category icon rendering with the shared badge in `lib/screens/category_selection/category_selection_screen.dart` and `lib/screens/add_transaction/add_transaction_screen.dart`.

**Checkpoint**: Dashboard, Ledger, and category selection use the same native-icon badge and remain usable with existing categories.

---

## Phase 4: User Story 2 - Use Custom Category Artwork (Priority: P2)

**Goal**: Support app-supplied SVG artwork on predefined categories while preserving native icons as the fallback.

**Independent Test**: Run the app and confirm categories assigned bundled SVG artwork and categories using only native icons display correctly on Dashboard, Ledger, and category selection. Confirm a missing or invalid SVG displays its native icon fallback without disrupting the category row.

### Implementation for User Story 2

- [X] T004 [P] [US2] Add nullable `iconAssetPath` to `Category` while keeping the native `icon` required, and forward the optional path through expense and income category constructors in `lib/models/category.dart`, `lib/models/expense_category.dart`, and `lib/models/income_category.dart`.
- [X] T005 [P] [US2] Add app-supplied SVG artwork for the Fuel and Salary categories under `assets/icons/` and register `assets/icons/` in `pubspec.yaml`.
- [X] T006 [P] [US2] Assign the bundled SVG paths to the Fuel and Salary category definitions while retaining their native icons in `lib/models/expense_category.dart` and `lib/models/income_category.dart` (depends on T004 and T005).
- [X] T007 [P] [US2] Extend the shared badge to render `iconAssetPath` with `SvgPicture.asset`, constrain SVG size to the badge, and show the required native icon from an error fallback in `lib/shared/widgets/category_icon.dart` (depends on T001 and T004).

**Checkpoint**: Both icon types render through the shared widget, and failed SVG loads fall back to native icons.

---

## Phase 5: Polish & Cross-Cutting Validation

**Purpose**: Validate formatting, static correctness, visual consistency, theme contrast, and responsive behavior.

- [X] T008 [P] Run `dart format --output=none --set-exit-if-changed` on `lib/models/category.dart`, `lib/models/expense_category.dart`, `lib/models/income_category.dart`, `lib/shared/widgets/category_icon.dart`, `lib/shared/widgets/transaction_list_item.dart`, and `lib/screens/category_selection/category_selection_screen.dart`, then run `flutter analyze`.
- [ ] T009 [P] Follow the manual runtime review in `specs/010-category-icons-svg-support/quickstart.md` and verify the three surfaces, both themes, narrow layouts, increased text scaling, native fallback, and SVG failure behavior.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No tasks; project structure is already present.
- **Foundational (Phase 2)**: T001 creates the shared widget and blocks story integration.
- **User Stories (Phase 3+)**: US1 starts after T001. US2 depends on US1's shared widget and surface integrations so SVG support extends the common presentation used on all specified surfaces.
- **Polish (Phase 5)**: T008 and T009 require all implementation tasks to be complete and can run in parallel.

### User Story Dependencies

- **User Story 1 (P1)**: Depends on T001; otherwise independent. T002 and T003 edit separate files and can run in parallel.
- **User Story 2 (P2)**: Depends on the completed US1 shared badge and surface integration. T004 and T005 can run in parallel. T006 depends on both T004 and T005. T007 depends on T001 and T004 and can run in parallel with T005 and, after prerequisites, T006.

### Dependency Graph

```text
T001
|-- T002 --\
`-- T003 --+--> US1 complete
             |--> T004 --+--> T006 --\
             |           `--> T007 --+--> T008 and T009
             `--> T005 --------> T006 --/
```
## Parallel Opportunities

- After T001, T002 and T003 can proceed in parallel because they update separate widgets.
- After US1, T004 and T005 can proceed in parallel because model files and asset/package configuration are separate.
- After T004 and T005, T006 and T007 can proceed in parallel because category definitions and the shared widget are separate files.
- After all implementation work, T008 and T009 can proceed in parallel.

## Parallel Example: User Story 1

```text
Task: Replace transaction-row icon rendering in lib/shared/widgets/transaction_list_item.dart
Task: Replace category-selection icon rendering in lib/screens/category_selection/category_selection_screen.dart
```

## Parallel Example: User Story 2

```text
Task: Add app-bundled artwork and register assets/icons/ in pubspec.yaml
Task: Add optional SVG asset-path support to the category model constructors
```

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete T001 to establish the shared native-icon badge.
2. Complete T002 and T003 to apply it to Dashboard, Ledger, and category selection.
3. Perform US1's independent manual review in both themes.

### Incremental Delivery

1. Deliver US1 with consistent native-icon badges as the MVP.
2. Complete US2 to add bundled SVG artwork, model references, rendering, and native fallback.
3. Complete formatting, analysis, and the full manual review in `quickstart.md`.

## Notes

- Every task uses the required checkbox, sequential task ID, optional parallel marker, story label where applicable, and explicit file path.
- `[P]` marks work in separate files with no dependency on unfinished tasks.
- No automated test files or test tasks may be added under the project constitution.