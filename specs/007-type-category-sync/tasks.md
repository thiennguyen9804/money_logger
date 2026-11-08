# Tasks: Type and Category Synchronization

**Input**: Design documents from `/specs/007-type-category-sync/`

**Prerequisites**: plan.md, spec.md, data-model.md, contracts/ui-contract.md, research.md, quickstart.md

**Tests**: OPTIONAL - excluded per constitution (No Automated Testing)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Create feature branch `007-type-category-sync` from master
- [X] T002 Verify Flutter SDK ^3.13.7 and Dart compatibility per pubspec.yaml
- [X] T003 [P] Run static validation: `dart format lib/main.dart` and `flutter analyze`

**Checkpoint**: Environment ready for implementation

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T004 Add type property to TransactionCategory model in lib/main.dart to support Income/Expense grouping
- [X] T005 [P] Add helper methods to TransactionCategory for type-based filtering in lib/main.dart
- [X] T006 Create CategorySelectionSession state class in lib/main.dart per data-model.md specification

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Filter categories from the selected type (Priority: P1) 🎯 MVP

**Goal**: Category selection screen opens on the tab matching the form's current transaction type

**Independent Test**: Select Expense on Add Transaction, open categories, verify Expense group is active; repeat with Income

### Implementation for User Story 1

- [X] T007 [US1] Modify _CategorySelectionPage to accept initialTransactionType parameter in lib/main.dart
- [X] T008 [US1] Update _CategorySelectionPage to initialize _tabIndex based on initialTransactionType in lib/main.dart (0 for Expense, 1 for Income)
- [X] T009 [US1] Pass current _draft.type from _AddTransactionPageState to _CategorySelectionPage in lib/main.dart
- [X] T010 [US1] Verify TabBar initialization reflects the passed transaction type in lib/main.dart
- [X] T011 [US1] Ensure expenseTransactionCategories and incomeTransactionCategories are properly filtered by type in lib/main.dart

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Synchronize a selected category back to type (Priority: P1) 🎯 MVP

**Goal**: Selecting a category from another type updates the transaction type on the main form

**Independent Test**: Open categories, switch tabs, select a category from the other type, and verify the main form changes to that category's type

### Implementation for User Story 2

- [X] T012 [US2] Modify _CategorySelectionPage to return both TransactionCategory and TransactionType in lib/main.dart
- [X] T013 [US2] Update _CategorySelectionPageState to determine type from selected category's group in lib/main.dart
- [X] T014 [US2] Modify _AddTransactionPageState._save() to handle the returned type from category selection in lib/main.dart
- [X] T015 [US2] Update _AddTransactionPageState category selection handler to update both _draft.category and _draft.type in lib/main.dart
- [X] T016 [US2] Add validation in _AddTransactionPageState to ensure category.type matches _draft.type in lib/main.dart
- [X] T017 [US2] Implement logic to clear or replace incompatible category when transaction type changes in lib/main.dart (FR-005)
- [X] T018 [US2] Preserve original type and category when returning from category selection without selection in lib/main.dart (FR-004)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Understand type selection through contextual styling (Priority: P2)

**Goal**: Active type segment uses contextual accent while inactive segment remains neutral

**Independent Test**: Toggle Income and Expense in light, dark, and pastel themes and verify active segment accent changes while inactive remains neutral

### Implementation for User Story 3

- [X] T019 [US3] Update SegmentedButton<TransactionType> in _AddTransactionPage to use contextual colors in lib/main.dart
- [X] T020 [US3] Define pastel green/sage accent for Income active state per FR-006 in lib/main.dart
- [X] T021 [US3] Define pastel red/rose accent for Expense active state per FR-007 in lib/main.dart
- [X] T022 [US3] Ensure inactive segment retains neutral styling per FR-008 in lib/main.dart
- [X] T023 [US3] Add Theme-based color scheme support for active accents in light/dark/pastel themes per FR-010 in lib/main.dart
- [X] T024 [US3] Verify directional icons and text labels remain visible in all themes per FR-010 in lib/main.dart
- [X] T025 [US3] Ensure active and inactive states remain readable and distinguishable without color alone per FR-010 in lib/main.dart

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Edge Cases and Polish

**Purpose**: Handle edge cases and ensure robustness across all scenarios

- [X] T026 [P] Handle empty category groups with clear unavailable state per Edge Cases in lib/main.dart
- [X] T027 [P] Ensure long category names remain readable without clipping or horizontal overflow per FR-011 in lib/main.dart
- [X] T028 [P] Verify controls remain usable at narrow widths and increased text scale per FR-011 in lib/main.dart
- [X] T029 [P] Ensure type/category updates are reactive across navigation transitions per FR-009 in lib/main.dart
- [X] T030 [P] Add validation to prevent mismatched type/category pairs from being saved per FR-003 in lib/main.dart
- [X] T031 [P] Test cross-tab selection scenario: Expense selected, switch to Income tab, select Income category, verify form updates to Income in lib/main.dart
- [X] T032 [P] Test back-without-selection scenario: Change tabs, press Back, verify original type/category unchanged in lib/main.dart

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final validation and code quality

