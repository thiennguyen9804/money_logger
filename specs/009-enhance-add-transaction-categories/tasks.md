# Tasks: Standardized Category List and Slide-Up Add Transaction Flow

**Input**: Design documents from `/specs/009-enhance-add-transaction-categories/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/ui-contracts.md, quickstart.md

**Tests**: Excluded per constitution (No Automated Testing). Validation is `dart format`, `flutter analyze`, and manual runtime verification against `quickstart.md`.

**Organization**: Tasks are grouped by user story. All user stories are Priority P1. Phases map to US1 (Standardized Category Dataset), US2 (Slide-Up Transition), US3 (Bi-Directional Sync), and a final polish/validation phase.

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Minimal project setup for feature 009 - builds upon existing spec 008 refactored structure.

- [ ] T001 Verify existing project structure matches plan.md (lib/models/, lib/screens/add_transaction/, lib/screens/category_selection/)
- [ ] T002 Run `flutter pub get` to ensure dependencies (flutter, flutter_bloc, equatable) are resolved
- [ ] T003 [P] Run `dart format lib/` and `flutter analyze lib/` to capture pre-feature baseline (zero findings target)

**Checkpoint**: Dependencies resolved; baseline established; structure verified.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core category infrastructure that MUST be complete before ANY user story can be implemented. All user stories depend on category models.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Create `lib/models/transaction_type.dart` with enum `TransactionType { income, expense }` (FR-001, data-model.md)
- [ ] T005 Create `lib/models/category.dart` abstract base class with fields: id (String), label (String, max 50 chars, non-empty, English-only), icon (IconData), type (TransactionType) (data-model.md)
- [ ] T006 [P] Create `lib/models/expense_category.dart` extending Category with static list of 18 predefined instances with exact labels and Material Icons from data-model.md
- [ ] T007 [P] Create `lib/models/income_category.dart` extending Category with static list of 6 predefined instances with exact labels and Material Icons from data-model.md
- [ ] T008 Create `lib/models/category_list.dart` barrel file exporting all categories with validation: all 24 categories defined, no duplicate labels, all labels match spec exactly
- [ ] T009 Create `lib/models/transaction_draft.dart` with fields: type (TransactionType, nullable), category (Category, nullable), amount (double, nullable), description (String, max 255 chars, nullable), date (DateTime, nullable) with validation: if category set, type must match category.type; if type set, category must be compatible or null (data-model.md)

**Checkpoint**: Foundation ready - category models and draft state complete. All user stories can now begin in parallel.

---

## Phase 3: User Story 1 - Standardized English Category Dataset (Priority: P1) 🎯 MVP

**Goal**: Display comprehensive standardized category list (18 Expense + 6 Income) with Material Icons in Category Selection screen, organized by type tabs. (US1, FR-001, FR-002, SC-001)

**Independent Test**: Open Category Selection screen and verify all 18 Expense categories on Expense tab and all 6 Income categories on Income tab, each with correct label and icon.

### Implementation for User Story 1

- [ ] T010 [P] [US1] Create `lib/screens/category_selection/category_selection_screen.dart` with TabBar for Expense/Income tabs (C001)
- [ ] T011 [P] [US1] Create `lib/screens/category_selection/widgets/category_tab_bar.dart` with two tabs labeled "Expense" and "Income" using colorScheme.primary for selected tab (C001, C004)
- [ ] T012 [P] [US1] Create `lib/screens/category_selection/widgets/category_list.dart` displaying filtered categories as ListView with ListTile items showing icon (24px), label, and checkmark for selected (C001, C004)
- [ ] T013 [P] [US1] Create `lib/screens/category_selection/widgets/category_item.dart` with Icon(leading), Text(title), trailing check icon using colorScheme.secondaryContainer for selected background (C001, C004)
- [ ] T014 [US1] Implement category filtering in category_list.dart: show only Expense categories when Expense tab selected, only Income categories when Income tab selected (C001, FR-001, FR-002)
- [ ] T015 [US1] Wire category icons from lib/models/ to category_item.dart using exact Material Icons specified in data-model.md (C001)
- [ ] T016 [US1] Add AppBar to category_selection_screen.dart with title "Select Category" and confirm action (C001)
- [ ] T017 [US1] Implement selection state in category_selection_screen.dart: single selection, pre-select if initial category provided, return selected category on confirm (C001)

**Checkpoint**: US1 deliverable - Category Selection screen displays all 24 categories correctly organized and filtered by type tabs. Independently testable via Scenario 1 in quickstart.md.

---

## Phase 4: User Story 2 - Slide-Up Add Transaction Transition (Priority: P1)

**Goal**: Add Transaction screen slides up smoothly from bottom with modal transition animation, maintains full-screen interactivity. (US2, FR-003, FR-004, FR-005, FR-006, SC-002)

**Independent Test**: Tap Add Transaction button and verify screen animates upward from bottom with smooth transition, completes in under 300ms at 60fps, all elements interactive after animation.

### Implementation for User Story 2

- [ ] T018 [P] [US2] Create `lib/screens/add_transaction/routes/slide_up_route.dart` with PageRouteBuilder using SlideTransition, begin=Offset(0.0, 1.0), end=Offset.zero, curve=Curves.easeInOut, duration=300ms (C002, research.md R1)
- [ ] T019 [US2] Update navigation in main.dart or navigation service to use slideUpRoute for AddTransactionScreen navigation (C002)
- [ ] T020 [US2] Update `lib/screens/add_transaction/add_transaction_screen.dart` to use SlideTransition for entry/exit animations (C002)
- [ ] T021 [US2] Verify all widgets in AddTransactionScreen remain fully interactive after animation completes (FR-005, C002)
- [ ] T022 [US2] Preserve unfocus mechanics: keyboard dismissal, input validation (FR-006, C005)
- [ ] T023 [P] [US2] Test animation performance with Flutter DevTools: duration ≤ 300ms, frame rate ≥ 60fps (SC-002)

**Checkpoint**: US2 deliverable - Add Transaction screen has smooth slide-up/down animation. Independently testable via Scenario 2 in quickstart.md.

---

## Phase 5: User Story 3 - Bi-Directional Type and Category Synchronization (Priority: P1)

**Goal**: Category and transaction type selections stay synchronized - changing type clears incompatible categories, selecting category updates type. (US3, FR-007, FR-008, FR-009, FR-010, SC-003)

**Independent Test**: On Add Transaction screen, change type and verify incompatible category cleared; select category and verify type updates to match.

### Implementation for User Story 3

- [ ] T024 [P] [US3] Update `lib/blocs/add_transaction/add_transaction_bloc.dart` or create if needed with AddTransactionState containing TransactionDraft (FR-007, data-model.md)
- [ ] T025 [P] [US3] Update `lib/blocs/add_transaction/add_transaction_event.dart` with events: TypeChanged(TransactionType), CategorySelected(Category), CategoryCleared() (FR-002)
- [ ] T026 [P] [US3] Update `lib/blocs/add_transaction/add_transaction_state.dart` with AddTransactionState extending Equatable containing TransactionDraft with props for type, category, amount, description, date (FR-003)
- [ ] T027 [US3] Implement TypeChanged handler in add_transaction_bloc.dart: update type, if current category is incompatible (category.type != new type), clear category (FR-007, FR-010, data-model.md)
- [ ] T028 [US3] Implement CategorySelected handler in add_transaction_bloc.dart: update category, update type to match category.type (FR-007, FR-008, FR-009)
- [ ] T029 [US3] Wire AddTransactionBloc to add_transaction_screen.dart using BlocProvider and BlocBuilder (FR-001)
- [ ] T030 [US3] Update type selector in add_transaction_screen.dart to dispatch TypeChanged events to bloc (C003)
- [ ] T031 [US3] Update category selector in add_transaction_screen.dart to dispatch CategorySelected events and navigate to CategorySelectionScreen with current type as filter (C001, C003)
- [ ] T032 [US3] Update category_selection_screen.dart to accept initialType parameter and filter categories accordingly (C001, C003)
- [ ] T033 [US3] Implement return from CategorySelection to AddTransaction: update bloc with selected category, verify type sync (C003, FR-008, FR-009)
- [ ] T034 [US3] Verify no invalid type-category pairs can be saved: validate in bloc before save event (SC-003)

**Checkpoint**: US3 deliverable - Bi-directional synchronization works correctly. Independently testable via Scenarios 3-5 in quickstart.md.

---

## Phase 6: Theme and Styling Compliance

**Goal**: Ensure all UI components follow theme-aware styling and maintain visual parity with existing app. (C004, FR-011, FR-012, FR-013, SC-004)

**Purpose**: Cross-cutting styling requirements that affect all user stories

- [ ] T035 [P] Verify all colors in Category Selection and Add Transaction screens use ThemeData.colorScheme, no hard-coded Colors (C004)
- [ ] T036 [P] Verify SegmentedButton in add_transaction_screen.dart uses native Material 3 implementation with colorScheme.primary for selected segment (C004, FR-011)
- [ ] T037 [P] Verify currency formatting remains right-aligned and signless across Dashboard and Ledger screens (FR-012)
- [ ] T038 [P] Verify theme-aware pastel color styling maintained across all screens (FR-013)
- [ ] T039 [P] Test light and dark theme modes: all elements readable and distinguishable without relying on color alone (C004, SC-004)

**Checkpoint**: All styling requirements met. Independently testable via Scenario 7 in quickstart.md.

---

## Phase 7: Polish & Cross-Cutting Validation

**Purpose**: Final validation, cleanup, and runtime verification

- [ ] T040 [P] Run `dart format lib/` and resolve any formatting changes
- [ ] T041 [P] Run `flutter analyze lib/` and confirm zero findings across all files (SC-004)
- [ ] T042 [P] Manually verify quickstart.md Scenarios 1-10: category display, animation, sync logic, draft persistence, theme toggle, currency formatting
- [ ] T043 [P] Verify SC-001: All 24 categories displayed with correct labels
- [ ] T044 [P] Verify SC-002: Animation completes in under 300ms with 60fps
- [ ] T045 [P] Verify SC-003: 100% of type-category mismatches prevented
- [ ] T046 [P] Verify SC-004: 100% of existing visual styling unchanged
- [ ] T047 [P] Regression test spec 008 features: theme toggle, BLoC state flow, Equatable adoption
- [ ] T048 [P] Remove any debug print statements or commented code

**Checkpoint**: All validation passed; feature ready for `/speckit-implement`.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: No dependencies - can start immediately
- **Phase 2 (Foundational)**: Depends on Phase 1 completion - **BLOCKS all user stories**
- **Phase 3 (US1)**: Depends on Phase 2 completion
- **Phase 4 (US2)**: Depends on Phase 2 completion
- **Phase 5 (US3)**: Depends on Phase 2 completion
- **Phase 6 (Theme)**: Depends on Phases 3-5 completion (can start after any story)
- **Phase 7 (Polish)**: Depends on all prior phases completion

### User Story Dependencies

- **User Story 1 (US1 - Category Dataset)**: Can start after Phase 2. No dependencies on US2 or US3. Independently testable.
- **User Story 2 (US2 - Slide-Up Transition)**: Can start after Phase 2. No dependencies on US1 or US3. Independently testable.
- **User Story 3 (US3 - Sync Logic)**: Can start after Phase 2. Depends on category models from Phase 2. May integrate with US1 (Category Selection) and US2 (Add Transaction screen), but should be independently testable.

### Within Each User Story

- Models before services before UI components
- Core implementation before integration
- Story complete and validated before final polish

### Critical Path (Sequential)

T001 → T002 → T003 → [T004-T009] → [T010-T017, T018-T023, T024-T034] → [T035-T039] → [T040-T048]

---

## Parallel Opportunities

### Phase 1 (Setup)
```bash
# All setup tasks can run in parallel:
T001: Verify project structure
T002: Run flutter pub get
T003: Run dart format + flutter analyze (baseline)
```

### Phase 2 (Foundational)
```bash
# Category model tasks can run in parallel (different files):
T004: Create transaction_type.dart
T005: Create category.dart
T006: Create expense_category.dart
T007: Create income_category.dart
T008: Create category_list.dart barrel
T009: Create transaction_draft.dart
```

### Phase 3 (US1 - Category Dataset)
```bash
# Category Selection screen tasks can run in parallel:
T010: Create category_selection_screen.dart
T011: Create category_tab_bar.dart
T012: Create category_list.dart
T013: Create category_item.dart
T014: Implement filtering
T015: Wire icons
T016: Add AppBar
T017: Implement selection state
```

### Phase 4 (US2 - Slide-Up Transition)
```bash
# Animation tasks can run in parallel:
T018: Create slide_up_route.dart
T021: Verify interactivity
T023: Test performance
```

### Phase 5 (US3 - Sync Logic)
```bash
# BLoC tasks can run in parallel:
T024: Create/Update add_transaction_bloc.dart
T025: Create/Update add_transaction_event.dart
T026: Create/Update add_transaction_state.dart

