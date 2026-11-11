# UI Contracts: Standardized Category List and Slide-Up Add Transaction Flow

**Feature**: 009-enhance-add-transaction-categories  
**Date**: 2026-11-11  
**Status**: Complete

---

## Overview

This document defines the UI contracts for the enhanced Add Transaction flow, including:
1. Category Selection UI components
2. Add Transaction screen transition animation
3. Bi-directional synchronization behavior
4. Theme and styling requirements

---

## Contract C001: Category Selection Screen

### Purpose
Display a comprehensive list of predefined categories organized by type (Expense/Income) and allow user selection.

### Inputs
- `initialType` (TransactionType, optional): Initial type filter. Default: previous selection or Expense.
- `initialCategory` (Category, optional): Initially selected category. Default: null.

### UI Components

#### TabBar
- **Position**: Top of screen
- **Items**: Two tabs labeled "Expense" and "Income"
- **Behavior**:
  - Switching tabs filters category list to show only categories of that type
  - Selected tab is highlighted with theme-aware color
  - Tab indicator uses `colorScheme.primary`
- **Styling**:
  - Tab label style: `Theme.of(context).textTheme.titleMedium`
  - Selected tab color: `colorScheme.primary`
  - Unselected tab color: `colorScheme.onSurface.withOpacity(0.6)`

#### Category List
- **Type**: Vertical `ListView`
- **Item Type**: `ListTile`
- **Item Structure**:
  ```
  ListTile(
    leading: Icon(category.icon, size: 24),
    title: Text(category.label),
    trailing: selected ? Icon(Icons.check, color: colorScheme.primary) : null,
    onTap: () => selectCategory(category),
  )
  ```
- **Behavior**:
  - Single selection mode (only one category can be selected at a time)
  - Tapping a category selects it and highlights it
  - Selected category shows checkmark icon on the right
- **Styling**:
  - List tile height: 56 (standard Material)
  - Icon color: `colorScheme.onSurfaceVariant`
  - Text style: `Theme.of(context).textTheme.bodyLarge`
  - Selected background: `colorScheme.secondaryContainer`
  - Hover/splash effects: Standard Material

#### Empty State
- **Trigger**: No categories of the selected type (should not occur with static list)
- **Display**: Centered text "No categories available"

#### App Bar
- **Title**: "Select Category"
- **Actions**:
  - Confirm button (check icon) - closes screen and returns selected category
- **Behavior**:
  - Confirm button disabled if no category selected
  - Back button cancels selection

### Outputs
- **On Confirm**: Returns selected `Category` object
- **On Cancel**: Returns `null`

### Success Criteria
- [ ] All 18 Expense categories displayed on Expense tab
- [ ] All 6 Income categories displayed on Income tab
- [ ] Each category shows correct label and icon
- [ ] Selection state persists across tab switches
- [ ] Tabs filter categories correctly

---

## Contract C002: Add Transaction Screen Transition

### Purpose
Provide a smooth slide-up modal transition when navigating to the Add Transaction screen.

### Inputs
- `context` (BuildContext): Navigation context
- `arguments` (optional): Any arguments passed to the screen

### Transition Properties
- **Type**: Custom page route with slide transition
- **Direction**: From bottom to top
- **Duration**: 300ms
- **Curve**: `Curves.easeInOut`
- **Full-screen**: Yes (takes up entire screen)

### Implementation Contract
```dart
// Route builder contract
PageRoute<T> slideUpRoute<T>({required WidgetBuilder pageBuilder}) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => 
        pageBuilder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);  // Start from bottom
      const end = Offset.zero;         // End at center
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
```

### Animation Behavior
- **Forward**: Screen slides up from bottom, fades in slightly
- **Reverse**: Screen slides down to bottom, fades out slightly
- **Performance**: Must maintain 60fps rendering
- **Timing**: Must complete within 300ms

### Navigation Contract
- **Trigger**: User taps Add Transaction button in bottom navigation bar
- **Action**: `Navigator.push(context, slideUpRoute(pageBuilder: (_) => AddTransactionScreen()))`
- **Return**: User taps back button or completes transaction
- **Dismiss Action**: `Navigator.pop(context, result)` where result contains transaction data

### Success Criteria
- [ ] Animation completes in under 300ms
- [ ] Animation renders at 60fps
- [ ] Screen is fully interactive after animation completes
- [ ] Back button dismisses with reverse animation
- [ ] No visual glitches during animation

---

## Contract C003: Bi-Directional Type-Category Synchronization

### Purpose
Maintain synchronization between transaction type and category selection to prevent mismatched pairs.

### Synchronization Rules

#### Rule 1: Type → Category
**When**: User changes transaction type (e.g., Expense → Income)

**Then**:
1. Check if current selected category is compatible with new type
2. If compatible (category.type == new type): Keep category selected
3. If incompatible: Clear category selection (set to null)
4. Filter category list to show only categories of new type

**Example**:
- Current: type=Expense, category=Fuel
- User changes type to Income
- Result: type=Income, category=null (Fuel is Expense, incompatible)

#### Rule 2: Category → Type
**When**: User selects a category (e.g., Salary)

**Then**:
1. Update transaction type to match category.type
2. Keep category selected
3. If category is from Category Selection screen, update type before returning

**Example**:
- Current: type=Expense, category=null
- User selects Salary (Income category)
- Result: type=Income, category=Salary

#### Rule 3: Navigation Sync
**When**: User navigates to Category Selection from Add Transaction

**Then**:
1. Open Category Selection with initialType = current transaction type
2. Filter category list to show only categories of initialType
3. If current category is set, pre-select it

