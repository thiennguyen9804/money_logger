# Research: Standardized Category List and Slide-Up Add Transaction Flow

**Feature**: 009-enhance-add-transaction-categories  
**Date**: 2026-11-11  
**Status**: Complete

---

## R1: Slide-Up Animation Implementation

**Question**: What is the best practice for implementing a slide-up modal transition animation for a full-screen page in Flutter?

**Decision**: Use `PageRouteBuilder` with `SlideTransition` to create a custom slide-up animation that maintains full-screen interactivity.

**Rationale**: 
- `PageRouteBuilder` allows custom transition animations while preserving full-screen page behavior
- `SlideTransition` provides smooth animation with configurable duration and curve
- This approach maintains existing navigation patterns (back button, etc.) unlike `showModalBottomSheet` which has different dismissal behavior
- Target: under 300ms with 60fps rendering for smooth user experience

**Alternatives considered**:
- `showModalBottomSheet`: Rejected because it creates a modal sheet, not a full-screen page, and has different dismissal behavior (tap outside to dismiss)
- `CupertinoPageRoute`: Rejected because it uses platform-specific transitions (slide-up on iOS, fade on Android) and doesn't guarantee consistent behavior
- `MaterialPageRoute` with custom transition: Similar to chosen approach, but `PageRouteBuilder` is more explicit

**Implementation reference**:
```dart
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => AddTransactionScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  },
  transitionDuration: const Duration(milliseconds: 300),
)
```

---

## R2: Material Icons for Categories

**Question**: What Material Icons should be used for each of the 24 predefined categories?

**Decision**: Use the following Material Icons mappings (from Material Design Icons library):

**Expense Categories:**
- Fuel: `local_gas_station` - Standard icon for gasoline/fuel stations
- Transportation: `commute` - Represents daily commuting/travel
- Food & Beverage: `restaurant` - Standard icon for dining/food
- Rent: `home` - Represents home/rental property
- Lending: `account_balance_wallet` - Represents financial transactions/lending
- Debt Repayment: `receipt_long` - Represents bills and payments
- Vehicle Repair: `car_repair` - Specifically for vehicle maintenance
- Phone Bills: `phone_iphone` - Standard phone icon
- Haircut: `content_cut` - Represents cutting/scissors
- Healthcare: `local_hospital` - Standard healthcare icon
- Entertainment & Leisure: `movie` - Represents entertainment
- Other Expenses: `category` - Generic category/tagging icon
- Online Services: `public` - Represents online/web services
- Shopping: `shopping_bag` - Standard shopping icon
- Transfer Out: `compare_arrows` - Represents money transfer outward
- Gifts: `redeem` - Represents gifts/redeeming
- Vehicle Maintenance: `build` - Represents maintenance/construction
- Personal Care: `face` - Represents personal care/beauty

**Income Categories:**
- Transfer In: `compare_arrows` - Represents money transfer inward
- Salary: `work` - Represents employment/work income
- Other Income: `category` - Generic category icon
- Gifts Received: `redeem` - Represents received gifts
- Borrowing: `money` - Represents borrowed money
- Debt Collection: `credit_card` - Represents credit/debt

**Rationale**: 
- All icons are from the standard Material Icons library available in Flutter
- Icons are intuitive and commonly associated with their category meanings
- Icons maintain visual consistency with existing app styling
- Duplicate icons (compare_arrows, redeem, category) are acceptable as they represent related concepts

**Alternatives considered**:
- Custom SVG icons: Rejected to maintain consistency with existing Material Icons usage
- Different icon sets: Rejected as Material Icons are already used throughout the app

---

## R3: Bi-Directional Type-Category Synchronization Pattern

**Question**: What is the best pattern for maintaining bi-directional synchronization between transaction type (Income/Expense) and category selection?

**Decision**: Implement state management using the existing BLoC pattern (from spec 008 refactor) with the following approach:

1. **State Structure**: Maintain `TransactionDraft` state containing both `type` and `category`
2. **Type Change**: When type changes, validate the current category against the new type. If incompatible, clear the category.
3. **Category Change**: When category changes, automatically update the type to match the category's type (Expense/Income)
4. **Navigation Sync**: When navigating to Category Selection, filter categories by current type. When returning, update state with selected category.

**Rationale**:
- Aligns with existing BLoC architecture from spec 008
- Centralizes business logic in BLoC, not in UI
- Ensures data consistency across all screens
- Maintains single source of truth for transaction state

**Alternatives considered**:
- Local state in Add Transaction screen: Rejected as it would create inconsistency with Category Selection screen
- Direct widget-to-widget communication: Rejected as it violates BLoC pattern and creates tight coupling
- Callback functions: Rejected as BLoC provides cleaner separation of concerns

---

## R4: Category List Display and Filtering

**Question**: How should the category list be displayed and filtered by type?

**Decision**: 
- Use `TabBar` with two tabs: Expense and Income
- Each tab displays only categories of that type
- Selected category is highlighted with theme-aware styling
- Category items use `ListTile` with leading icon and trailing label

**Rationale**:
- Tab-based filtering is intuitive and commonly used in mobile apps
- Matches existing app patterns (if any tab-based screens exist)
- Provides clear visual separation between Expense and Income categories
- Easy to implement with Flutter's `TabBar` and `TabBarView`

**Alternatives considered**:
- Single list with type indicators: Rejected as it could be confusing with 24 categories
- Dropdown type selector + filtered list: Rejected as tabs provide better discoverability
- Chip-based filtering: Rejected as it may not scale well on small screens

---

## R5: Animation and Keyboard Handling

**Question**: How to ensure animation works correctly with keyboard appearance?

**Decision**: 
- Use `MediaQuery` to check for keyboard insets
- Ensure animation completes before focus is requested on input fields
- Use `SingleChildScrollView` with proper padding to handle keyboard overlap
- Preserve unfocus mechanics (keyboard dismissal on tap outside)

**Rationale**:
- Prevents animation and keyboard from interfering with each other
- Maintains usability on all screen sizes
- Follows Flutter best practices for text input

**Alternatives considered**:
- Resize-to-avoid-bottom-inset: Rejected as it can cause layout jumps
- Fixed padding: Rejected as it doesn't work across different screen sizes

---

## Summary

All research questions resolved. Implementation can proceed with:
1. Custom `PageRouteBuilder` with `SlideTransition` for slide-up animation
2. Material Icons as specified in R2
3. BLoC pattern for bi-directional synchronization
4. Tab-based category filtering
5. Proper keyboard handling with MediaQuery

No blocking issues identified.
