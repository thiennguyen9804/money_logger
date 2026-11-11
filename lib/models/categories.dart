/// Category definitions for the Money Logger application.
///
/// This file provides access to all predefined transaction categories.
/// Use the categories from category_list.dart for new code.
///
/// For backwards compatibility, this file exports:
/// - All 18 Expense categories
/// - All 6 Income categories
/// - Category lists grouped by type

export 'category_list.dart';

import 'category_list.dart';

// Re-export for backwards compatibility
final expenseTransactionCategories = ExpenseCategory.values;
final incomeTransactionCategories = IncomeCategory.values;
