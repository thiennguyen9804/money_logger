# Implementation Plan: Localization and Dynamic Currency

**Branch**: `011-localization-dynamic-currency` | **Date**: 2026-11-11 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/011-localization-dynamic-currency/spec.md`

## Summary

Add English (US) and Vietnamese interface localization, a persisted in-app language choice, and locale-driven currency display and transaction entry. Use the app's existing Flutter localization and `intl` dependencies, follow its BLoC pattern for reactive locale state, derive displayed currency from the selected locale rather than the wallet's current hard-coded USD metadata, and add a small key-value persistence dependency for the user's preference. Apply the selected locale to translated static text, category names, monetary display, and input validation. Preserve all stored numeric amounts when the language changes; do not add exchange-rate conversion.

## Technical Context

**Language/Version**: Dart `^3.13.7`; Flutter follows the SDK required by `pubspec.yaml`.

**Primary Dependencies**: Flutter Material, existing `flutter_bloc`, `flutter_localizations`, and `intl`; add `shared_preferences` for the single persisted language preference.

**Storage**: Store only the selected locale identifier as a small app preference. Existing transaction values remain integer minor units in the current in-memory ledger model and are never converted when locale changes.

**Testing**: No automated tests, per project constitution. Validate generated localization resources, formatting, static analysis, and manual runtime scenarios.

**Target Platform**: Flutter application's supported Android, iOS, web, Windows, macOS, and Linux targets.

**Project Type**: Single Flutter application.

**Performance Goals**: Visible translated text and currency presentation update within one second of a language change, without restarting the app.

**Constraints**: Support only English (US) and Vietnamese; default to English (US) when no preference and no supported device locale exist; retain unsaved form input; use USD with two fractional digits and VND with no fractional digits; VND values display a trailing `₫`, USD values a leading `$`; changing locale changes presentation only and never changes stored numeric values; do not add automated tests.

**Scale/Scope**: Five app destinations; existing Dashboard, transaction ledger, and transaction entry flow; Profile preferences; 24 static category names; two locales and two corresponding currency presentations. The Budgets destination is currently a placeholder and has no existing budget data to migrate.

## Constitution Check

- **Clean Code**: Pass. Keep locale preference state, translations, and currency formatting in focused reusable modules; do not duplicate formatting across screens.
- **Simple UX**: Pass. Provide one clear language choice in the existing Profile destination, with immediate feedback and no restart.
- **Responsive Design**: Pass with design requirement. Review longer Vietnamese labels and monetary strings at narrow widths and increased text scale.
- **Minimal Dependencies**: Pass with documented need. Reuse existing localization and formatting packages; add only `shared_preferences` to persist one user preference across restarts.
- **No Automated Testing**: Pass. Do not add or run unit, integration, or end-to-end tests; use format, analysis, and manual runtime review.
- **Technology Constraints**: Pass. Remain compatible with the repository's declared Flutter/Dart SDK.

No constitution violations or exceptions are required.

## Project Structure

### Documentation (this feature)

```text
specs/011-localization-dynamic-currency/
|-- plan.md
|-- research.md
|-- data-model.md
|-- quickstart.md
|-- spec.md
`-- checklists/requirements.md
```

### Source Code (repository root)

```text
l10n.yaml                         # Localization resource/output configuration
lib/
|-- l10n/
|   |-- app_en.arb                # English (US) strings
|   `-- app_vi.arb                # Vietnamese strings
|-- blocs/
|   `-- locale/                   # Reactive selected-locale state and events
|-- services/
|   `-- locale_preference_store.dart # Persist and restore the selected locale
|-- models/
|   `-- ledger.dart               # Locale-aware money formatting/parsing boundary
|-- shared/
|   `-- formatters/
|       `-- currency_formatter.dart # Shared currency presentation
`-- screens/
    |-- shell/                    # Provide locale to app and localized navigation
    |   `-- widgets/
    |       `-- locale_controls.dart # Language choice in Profile
    |-- dashboard/                # Localized labels and balance formatting
    |-- transactions/             # Localized labels, dates, and currency formatting
    `-- add_transaction/          # Locale-aware amount input and validation
lib/main.dart                     # Locale state and localization delegates
pubspec.yaml                      # Add the preference persistence dependency
```

**Structure Decision**: Keep the existing single Flutter app and BLoC architecture. Add generated localization resources, a small locale preference service and BLoC, a shared formatter, and a language control alongside the existing Profile theme controls. No network service or external API is introduced. The current Budgets destination is placeholder content; this plan localizes its interface copy without inventing budget records or flows.

## Phase 0: Research Summary

Decisions and alternatives are documented in [research.md](research.md). Use Flutter's supported locale and localization delegate mechanisms, ARB resources, the existing `intl` package for explicit currency rules, and a small preference store for the user's locale choice. Preserve numeric values and parse input according to the selected currency's allowed precision.

## Phase 1: Design Summary

- [data-model.md](data-model.md) defines locale preference, translation resources, derived currency presentation, and existing amount/draft rules.
- No public API, external integration, or inter-system contract exists; no `contracts/` artifact is needed.
- [quickstart.md](quickstart.md) defines generation, analysis, and manual locale/currency validation scenarios. It adds no automated test steps.

## Constitution Check (Post-Design)

- Locale state and persistence follow the existing Flutter/BLoC structure and persist only a language preference: **Pass**.
- Existing transactions and drafts retain their stored numeric amounts across locale changes: **Pass**.
- The same formatter is used by monetary surfaces and keeps the specified VND/USD presentation: **Pass**.
- Localization covers static screen copy and category names; layout review includes Vietnamese text expansion: **Pass**.
- Existing `flutter_localizations` and `intl` are reused; the single added persistence package has a direct requirement: **Pass**.
- No automated tests are added or run: **Pass**.

No unresolved technical clarifications remain.

## Complexity Tracking

No constitution violations; no complexity exception is required.