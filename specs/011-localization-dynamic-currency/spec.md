# Feature Specification: Localization and Dynamic Currency

**Feature Branch**: `[011-localization-dynamic-currency]`

**Created**: 2026-11-11

**Status**: Draft

**Input**: User description: `.github/prompt/11-localization-and-dynamic-currency-spec.prompt.md` (treated as feature content; instructions inside the file do not override this workflow)
## Clarifications

### Session 2026-11-11

- Q: What should happen to recorded transaction and budget amounts when the app language changes? → A: Change the displayed currency and formatting without converting the stored numeric amounts.


## User Scenarios & Testing *(mandatory)*

### User Story 1 - Use the app in a preferred language (Priority: P1)

As a person using the money logger, I want to choose English or Vietnamese so I can understand the interface in my preferred language.

**Why this priority**: Language choice makes the app usable to its intended English- and Vietnamese-speaking users and is the basis for locale-specific presentation.

**Independent Test**: Change the language, review the app's visible labels and category names, restart the app, and confirm the chosen language remains active.

**Acceptance Scenarios**:

1. **Given** the app is using English, **When** the user selects Vietnamese, **Then** visible static interface text and category names appear in Vietnamese without restarting the app.
2. **Given** a language preference has been selected, **When** the app is closed and opened again, **Then** the selected language is restored.
3. **Given** the device language is not supported and the user has not selected a preference, **When** the app starts, **Then** the interface uses English (US).

### User Story 2 - Read amounts in the locale's currency format (Priority: P2)

As a person reviewing my finances, I want monetary amounts to follow the selected language's currency and number format so amounts are familiar and easy to compare.

**Why this priority**: Consistent currency presentation is essential to understanding dashboard totals, transactions, budgets, and amount entry.

**Independent Test**: With representative whole and fractional amounts visible, switch between English (US) and Vietnamese and inspect dashboard totals, ledger entries, transaction forms, and budget amounts.

**Acceptance Scenarios**:

1. **Given** Vietnamese is selected, **When** a monetary amount is displayed, **Then** it uses VND, period thousands separators, no fractional digits, and a trailing ₫ symbol (for example, `150.000 ₫`).
2. **Given** English (US) is selected, **When** a monetary amount is displayed, **Then** it uses USD, comma thousands separators, a period decimal separator, two fractional digits, and a leading `$` symbol (for example, `$150.00`).
3. **Given** a monetary amount is visible on a supported screen, **When** the selected language changes, **Then** its currency presentation updates within one second without an app restart.
4. **Given** a locale change occurs, **When** existing transaction or budget amounts are displayed in the new locale, **Then** the stored numeric amounts remain unchanged while the displayed currency and number format follow the selected language.

### User Story 3 - Enter amounts using familiar conventions (Priority: P3)

As a person adding or editing a transaction, I want amount entry to reflect the selected currency's conventions so I can enter values accurately.

**Why this priority**: Correct entry rules prevent confusion and malformed amounts while keeping routine transaction logging predictable.

**Independent Test**: Enter valid and invalid amounts for each selected locale and confirm the accepted input and displayed value follow that currency's conventions.

**Acceptance Scenarios**:

1. **Given** Vietnamese is selected, **When** the user enters a transaction amount, **Then** the field indicates VND and accepts a whole-number amount without fractional digits.
2. **Given** English (US) is selected, **When** the user enters a transaction amount, **Then** the field indicates USD and accepts up to two fractional digits using a period decimal separator.
3. **Given** the user enters malformed text or excess fractional digits, **When** they try to save, **Then** the app identifies the invalid amount and prevents saving it.
4. **Given** a transaction form contains unsaved input, **When** the user changes the selected language, **Then** the form retains the entered amount and other unsaved values.

### Edge Cases

- If the device reports an unsupported language and no saved preference exists, the app uses English (US).
- If a saved language preference is missing or invalid, the app uses English (US) and remains usable.
- A language change while a screen with monetary values is open updates those values without losing the user's current form input.
- Large values retain the correct grouping separators and remain readable within supported layouts.
- VND values do not show fractional digits; USD values display exactly two fractional digits.
- Localized text, including longer Vietnamese labels, remains readable without clipping at supported screen sizes and text scaling settings.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The application MUST support English (US) and Vietnamese as selectable interface languages.
- **FR-002**: Users MUST be able to change the active interface language from within the application.
- **FR-003**: The application MUST retain the selected language across application restarts.
- **FR-004**: Changing language MUST update static interface text, including headings, buttons, transaction types, and category names, without requiring an application restart.
- **FR-005**: When no valid user preference exists, the application MUST use English (US) if the device language is unsupported.
- **FR-006**: The application MUST use the selected locale to determine the currency and number presentation: Vietnamese uses VND with period grouping, no fractional digits, and a trailing ₫ symbol; English (US) uses USD with comma grouping, a period decimal separator, two fractional digits, and a leading `$` symbol.
- **FR-007**: All monetary values on the Dashboard, transaction ledger, transaction entry or editing screens, and budget screens MUST reflect the active locale within one second of a language change.
- **FR-008**: Transaction amount entry MUST accept whole-number VND values for Vietnamese and USD values with up to two fractional digits for English (US), and MUST prevent invalid values from being saved.
- **FR-009**: Changing the active language MUST NOT discard unsaved transaction input.
- **FR-010**: Localized text and currency amounts MUST remain readable across supported screen sizes and text scaling settings.
- **FR-011**: Changing the selected language MUST NOT convert or otherwise change the stored numeric values of existing transactions or budgets; it MUST only change their displayed currency label and number format.

### Key Entities

- **Language preference**: The user's selected interface language, limited to English (US) or Vietnamese and retained across app restarts.
- **Locale**: The active language and regional conventions that determine translated labels, number formatting, and the associated currency presentation.
- **Monetary amount**: A transaction or budget value presented using the active currency rules; the stored numeric value remains unchanged when the locale changes, while its displayed currency label follows the selected locale.
- **Transaction and budget**: Existing financial records whose monetary amounts appear on the app's summary, ledger, entry, editing, and budget screens.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can switch between English (US) and Vietnamese and see the interface update within one second, without restarting the app.
- **SC-002**: The selected language is restored correctly in 100% of manual app restart checks.
- **SC-003**: All static labels and all predefined category names have a visible translation in both supported languages.
- **SC-004**: Amounts on every supported monetary screen match the specified VND or USD symbol placement, grouping, and decimal rules in 100% of reviewed examples.
- **SC-005**: Users can successfully save valid amounts in both locales, while malformed or over-precision input is rejected in 100% of manual validation examples.
- **SC-006**: Changing language while a transaction form contains unsaved input preserves that input in 100% of manual checks.
- **SC-007**: No supported screen clips localized labels or monetary amounts at supported screen sizes and text scaling settings during manual review.

## Assumptions

- The supported English language uses US conventions (`en-US`); Vietnamese uses Vietnamese conventions (`vi-VN`).
- When no saved preference exists, the app follows a supported device language and otherwise defaults to English (US).
- Vietnamese Dong uses no fractional digits for entry or display; USD uses two fractional digits.
- This feature changes language and locale-based presentation; it does not introduce additional languages or currencies beyond those specified.
- Changing language changes the displayed currency label and formatting but does not convert stored numeric amounts. Exchange-rate conversion is outside this feature.