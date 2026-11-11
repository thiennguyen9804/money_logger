// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Money Logger';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navAddTransaction => 'Add Transaction';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navProfile => 'Profile';

  @override
  String get purposeDashboard => 'Financial summary and recent activity';

  @override
  String get purposeTransactions => 'Monthly income and expense history';

  @override
  String get purposeAddTransaction => 'Primary income or expense entry point';

  @override
  String get purposeBudgets => 'Spending limits and category budgets';

  @override
  String get purposeProfile =>
      'Account, preferences, security, and theme settings';

  @override
  String get startEntry => 'Start a new income or expense entry.';

  @override
  String destinationItem(Object destination, Object index) {
    return '$destination item $index';
  }

  @override
  String get darkMode => 'Dark mode';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get toggle => 'Toggle';

  @override
  String get language => 'Language';

  @override
  String get english => 'English (US)';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get recentActivityEmpty => 'Your recent activity will appear here.';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get balanceHidden => 'Balance hidden';

  @override
  String get hideBalance => 'Hide balance';

  @override
  String get showBalance => 'Show balance';

  @override
  String get noMonthTransactions => 'No transactions recorded for this month.';

  @override
  String dailyTotal(Object amount) {
    return 'Daily total: $amount';
  }

  @override
  String get dashboard => 'Dashboard';

  @override
  String get transactions => 'Transactions';

  @override
  String get back => 'Back';

  @override
  String get save => 'Save';

  @override
  String get addTransactionForm => 'Add transaction form';

  @override
  String get amount => 'Amount';

  @override
  String get amountHintUsd => '0.00';

  @override
  String get amountHintVnd => '0';

  @override
  String get enterAmountError => 'Enter an amount greater than zero.';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get selectCategoryError => 'Select a category.';

  @override
  String get categoryTypeError =>
      'Category type does not match transaction type.';

  @override
  String get dateTime => 'Date and time';

  @override
  String get moreDetails => 'More Details';

  @override
  String get addEvent => 'Add an event or campaign';

  @override
  String get eventCampaign => 'Event or campaign';

  @override
  String get noEvent => 'No event';

  @override
  String get holidaySpending => 'Holiday spending';

  @override
  String get homeRenovation => 'Home renovation';

  @override
  String get birthdayCelebration => 'Birthday celebration';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get noCategories => 'No categories available';

  @override
  String get noCategoriesType => 'There are no categories for this type';

  @override
  String get selected => 'selected';

  @override
  String get neutral => 'Neutral';

  @override
  String get categoryFuel => 'Fuel';

  @override
  String get categoryTransportation => 'Transportation';

  @override
  String get categoryFoodAndBeverage => 'Food & Beverage';

  @override
  String get categoryRent => 'Rent';

  @override
  String get categoryLending => 'Lending';

  @override
  String get categoryDebtRepayment => 'Debt Repayment';

  @override
  String get categoryVehicleRepair => 'Vehicle Repair';

  @override
  String get categoryPhoneBills => 'Phone Bills';

  @override
  String get categoryHaircut => 'Haircut';

  @override
  String get categoryHealthcare => 'Healthcare';

  @override
  String get categoryEntertainmentAndLeisure => 'Entertainment & Leisure';

  @override
  String get categoryOtherExpenses => 'Other Expenses';

  @override
  String get categoryOnlineServices => 'Online Services';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryTransferOut => 'Transfer Out';

  @override
  String get categoryGifts => 'Gifts';

  @override
  String get categoryVehicleMaintenance => 'Vehicle Maintenance';

  @override
  String get categoryPersonalCare => 'Personal Care';

  @override
  String get categoryTransferIn => 'Transfer In';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryOtherIncome => 'Other Income';

  @override
  String get categoryGiftsReceived => 'Gifts Received';

  @override
  String get categoryBorrowing => 'Borrowing';

  @override
  String get categoryDebtCollection => 'Debt Collection';
}

