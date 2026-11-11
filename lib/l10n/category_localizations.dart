import 'package:money_logger/l10n/generated/app_localizations.dart';
import 'package:money_logger/models/category.dart';

String localizedCategoryLabel(AppLocalizations l10n, Category category) {
  final key = category.id;
  return switch (key) {
    'expense-fuel' => l10n.categoryFuel,
    'expense-transportation' => l10n.categoryTransportation,
    'expense-food-and-beverage' => l10n.categoryFoodAndBeverage,
    'expense-rent' => l10n.categoryRent,
    'expense-lending' => l10n.categoryLending,
    'expense-debt-repayment' => l10n.categoryDebtRepayment,
    'expense-vehicle-repair' => l10n.categoryVehicleRepair,
    'expense-phone-bills' => l10n.categoryPhoneBills,
    'expense-haircut' => l10n.categoryHaircut,
    'expense-healthcare' => l10n.categoryHealthcare,
    'expense-entertainment-and-leisure' => l10n.categoryEntertainmentAndLeisure,
    'expense-other-expenses' => l10n.categoryOtherExpenses,
    'expense-online-services' => l10n.categoryOnlineServices,
    'expense-shopping' => l10n.categoryShopping,
    'expense-transfer-out' => l10n.categoryTransferOut,
    'expense-gifts' => l10n.categoryGifts,
    'expense-vehicle-maintenance' => l10n.categoryVehicleMaintenance,
    'expense-personal-care' => l10n.categoryPersonalCare,
    'income-transfer-in' => l10n.categoryTransferIn,
    'income-salary' => l10n.categorySalary,
    'income-other-income' => l10n.categoryOtherIncome,
    'income-gifts-received' => l10n.categoryGiftsReceived,
    'income-borrowing' => l10n.categoryBorrowing,
    'income-debt-collection' => l10n.categoryDebtCollection,
    _ => category.label,
  };
}
