# Research: Localization and Dynamic Currency

## Decision 1: Use Flutter locale resolution and generated app translations

**Decision**: Support `Locale('en', 'US')` and `Locale('vi', 'VN')` in the app, load generated translations for both locales, and pass the selected locale to the root application so visible widgets update immediately.

**Rationale**: The project already declares `flutter_localizations`. Flutter's localization system integrates translations with Material widgets, and the `gen-l10n` workflow supports ARB resources. Listing English (US) first gives the required fallback when no supported device locale or saved selection exists; a saved locale takes precedence.

**Alternatives considered**: Hand-written string conditionals in each screen would duplicate translation logic and make it easy to miss static text and category labels. Adding a separate localization framework is not justified for two built-in languages.

**Sources**: [Flutter internationalization guide](https://docs.flutter.dev/ui/internationalization), [MaterialApp locale](https://api.flutter.dev/flutter/material/MaterialApp/locale.html), [MaterialApp supportedLocales](https://api.flutter.dev/flutter/material/MaterialApp/supportedLocales.html), [GlobalMaterialLocalizations delegates](https://api.flutter.dev/flutter/flutter_localizations/GlobalMaterialLocalizations/delegates-constant.html).

## Decision 2: Persist the language as a small preference

**Decision**: Persist a stable locale key such as `en_US` or `vi_VN` in a platform preference store and restore it when the app starts. Use the package's asynchronous API so locale loading does not rely on a stale in-memory cache.

**Rationale**: The only durable value added by this feature is a small user preference. The existing project has BLoC state conventions but no persistence service. A key-value preference is simpler than introducing a database or settings framework. Preference writes need not provide the durability guarantees required for transaction records.

**Alternatives considered**: Device locale alone does not preserve an in-app choice. A database is excessive for one locale key. Restoration state does not by itself satisfy preference retention across a full app restart.

**Sources**: [Flutter persistence choices](https://docs.flutter.dev/data-and-backend/persistence/choose-database), [shared_preferences package](https://pub.dev/packages/shared_preferences), [SharedPreferencesAsync API](https://pub.dev/documentation/shared_preferences/latest/shared_preferences/SharedPreferencesAsync-class.html).

## Decision 3: Use explicit locale and currency rules for amount display

**Decision**: Use the existing `intl` package's currency formatting with explicit locale, currency code, symbol, and decimal digits: `en_US`, USD, `$`, 2 digits; `vi_VN`, VND, `₫`, 0 digits. Apply the same shared formatting boundary to Dashboard, ledger, and transaction entry displays.

**Rationale**: Explicit values ensure output matches the requirements regardless of default currency selection. Locale-aware formatting provides grouping and symbol placement for each supported locale. Existing amounts are stored as integer hundredths; format their corresponding major-unit value without mutating storage.

**Alternatives considered**: Concatenating symbols with manually grouped digits duplicates locale behavior and risks inconsistent spacing and grouping. Relying only on inferred locale currency leaves currency code and precision implicit.

**Source**: [intl NumberFormat API](https://pub.dev/documentation/intl/latest/intl/NumberFormat-class.html).

## Decision 4: Parse entry according to locale, but preserve the canonical amount representation

**Decision**: Accept whole-number VND input and USD input with up to two fractional digits; parse both into the existing integer minor-unit representation. Use locale-specific field hints and validation, and keep raw draft input when locale state changes.

**Rationale**: This preserves current transaction storage and `TransactionDraft` behavior while enforcing the specification's precision rules. The clarified no-conversion behavior applies to stored numeric amounts: changing display locale must not mutate transactions or drafts.

**Alternatives considered**: Storing locale-formatted display strings as amounts would couple persisted data to presentation. Currency conversion would violate the clarification and require an exchange-rate provider.

## Decision 5: Keep the feature internal to the existing app

**Decision**: Do not create public contracts or external integration artifacts.

**Rationale**: Locale selection, translation, persistence, and amount display are internal application behaviors; the repository exposes no external API for them.

**Alternatives considered**: None are needed for the current single-app scope.