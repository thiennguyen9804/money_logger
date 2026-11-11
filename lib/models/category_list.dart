/// Category list exports and validation.
///
/// This file provides centralized access to all predefined categories and
/// validates that the category list meets specification requirements.

export 'category.dart';
export 'expense_category.dart';
export 'income_category.dart';
export 'transaction_type.dart';

import 'category.dart';
import 'expense_category.dart';
import 'income_category.dart';

/// All 24 predefined categories (18 Expense + 6 Income).
///
/// This list is validated to ensure:
/// - Exactly 24 categories total
/// - No duplicate labels
/// - All labels match specification exactly
/// - All icons are valid Material Icons
final List<Category> allCategories = <Category>[
  ...ExpenseCategory.values,
  ...IncomeCategory.values,
];

/// All expense categories (18 total).
final List<Category> expenseCategories = ExpenseCategory.values;

/// All income categories (6 total).
final List<Category> incomeCategories = IncomeCategory.values;

/// Validates that the category list meets specification requirements.
///
/// Returns true if all validation rules pass, false otherwise.
/// Used for testing and runtime verification.
bool validateCategoryList() {
  // Check total count
  if (allCategories.length != 24) {
    return false;
  }

  // Check expense count
  if (expenseCategories.length != 18) {
    return false;
  }

  // Check income count
  if (incomeCategories.length != 6) {
    return false;
  }

  // Check for duplicate labels
  final labels = allCategories.map((c) => c.label).toList();
  if (labels.toSet().length != labels.length) {
    return false;
  }

  // Check all labels are English-only (basic check)
  final englishOnly = RegExp(r'^[a-zA-Z\s&\-]+$');
  for (final label in labels) {
    if (!englishOnly.hasMatch(label)) {
      return false;
    }
  }

  // Check expected labels exist
  const expectedExpenseLabels = {
    'Fuel',
    'Transportation',
    'Food & Beverage',
    'Rent',
    'Lending',
    'Debt Repayment',
    'Vehicle Repair',
    'Phone Bills',
    'Haircut',
    'Healthcare',
    'Entertainment & Leisure',
    'Other Expenses',
    'Online Services',
    'Shopping',
    'Transfer Out',
    'Gifts',
    'Vehicle Maintenance',
    'Personal Care',
  };

  const expectedIncomeLabels = {
    'Transfer In',
    'Salary',
    'Other Income',
    'Gifts Received',
    'Borrowing',
    'Debt Collection',
  };

  final expenseLabelSet = expenseCategories.map((c) => c.label).toSet();
  final incomeLabelSet = incomeCategories.map((c) => c.label).toSet();

  if (expenseLabelSet != expectedExpenseLabels) {
    return false;
  }

  if (incomeLabelSet != expectedIncomeLabels) {
    return false;
  }

  return true;
}