- [X] T033 [P] Run dart format on all modified files in lib/main.dart
- [X] T034 Run flutter analyze and fix all warnings in lib/main.dart
- [X] T035 Verify all Success Criteria (SC-001 through SC-005) pass manual testing
- [X] T036 Verify quickstart.md runtime scenarios 1-7 all pass
- [X] T037 Verify UI Contract requirements are met: category route entry, category selection, type segmented control, themes and responsiveness
- [X] T038 Review code against Clean Code principle (I) - ensure readable, focused, maintainable
- [X] T039 Review UX against Simple UX principle (II) - minimize cognitive load, clear controls
- [X] T040 Review responsiveness against Responsive Design principle (III) - usable across form factors and text scales
- [X] T041 Verify Minimal Dependencies principle (IV) - no new packages added
- [X] T042 Verify No Automated Testing principle (V) - no test files added

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User Story 1 (P1): Can start after Foundational (Phase 2) - No dependencies on other stories
  - User Story 2 (P1): Can start after Foundational (Phase 2) - Depends on User Story 1 for tab initialization
  - User Story 3 (P2): Can start after Foundational (Phase 2) - Independent of US1 and US2
- **Edge Cases (Phase 6)**: Depends on all user stories being complete
- **Polish (Phase 7)**: Depends on all desired user stories and edge cases being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - Requires User Story 1 tab initialization to be complete
- **User Story 3 (P2)**: Can start after Foundational (Phase 2) - Independent, focuses on styling only

### Within Each User Story

- Tests (if included) MUST be written and FAIL before implementation
- Models before services
- Services before endpoints
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, User Stories 1, 2, and 3 can start in parallel (if team capacity allows)
- All Edge Case tasks marked [P] can run in parallel
- All Polish tasks marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: User Story 1

```bash
# Launch all models and initialization for User Story 1 together:
Task: "Modify _CategorySelectionPage to accept initialTransactionType parameter in lib/main.dart"
Task: "Update _CategorySelectionPage to initialize _tabIndex based on initialTransactionType in lib/main.dart"
Task: "Pass current _draft.type from _AddTransactionPageState to _CategorySelectionPage in lib/main.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 + User Story 2 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (Filter categories)
4. Complete Phase 4: User Story 2 (Synchronize category back)
5. **STOP and VALIDATE**: Test User Stories 1 AND 2 independently
6. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Stories 1 + 2 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 3 → Test independently → Deploy/Demo
4. Add Edge Cases and Polish → Final validation → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (Tab initialization and filtering)
   - Developer B: User Story 2 (Category-type synchronization)
   - Developer C: User Story 3 (Contextual styling)
3. Stories complete and integrate independently
4. All developers: Edge Cases and Polish

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- All tasks follow the strict checklist format: checkbox, ID, labels, file paths
- No automated tests per constitution principle V
- All changes must preserve type safety per Clean Code principle I
- All UI changes must minimize cognitive load per Simple UX principle II
- All layouts must be responsive per Responsive Design principle III
- No new dependencies per Minimal Dependencies principle IV

---

## Coverage Summary

| Requirement Key | Has Task? | Task IDs | Notes |
|-----------------|-----------|----------|-------|
| FR-001 | Yes | T007-T011 | Category group matching transaction type |
| FR-002 | Yes | T010-T011 | Type-based category filtering |
| FR-003 | Yes | T012-T016 | Synchronize category and type together |
| FR-004 | Yes | T018 | Preserve original on back without selection |
| FR-005 | Yes | T017 | Clear incompatible category on type change |
| FR-006 | Yes | T019-T021 | Income active accent (pastel green/sage) |
| FR-007 | Yes | T019-T021 | Expense active accent (pastel red/rose) |
| FR-008 | Yes | T022 | Neutral inactive styling |
| FR-009 | Yes | T029 | Reactive updates across navigation |
| FR-010 | Yes | T023-T025 | Theme support and non-color distinction |
| FR-011 | Yes | T027-T028 | Responsive design requirements |
| SC-001 | Yes | T031 | Manual verification of category group matching |
| SC-002 | Yes | T031 | Manual verification of cross-tab selection |
| SC-003 | Yes | T032 | Manual verification of back-without-selection |
| SC-004 | Yes | T023-T025 | Manual theme review |
| SC-005 | Yes | T027-T028 | Manual narrow-width and text-scale review |

---

## Metrics

- **Total Requirements**: 11 Functional Requirements + 5 Success Criteria = 16
- **Total Tasks**: 42
- **Coverage %**: 100% (All requirements have >=1 task)
- **Parallel Opportunities**: 18 tasks marked [P]
- **User Stories**: 3 (US1, US2, US3)
- **MVP Scope**: User Stories 1 and 2 (T007-T018)
