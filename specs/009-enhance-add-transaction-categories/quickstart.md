# Quickstart: Standardized Category List and Slide-Up Add Transaction Flow

**Feature**: 009-enhance-add-transaction-categories  
**Date**: 2026-11-11  
**Status**: Ready for validation

---

## Prerequisites

Before running validation scenarios, ensure:

1. **Flutter environment**: Flutter SDK installed and configured
   ```bash
   flutter doctor
   ```
   - All checks must pass (no Android/iOS toolchain issues)

2. **Dependencies**: All packages resolved
   ```bash
   cd /c/Users/thienhnnguyen/Downloads/money_logger
   flutter pub get
   ```

3. **Clean build**: Fresh build to ensure no cached artifacts
   ```bash
   flutter clean
   flutter pub get
   ```

4. **Code quality**: Passes static analysis and formatting
   ```bash
   dart format lib/
   flutter analyze lib/
   ```
   - Must report zero findings

5. **Device/Emulator**: At least one device or emulator available
   - iOS Simulator or Android Emulator
   - Physical device with USB debugging enabled

---

## Setup Commands

```bash
# Navigate to project directory
cd /c/Users/thienhnnguyen/Downloads/money_logger

# Ensure dependencies are resolved
flutter pub get

# Run the application
flutter run
```

---

## Validation Scenarios

### Scenario 1: Category List Display (US1 - Standardized English Category Dataset)

**Purpose**: Verify all 24 predefined categories are displayed correctly.

**Steps**:
1. Launch the application
2. Navigate to the Add Transaction screen (tap the Add button in bottom navigation)
3. Tap the category selector to open Category Selection screen

**Expected Results**:
- [ ] Category Selection screen opens
- [ ] Two tabs visible: "Expense" and "Income"
- [ ] "Expense" tab is selected by default
- [ ] All 18 Expense categories displayed:
  - Fuel (local_gas_station icon)
  - Transportation (commute icon)
  - Food & Beverage (restaurant icon)
  - Rent (home icon)
  - Lending (account_balance_wallet icon)
  - Debt Repayment (receipt_long icon)
  - Vehicle Repair (car_repair icon)
  - Phone Bills (phone_iphone icon)
  - Haircut (content_cut icon)
  - Healthcare (local_hospital icon)
  - Entertainment & Leisure (movie icon)
  - Other Expenses (category icon)
  - Online Services (public icon)
  - Shopping (shopping_bag icon)
  - Transfer Out (compare_arrows icon)
  - Gifts (redeem icon)
  - Vehicle Maintenance (build icon)
  - Personal Care (face icon)

**Continue**:
4. Tap the "Income" tab

**Expected Results**:
- [ ] All 6 Income categories displayed:
  - Transfer In (compare_arrows icon)
  - Salary (work icon)
  - Other Income (category icon)
  - Gifts Received (redeem icon)
  - Borrowing (money icon)
  - Debt Collection (credit_card icon)

**Verification Command**:
```bash
# Check category definitions in code
# (This is a manual code review step)
grep -r "Food & Beverage" lib/
grep -r "local_gas_station" lib/
```

---

### Scenario 2: Slide-Up Transition Animation (US2 - Slide-Up Add Transaction Transition)

**Purpose**: Verify the Add Transaction screen slides up from the bottom with smooth animation.

**Steps**:
1. Start on any screen (Dashboard or Ledger)
2. Tap the Add Transaction button in the bottom navigation bar

**Expected Results**:
- [ ] Add Transaction screen animates upward from the bottom of the screen
- [ ] Animation is smooth (no jank or frame drops)
- [ ] Animation completes within 300ms
- [ ] After animation completes, all screen elements are fully interactive

**Verification**:
- [ ] Visual: Animation appears smooth to the eye
- [ ] Touch: Can immediately interact with all buttons and fields after animation

**Advanced Verification** (using Flutter DevTools):
1. Open Flutter DevTools
2. Go to Performance tab
3. Start recording
4. Tap Add Transaction button
5. Stop recording
6. Check:
   - [ ] Animation duration ≤ 300ms
   - [ ] Frame rate ≥ 60fps (ideally 120fps on capable devices)

---

### Scenario 3: Bi-Directional Synchronization - Type Change (US3 - Bi-Directional Type and Category Synchronization)

**Purpose**: Verify that changing transaction type clears incompatible categories.

**Steps**:
1. Open Add Transaction screen
2. Ensure type selector shows Expense/Income (SegmentedButton)
3. Select "Expense" type
4. Tap category selector
5. Select "Fuel" category (Expense category)
6. Return to Add Transaction screen
7. Verify "Fuel" is selected
8. Switch type to "Income"

**Expected Results**:
- [ ] Transaction type changes to Income
- [ ] Previously selected "Fuel" category is cleared
- [ ] Category field shows "None" or placeholder
- [ ] No error or crash

---

### Scenario 4: Bi-Directional Synchronization - Category Selection (US3)

**Purpose**: Verify that selecting a category updates the transaction type.

**Steps**:
1. Open Add Transaction screen
2. Select "Expense" type
3. Clear any selected category
4. Tap category selector
5. Select "Salary" category (Income category)
6. Return to Add Transaction screen

**Expected Results**:
- [ ] "Salary" category is selected
- [ ] Transaction type automatically changes to "Income"
- [ ] Type selector shows "Income" as selected

---

### Scenario 5: Category Filtering by Type (US3)

**Purpose**: Verify that category list is filtered by transaction type.

**Steps**:
1. Open Add Transaction screen
2. Select "Expense" type
3. Tap category selector

**Expected Results**:
- [ ] Only Expense categories are visible in the list (18 categories)
- [ ] Income categories are not visible
- [ ] "Expense" tab is selected