**When**: User returns from Category Selection

**Then**:
1. Update transaction draft with selected category
2. Update transaction type to match category.type (Rule 2)
3. Trigger UI rebuild to show new selection

### State Machine

```
                    ┌─────────────────────────────────────┐
                    │           TransactionDraft           │
                    ├─────────────────┬───────────────────┤
                    │ type            │ category          │
┌─────────────────┬─▼─────────────────┼───────────────────▼──┐
│                 │                     │                       │  │
│  User Action    │ Type Change         │ Category Selection    │  │
│                 │                     │                       │  │
▼                 ▼                     ▼                       ▼  │
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  IF new type != category.type:                              │
│     category = null                                         │
│  type = new type                                            │
│                                                                 │
│  IF new category.type != type:                              │
│     type = new category.type                                │
│  category = new category                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Validation Rules
- At any time: `category == null || category.type == type`
- When saving: `type != null && category != null`
- Type and category must never be in conflict

### Success Criteria
- [ ] 100% of type changes clear incompatible categories
- [ ] 100% of category selections update type correctly
- [ ] Navigation to/from Category Selection preserves sync
- [ ] No invalid type-category pairs can be saved

---

## Contract C004: Theme and Styling

### Purpose
Maintain visual consistency with existing app styling and Material Design 3 guidelines.

### Color Contract
- **SegmentedButton**: Use `colorScheme.primary` for selected segment, `colorScheme.surfaceVariant` for unselected
- **Category Icons**: Use `colorScheme.onSurfaceVariant`
- **Selected Category**: Use `colorScheme.secondaryContainer` for background
- **Text**: Use theme's text theme (titleMedium for tabs, bodyLarge for list items)

### Typography Contract
- Use `Theme.of(context).textTheme` for all text
- No hard-coded font sizes or colors
- Maintain consistency with existing app typography

### Spacing Contract
- Use Material Design spacing system (4, 8, 12, 16, 24, etc.)
- Standard ListTile height: 56
- Standard padding: EdgeInsets.all(16) for screens, EdgeInsets.symmetric(horizontal: 16) for app bars

### Visual Parity Requirements
- **SegmentedButton**: Native Material 3 widget, no custom implementations
- **Currency Formatting**: Right-aligned, signless (e.g., "1,234.56" not "$1,234.56")
- **Theme Colors**: Use `ThemeData.colorScheme`, no hard-coded Colors.red/Colors.green
- **Pastel Styling**: Maintain existing pastel color scheme across all screens

### Success Criteria
- [ ] No hard-coded color values (Colors.red, Colors.green, etc.)
- [ ] All colors derived from ThemeData.colorScheme
- [ ] SegmentedButton uses native Material 3 implementation
- [ ] Currency formatting matches existing app behavior
- [ ] Visual styling consistent in light and dark themes

---

## Contract C005: Keyboard and Input Handling

### Purpose
Ensure animation and input fields work correctly together.

### Input Field Contract
- **Focus**: Can be requested after animation completes
- **Keyboard**: Opens automatically when input field gains focus
- **Dismissal**: Tapping outside input field dismisses keyboard

### Animation-Keyboard Coordination
- **During Animation**: No focus changes, no keyboard interactions
- **After Animation**: Input fields can receive focus and show keyboard
- **Screen Resizing**: Screen content scrolls to keep focused input visible

### Behavior Contract
- **Slide-up animation**: Must not cause layout jumps when keyboard appears
- **Input validation**: Standard Flutter validation (onSubmit, onChanged)
- **Unfocus**: Maintain existing unfocus mechanics from current implementation

### Success Criteria
- [ ] Keyboard appearance doesn't interfere with animation
- [ ] All input fields accessible after animation
- [ ] Keyboard dismissal works correctly (tap outside)
- [ ] Focus behavior consistent across all input fields

---

## Contract Summary

| Contract | Purpose | Key Requirements |
|----------|---------|------------------|
| C001 | Category Selection Screen | Tab-based filtering, 24 categories, Material Icons |
| C002 | Add Transaction Transition | Slide-up from bottom, 300ms, 60fps, full-screen |
| C003 | Bi-Directional Sync | Type→Category and Category→Type synchronization |
| C004 | Theme and Styling | ColorScheme-based, Material 3, visual parity |
| C005 | Keyboard Handling | Animation-keyboard coordination, input focus |

---

## Validation Matrix

| Contract | Acceptance Scenario | Test Method | Expected Result |
|----------|---------------------|-------------|-----------------|
| C001 | Open Category Selection, view Expense tab | Manual | 18 Expense categories displayed |
| C001 | Open Category Selection, view Income tab | Manual | 6 Income categories displayed |
| C001 | Select a category | Manual | Category highlighted, checkmark shown |
| C002 | Navigate to Add Transaction | Manual | Screen slides up from bottom |
| C002 | Dismiss Add Transaction | Manual | Screen slides down to bottom |
| C002 | Measure animation performance | DevTools | <300ms, 60fps |
| C003 | Change type with incompatible category | Manual | Category cleared |
| C003 | Select category | Manual | Type updates to match category |
| C004 | Check color usage | Code review | No hard-coded colors |
| C004 | Toggle theme | Manual | All elements readable in both themes |
| C005 | Focus input field after animation | Manual | Keyboard appears, field focused |

---

## Compliance Notes

All contracts must be implemented in compliance with:
- Project Constitution (Clean Code, Simple UX, Responsive Design, Minimal Dependencies, No Automated Testing)
- Feature Specification (specs/009-enhance-add-transaction-categories/spec.md)
- Research Findings (research.md)
- Data Model (data-model.md)
