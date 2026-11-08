import 'package:flutter/material.dart';

import 'transaction.dart';

// Expense categories
const expenseFoodCategory = TransactionCategory(
  label: 'Food',
  icon: Icons.restaurant_outlined,
  color: Colors.orange,
  type: TransactionType.expense,
);

const expenseGroceriesCategory = TransactionCategory(
  label: 'Groceries',
  icon: Icons.shopping_basket_outlined,
  color: Colors.purple,
  type: TransactionType.expense,
);

const expenseTransportCategory = TransactionCategory(
  label: 'Transport',
  icon: Icons.directions_car_outlined,
  color: Colors.blue,
  type: TransactionType.expense,
);

const expenseUtilitiesCategory = TransactionCategory(
  label: 'Utilities',
  icon: Icons.bolt_outlined,
  color: Colors.teal,
  type: TransactionType.expense,
);

const expenseUtilitiesInternetCategory = TransactionCategory(
  label: 'Utilities',
  icon: Icons.wifi_outlined,
  color: Colors.teal,
  type: TransactionType.expense,
);

// Income categories
const incomeSalaryCategory = TransactionCategory(
  label: 'Income',
  icon: Icons.payments_outlined,
  color: Colors.green,
  type: TransactionType.income,
);

const incomeFreelanceCategory = TransactionCategory(
  label: 'Freelance',
  icon: Icons.work_outline,
  color: Colors.green,
  type: TransactionType.income,
);

const incomeGiftsCategory = TransactionCategory(
  label: 'Gifts',
  icon: Icons.card_giftcard_outlined,
  color: Colors.lightGreen,
  type: TransactionType.income,
);

// Category lists
const expenseTransactionCategories = <TransactionCategory>[
  expenseFoodCategory,
  expenseGroceriesCategory,
  expenseTransportCategory,
  expenseUtilitiesCategory,
];

const incomeTransactionCategories = <TransactionCategory>[
  incomeSalaryCategory,
  incomeFreelanceCategory,
  incomeGiftsCategory,
];