**Continue**:
4. Switch to "Income" tab within Category Selection

**Expected Results**:
- [ ] Only Income categories are visible in the list (6 categories)
- [ ] Expense categories are not visible

---

### Scenario 6: Draft Persistence Across Navigation

**Purpose**: Verify that draft content survives navigation between screens.

**Steps**:
1. Open Add Transaction screen
2. Select "Expense" type
3. Enter amount: 100.00
4. Enter description: "Test transaction"
5. Select "Fuel" category
6. Tap category selector (to open Category Selection)
7. Cancel (tap back or outside)

**Expected Results**:
- [ ] Return to Add Transaction screen
- [ ] Type is still "Expense"
- [ ] Amount is still 100.00
- [ ] Description is still "Test transaction"
- [ ] Category is still "Fuel"

---

### Scenario 7: Theme Compatibility

**Purpose**: Verify all UI elements are readable in both light and dark themes.

**Steps**:
1. Open Category Selection screen
2. Verify all categories are readable (text and icons visible)
3. Toggle theme (if theme toggle exists)
4. Verify all categories are still readable in the new theme

**Expected Results**:
- [ ] In light theme: Text is dark, icons are visible, selected items are distinguishable
- [ ] In dark theme: Text is light, icons are visible, selected items are distinguishable
- [ ] No hard-coded color values used (Colors.red, Colors.green, etc.)
- [ ] All colors derived from ThemeData.colorScheme

**Verification Command**:
```bash
# Check for hard-coded colors
grep -r "Colors\\.red\|Colors\\.green\|Colors\\.blue" lib/ | grep -v "test" | grep -v ".git"
# Should return no results
```

---

### Scenario 8: SegmentedButton Behavior

**Purpose**: Verify native Material 3 SegmentedButton behavior is maintained.

**Steps**:
1. Open Add Transaction screen
2. Observe the type selector (Expense/Income)

**Expected Results**:
- [ ] Uses Flutter's built-in `SegmentedButton<TransactionType>`
- [ ] Selected segment uses `colorScheme.primary`
- [ ] Unselected segments use `colorScheme.surfaceVariant` or similar
- [ ] Selection state is visually clear
- [ ] Tapping segments changes selection immediately

---

### Scenario 9: Currency Formatting

**Purpose**: Verify right-aligned signless currency formatting is preserved.

**Steps**:
1. Open Dashboard or Ledger screen
2. Observe transaction amounts

**Expected Results**:
- [ ] Amounts are right-aligned
- [ ] No currency symbols (e.g., "$100.00" → "100.00")
- [ ] Formatting consistent across all screens

---

### Scenario 10: Complete Transaction Flow

**Purpose**: Verify end-to-end flow from category selection to transaction creation.

**Steps**:
1. Open Add Transaction screen
2. Select "Expense" type
3. Tap category selector
4. Select "Food & Beverage" category
5. Return to Add Transaction screen
6. Verify type is "Expense" and category is "Food & Beverage"
7. Enter amount: 50.00
8. Enter description: "Lunch"
9. Tap Save/Submit button

**Expected Results**:
- [ ] Transaction is created successfully
- [ ] Type is saved as Expense
- [ ] Category is saved as Food & Beverage
- [ ] Amount is saved as 50.00
- [ ] Transaction appears in Ledger with correct type and category
- [ ] Screen dismisses with slide-down animation

---

## Success Criteria Checklist

Run through all scenarios and check off as you go:

- [ ] **SC-001**: 100% of predefined categories (24 total) displayed with correct labels
- [ ] **SC-002**: Slide-up animation completes in under 300ms with 60fps
- [ ] **SC-003**: Bi-directional synchronization prevents 100% of type-category mismatches
- [ ] **SC-004**: 100% of existing visual styling remains unchanged

---

## Regression Testing

After implementing feature 009, verify that existing features still work:

1. **Theme Toggle** (from spec 008):
   - [ ] Toggling theme repaints all screens without state loss
   - [ ] All elements readable in both light and dark themes

2. **Transaction Updates** (from spec 007):
   - [ ] Adding a transaction updates Dashboard and Ledger immediately
   - [ ] Type/category compatibility enforced

3. **BLoC Architecture** (from spec 008):
   - [ ] All state flows through flutter_bloc blocs
   - [ ] Every event/state extends Equatable
   - [ ] No StreamController remains in codebase

---

## Common Issues and Troubleshooting

### Issue: Animation is janky or slow
**Solution**: 
- Check animation duration is ≤ 300ms
- Verify using `transitionDuration: Duration(milliseconds: 300)`
- Use `Curves.easeInOut` for smooth curve
- Test on physical device (emulators can be slow)

### Issue: Categories not displaying
**Solution**:
- Verify category list is properly defined
- Check that categories are being passed to CategorySelectionScreen
- Ensure TabBar is properly filtering categories by type

### Issue: Type-category mismatch
**Solution**:
- Verify bi-directional sync logic in BLoC
- Check that type change clears incompatible category
- Check that category selection updates type

### Issue: Slide-up animation not working
**Solution**:
- Verify using `PageRouteBuilder` with `SlideTransition`
- Check that `begin` is `Offset(0.0, 1.0)` and `end` is `Offset.zero`
- Ensure navigation is using custom route, not default MaterialPageRoute

---

## Code Quality Validation

Before considering implementation complete, run:

```bash
# Format all Dart files
dart format lib/

# Static analysis
flutter analyze lib/

# Both must complete with zero errors/warnings
```

---

## Sign-off

After all scenarios pass, the implementation is ready for:
- Manual QA testing
- Peer code review
- Merge to main branch

**Validator Name**: _______________________  
**Date**: _______________________  
**All Scenarios Passed**: ☐ Yes  ☐ No