/// The translations for English, as used in the United States (`en_US`).
class AppLocalizationsEnUs extends AppLocalizationsEn {
  AppLocalizationsEnUs() : super('en_US');

  @override
  String get appTitle => 'Money Logger';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navAddTransaction => 'Add Transaction';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navProfile => 'Profile';

  @override
  String get purposeDashboard => 'Financial summary and recent activity';

  @override
  String get purposeTransactions => 'Monthly income and expense history';

  @override
  String get purposeAddTransaction => 'Primary income or expense entry point';

  @override
  String get purposeBudgets => 'Spending limits and category budgets';

  @override
  String get purposeProfile =>
      'Account, preferences, security, and theme settings';

  @override
  String get startEntry => 'Start a new income or expense entry.';

  @override
  String destinationItem(Object destination, Object index) {
    return '$destination item $index';
  }

  @override
  String get darkMode => 'Dark mode';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get toggle => 'Toggle';

  @override
  String get language => 'Language';

  @override
  String get english => 'English (US)';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get recentActivityEmpty => 'Your recent activity will appear here.';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get balanceHidden => 'Balance hidden';

  @override
  String get hideBalance => 'Hide balance';

  @override
  String get showBalance => 'Show balance';

  @override
  String get noMonthTransactions => 'No transactions recorded for this month.';

  @override
  String dailyTotal(Object amount) {
    return 'Daily total: $amount';
  }

  @override
  String get dashboard => 'Dashboard';

  @override
  String get transactions => 'Transactions';

  @override
  String get back => 'Back';

  @override
  String get save => 'Save';

  @override
  String get addTransactionForm => 'Add transaction form';

  @override
  String get amount => 'Amount';

  @override
  String get amountHintUsd => '0.00';

  @override
  String get amountHintVnd => '0';

  @override
  String get enterAmountError => 'Enter an amount greater than zero.';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get selectCategoryError => 'Select a category.';

  @override
  String get categoryTypeError =>
      'Category type does not match transaction type.';

  @override
  String get dateTime => 'Date and time';

  @override
  String get moreDetails => 'More Details';

  @override
  String get addEvent => 'Add an event or campaign';

  @override
  String get eventCampaign => 'Event or campaign';

  @override
  String get noEvent => 'No event';

  @override
  String get holidaySpending => 'Holiday spending';

  @override
  String get homeRenovation => 'Home renovation';

  @override
  String get birthdayCelebration => 'Birthday celebration';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get noCategories => 'No categories available';

  @override
  String get noCategoriesType => 'There are no categories for this type';

  @override
  String get selected => 'selected';

  @override
  String get neutral => 'Neutral';

  @override
  String get categoryFuel => 'Fuel';

  @override
  String get categoryTransportation => 'Transportation';

  @override
  String get categoryFoodAndBeverage => 'Food & Beverage';

  @override
  String get categoryRent => 'Rent';

  @override
  String get categoryLending => 'Lending';

  @override
  String get categoryDebtRepayment => 'Debt Repayment';

  @override
  String get categoryVehicleRepair => 'Vehicle Repair';

  @override
  String get categoryPhoneBills => 'Phone Bills';

  @override
  String get categoryHaircut => 'Haircut';

  @override
  String get categoryHealthcare => 'Healthcare';

  @override
  String get categoryEntertainmentAndLeisure => 'Entertainment & Leisure';

  @override
  String get categoryOtherExpenses => 'Other Expenses';

  @override
  String get categoryOnlineServices => 'Online Services';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryTransferOut => 'Transfer Out';

  @override
  String get categoryGifts => 'Gifts';

  @override
  String get categoryVehicleMaintenance => 'Vehicle Maintenance';

  @override
  String get categoryPersonalCare => 'Personal Care';

  @override
  String get categoryTransferIn => 'Transfer In';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryOtherIncome => 'Other Income';

  @override
  String get categoryGiftsReceived => 'Gifts Received';

  @override
  String get categoryBorrowing => 'Borrowing';

  @override
  String get categoryDebtCollection => 'Debt Collection';
}
