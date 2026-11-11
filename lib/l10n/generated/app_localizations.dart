import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'US'),
    Locale('vi'),
    Locale('vi', 'VN'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Money Logger'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In en_US, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navTransactions.
  ///
  /// In en_US, this message translates to:
  /// **'Transactions'**
  String get navTransactions;

  /// No description provided for @navAddTransaction.
  ///
  /// In en_US, this message translates to:
  /// **'Add Transaction'**
  String get navAddTransaction;

  /// No description provided for @navBudgets.
  ///
  /// In en_US, this message translates to:
  /// **'Budgets'**
  String get navBudgets;

  /// No description provided for @navProfile.
  ///
  /// In en_US, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @purposeDashboard.
  ///
  /// In en_US, this message translates to:
  /// **'Financial summary and recent activity'**
  String get purposeDashboard;

  /// No description provided for @purposeTransactions.
  ///
  /// In en_US, this message translates to:
  /// **'Monthly income and expense history'**
  String get purposeTransactions;

  /// No description provided for @purposeAddTransaction.
  ///
  /// In en_US, this message translates to:
  /// **'Primary income or expense entry point'**
  String get purposeAddTransaction;

  /// No description provided for @purposeBudgets.
  ///
  /// In en_US, this message translates to:
  /// **'Spending limits and category budgets'**
  String get purposeBudgets;

  /// No description provided for @purposeProfile.
  ///
  /// In en_US, this message translates to:
  /// **'Account, preferences, security, and theme settings'**
  String get purposeProfile;

  /// No description provided for @startEntry.
  ///
  /// In en_US, this message translates to:
  /// **'Start a new income or expense entry.'**
  String get startEntry;

  /// No description provided for @destinationItem.
  ///
  /// In en_US, this message translates to:
  /// **'{destination} item {index}'**
  String destinationItem(Object destination, Object index);

  /// No description provided for @darkMode.
  ///
  /// In en_US, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @enabled.
  ///
  /// In en_US, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en_US, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @light.
  ///
  /// In en_US, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en_US, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @toggle.
  ///
  /// In en_US, this message translates to:
  /// **'Toggle'**
  String get toggle;

  /// No description provided for @language.
  ///
  /// In en_US, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en_US, this message translates to:
  /// **'English (US)'**
  String get english;

  /// No description provided for @vietnamese.
  ///
  /// In en_US, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @recentTransactions.
  ///
  /// In en_US, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @viewAll.
  ///
  /// In en_US, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @noTransactions.
  ///
  /// In en_US, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @recentActivityEmpty.
  ///
  /// In en_US, this message translates to:
  /// **'Your recent activity will appear here.'**
  String get recentActivityEmpty;

  /// No description provided for @currentBalance.
  ///
  /// In en_US, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @balanceHidden.
  ///
  /// In en_US, this message translates to:
  /// **'Balance hidden'**
  String get balanceHidden;

  /// No description provided for @hideBalance.
  ///
  /// In en_US, this message translates to:
  /// **'Hide balance'**
  String get hideBalance;

  /// No description provided for @showBalance.
  ///
  /// In en_US, this message translates to:
  /// **'Show balance'**
  String get showBalance;

  /// No description provided for @noMonthTransactions.
  ///
  /// In en_US, this message translates to:
  /// **'No transactions recorded for this month.'**
  String get noMonthTransactions;

  /// No description provided for @dailyTotal.
  ///
  /// In en_US, this message translates to:
  /// **'Daily total: {amount}'**
  String dailyTotal(Object amount);

  /// No description provided for @dashboard.
  ///
  /// In en_US, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @transactions.
  ///
  /// In en_US, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @back.
  ///
  /// In en_US, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @save.
  ///
  /// In en_US, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addTransactionForm.
  ///
  /// In en_US, this message translates to:
  /// **'Add transaction form'**
  String get addTransactionForm;

  /// No description provided for @amount.
  ///
  /// In en_US, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountHintUsd.
  ///
  /// In en_US, this message translates to:
  /// **'0.00'**
  String get amountHintUsd;

  /// No description provided for @amountHintVnd.
  ///
  /// In en_US, this message translates to:
  /// **'0'**
  String get amountHintVnd;

  /// No description provided for @enterAmountError.
  ///
  /// In en_US, this message translates to:
  /// **'Enter an amount greater than zero.'**
  String get enterAmountError;

  /// No description provided for @selectCategory.
  ///
  /// In en_US, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @selectCategoryError.
  ///
  /// In en_US, this message translates to:
  /// **'Select a category.'**
  String get selectCategoryError;

  /// No description provided for @categoryTypeError.
  ///
  /// In en_US, this message translates to:
  /// **'Category type does not match transaction type.'**
  String get categoryTypeError;

  /// No description provided for @dateTime.
  ///
  /// In en_US, this message translates to:
  /// **'Date and time'**
  String get dateTime;

  /// No description provided for @moreDetails.
  ///
  /// In en_US, this message translates to:
  /// **'More Details'**
  String get moreDetails;

  /// No description provided for @addEvent.
  ///
  /// In en_US, this message translates to:
  /// **'Add an event or campaign'**
  String get addEvent;

  /// No description provided for @eventCampaign.
  ///
  /// In en_US, this message translates to:
  /// **'Event or campaign'**
  String get eventCampaign;

  /// No description provided for @noEvent.
  ///
  /// In en_US, this message translates to:
  /// **'No event'**
  String get noEvent;

  /// No description provided for @holidaySpending.
  ///
  /// In en_US, this message translates to:
  /// **'Holiday spending'**
  String get holidaySpending;

  /// No description provided for @homeRenovation.
  ///
  /// In en_US, this message translates to:
  /// **'Home renovation'**
  String get homeRenovation;

  /// No description provided for @birthdayCelebration.
  ///
  /// In en_US, this message translates to:
  /// **'Birthday celebration'**
  String get birthdayCelebration;

  /// No description provided for @expense.
  ///
  /// In en_US, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @income.
  ///
  /// In en_US, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @noCategories.
  ///
  /// In en_US, this message translates to:
  /// **'No categories available'**
  String get noCategories;

  /// No description provided for @noCategoriesType.
  ///
  /// In en_US, this message translates to:
  /// **'There are no categories for this type'**
  String get noCategoriesType;

  /// No description provided for @selected.
  ///
  /// In en_US, this message translates to:
  /// **'selected'**
  String get selected;

  /// No description provided for @neutral.
  ///
  /// In en_US, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @categoryFuel.
  ///
  /// In en_US, this message translates to:
  /// **'Fuel'**
  String get categoryFuel;

  /// No description provided for @categoryTransportation.
  ///
  /// In en_US, this message translates to:
  /// **'Transportation'**
  String get categoryTransportation;

  /// No description provided for @categoryFoodAndBeverage.
  ///
  /// In en_US, this message translates to:
  /// **'Food & Beverage'**
  String get categoryFoodAndBeverage;

  /// No description provided for @categoryRent.
  ///
  /// In en_US, this message translates to:
  /// **'Rent'**
  String get categoryRent;

  /// No description provided for @categoryLending.
  ///
  /// In en_US, this message translates to:
  /// **'Lending'**
  String get categoryLending;

  /// No description provided for @categoryDebtRepayment.
  ///
  /// In en_US, this message translates to:
  /// **'Debt Repayment'**
  String get categoryDebtRepayment;

  /// No description provided for @categoryVehicleRepair.
  ///
  /// In en_US, this message translates to:
  /// **'Vehicle Repair'**
  String get categoryVehicleRepair;

  /// No description provided for @categoryPhoneBills.
  ///
  /// In en_US, this message translates to:
  /// **'Phone Bills'**
  String get categoryPhoneBills;

  /// No description provided for @categoryHaircut.
  ///
  /// In en_US, this message translates to:
  /// **'Haircut'**
  String get categoryHaircut;

  /// No description provided for @categoryHealthcare.
  ///
  /// In en_US, this message translates to:
  /// **'Healthcare'**
  String get categoryHealthcare;

  /// No description provided for @categoryEntertainmentAndLeisure.
  ///
  /// In en_US, this message translates to:
  /// **'Entertainment & Leisure'**
  String get categoryEntertainmentAndLeisure;

  /// No description provided for @categoryOtherExpenses.
  ///
  /// In en_US, this message translates to:
  /// **'Other Expenses'**
  String get categoryOtherExpenses;

  /// No description provided for @categoryOnlineServices.
  ///
  /// In en_US, this message translates to:
  /// **'Online Services'**
  String get categoryOnlineServices;

  /// No description provided for @categoryShopping.
  ///
  /// In en_US, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryTransferOut.
  ///
  /// In en_US, this message translates to:
  /// **'Transfer Out'**
  String get categoryTransferOut;

  /// No description provided for @categoryGifts.
  ///
  /// In en_US, this message translates to:
  /// **'Gifts'**
  String get categoryGifts;

  /// No description provided for @categoryVehicleMaintenance.
  ///
  /// In en_US, this message translates to:
  /// **'Vehicle Maintenance'**
  String get categoryVehicleMaintenance;

  /// No description provided for @categoryPersonalCare.
  ///
  /// In en_US, this message translates to:
  /// **'Personal Care'**
  String get categoryPersonalCare;

  /// No description provided for @categoryTransferIn.
  ///
  /// In en_US, this message translates to:
  /// **'Transfer In'**
  String get categoryTransferIn;

  /// No description provided for @categorySalary.
  ///
  /// In en_US, this message translates to:
  /// **'Salary'**
  String get categorySalary;

  /// No description provided for @categoryOtherIncome.
  ///
  /// In en_US, this message translates to:
  /// **'Other Income'**
  String get categoryOtherIncome;

  /// No description provided for @categoryGiftsReceived.
  ///
  /// In en_US, this message translates to:
  /// **'Gifts Received'**
  String get categoryGiftsReceived;

  /// No description provided for @categoryBorrowing.
  ///
  /// In en_US, this message translates to:
  /// **'Borrowing'**
  String get categoryBorrowing;

  /// No description provided for @categoryDebtCollection.
  ///
  /// In en_US, this message translates to:
  /// **'Debt Collection'**
  String get categoryDebtCollection;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return AppLocalizationsEnUs();
        }
        break;
      }
    case 'vi':
      {
        switch (locale.countryCode) {
          case 'VN':
            return AppLocalizationsViVn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