# Then wiring tasks (depend on BLoC):
T027-T034: Implement handlers and wiring
```

### Phase 6 (Theme & Styling)
```bash
# All theme verification tasks can run in parallel:
T035-T039: Verify colors, SegmentedButton, formatting, pastel styling, themes
```

### Phase 7 (Polish)
```bash
# All validation tasks can run in parallel:
T040-T048: Format, analyze, quickstart scenarios, regression tests
```

---

## Implementation Strategy

### MVP First (Minimum Viable Product)

**Stop after Phase 5 with these stories:**
1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (category models)
3. Complete Phase 3: US1 (Category Dataset)
4. **STOP and VALIDATE**: Category Selection displays all 24 categories correctly
5. Deploy/demo: Users can view and select standardized categories

**MVP Value**: Standardized category list is available for users.

### Incremental Delivery

1. **Increment 1** (MVP): Setup + Foundational + US1 → Category list functional
2. **Increment 2**: Add US2 → Smooth slide-up animation
3. **Increment 3**: Add US3 → Full bi-directional sync
4. **Increment 4**: Add Phase 6 + 7 → Full polish and validation

Each increment adds value without breaking previous functionality.

### Parallel Team Strategy

With multiple developers:

1. **All together**: Complete Setup (Phase 1) and Foundational (Phase 2)
2. **Split**:
   - Developer A: US1 (Category Dataset) - Phase 3
   - Developer B: US2 (Slide-Up Transition) - Phase 4
   - Developer C: US3 (Sync Logic) - Phase 5
3. **Rejoin**: Complete Theme (Phase 6) and Polish (Phase 7) together

All stories are independent after Phase 2, enabling parallel development.

---

## Dependencies Map

```
Phase 1 (Setup)
    │
    ▼
Phase 2 (Foundational: Category Models)
    ├─────────────┬─────────────┬─────────────┐
    ▼             ▼             ▼             
Phase 3        Phase 4        Phase 5      
(US1)          (US2)          (US3)        
    │             │             │             
    └─────────────┼─────────────┘             
                  ▼                           
            Phase 6 (Theme & Styling)
                  │                           
                  ▼                           
            Phase 7 (Polish & Validation)
```

---

## Notes

- [P] tasks = different files, no dependencies
- [US1], [US2], [US3] labels map tasks to specific user stories for traceability
- Each user story is independently completable and testable
- No automated tests per constitution - validation via `dart format`, `flutter analyze`, manual runtime verification
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- All file paths are exact and follow existing project structure from spec 008
