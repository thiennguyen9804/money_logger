# Data Model: Localization and Dynamic Currency

## Language Preference

Represents the user's selected application language.

| Field | Type | Required | Meaning and constraints |
|---|---|---:|---|
| `localeId` | String | Yes | One of the supported stable identifiers: `en_US` or `vi_VN`. |

### Preference rules

- A valid saved preference takes precedence over device language.
- If no valid saved preference exists, use a supported device locale; otherwise use English (US).
- A user-selected locale is retained across app restarts.
- Locale changes update presentation state immediately and do not modify financial records.

## Translation Resources

A resource set maps stable message keys to localized text for one supported locale.

| Resource | Locale | Coverage |
|---|---|---|
| English resource set | `en_US` | App navigation, screen headings, actions, transaction types, category labels, accessibility labels, amount hints, validation messages, and empty states. |
| Vietnamese resource set | `vi_VN` | The same keys and semantic coverage as English. |

Every key used in the app must have a value in both resource sets. Category IDs remain stable; visible category names are resolved through the active resource set rather than changing category identity.

## Currency Presentation

A derived presentation rule selected from the active locale; it is not stored on transactions.

| Locale | Currency code | Symbol | Group separator | Decimal separator | Display digits | Symbol placement |
|---|---|---|---|---|---:|---|
| `en_US` | USD | `$` | comma | period | 2 | leading |
| `vi_VN` | VND | `₫` | period | locale standard | 0 | trailing |

Currency presentation controls display and input validation only. It does not convert, rewrite, or re-denominate the stored numeric amount.

## Monetary Amount

Existing transaction and wallet amounts are represented in integer minor units by `amountMinorUnits`. The current wallet summary also carries a hard-coded currency code and symbol; displayed currency metadata must instead be derived from the active locale.

- Existing numeric values remain unchanged when locale changes.
- The shared formatter interprets the existing integer amount as hundredths of a major unit, formats the corresponding major-unit value, and applies the selected locale's symbol, grouping, and fractional-digit rules.
- US dollar values display two fractional digits. Vietnamese Dong values display no fractional digits.
- No exchange rate, conversion timestamp, or original-currency field is introduced by this feature.

## Transaction Draft

The current transaction entry draft with its in-progress raw amount text and other unsaved form values.

- A locale change may update labels, hints, validation rules, and currency presentation.
- A locale change must preserve the user's current raw amount text and all other unsaved field values.
- On save, validated input is converted to the existing integer minor-unit representation; invalid or over-precision input is rejected.