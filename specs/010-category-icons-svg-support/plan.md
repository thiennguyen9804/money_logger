# Implementation Plan: Category Icons and SVG Support

**Branch**: `010-category-icons-svg-support` | **Date**: 2026-11-11 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/010-category-icons-svg-support/spec.md`

## Summary

Support both native icons and app-supplied local SVG artwork on the 24 predefined transaction categories, and present category icons in a consistent, theme-aware badge on Dashboard, Ledger, and category selection rows. Extend the category model with an optional SVG asset reference while retaining its native icon for backward compatibility and fallback. Add a shared category badge widget and register the bundled icon asset directory. Reuse the existing `flutter_svg` dependency without changing package versions.

## Technical Context

**Language/Version**: Dart `^3.13.7`; Flutter version follows the repository's declared SDK environment.

**Primary Dependencies**: Flutter Material; existing `flutter_svg: ^2.3.3`. No new dependency.

**Storage**: None. Categories and their icon references are static, app-defined data.

**Testing**: No automated tests, per project constitution. Validate with formatter, static analysis, and manual runtime review.

**Target Platform**: Flutter application on the repository's supported platforms.

**Project Type**: Single Flutter mobile application with platform targets in `android/`, `ios/`, `web/`, `windows/`, `macos/`, and `linux/`.

**Performance Goals**: Category artwork appears as part of the existing category rows without noticeable delay or disruptive layout changes.

**Constraints**: Preserve existing native icon behavior; only app-bundled SVG assets are in scope; do not change dependency versions; honor light/dark themes, responsive sizing, and accessibility; do not add automated tests.

**Scale/Scope**: 24 static categories; shared transaction row rendering used by Dashboard and Ledger; category selection list; native and SVG icons; light and dark themes.

## Constitution Check

- **Clean Code**: Pass. Keep icon rendering in one focused shared widget and avoid duplicating badge logic.
- **Simple UX**: Pass. No user upload or configuration flow is added; categories continue to be selected as today.
- **Responsive Design**: Pass with design requirement. Use bounded/adaptive constraints and preserve current row behavior under larger text scales and narrow layouts.
- **Minimal Dependencies**: Pass. Reuse the already-declared `flutter_svg` dependency and do not change its version.
- **No Automated Testing**: Pass. Validation is limited to formatting, static analysis, and manual runtime verification; do not add tests.
- **Technology Constraints**: Pass. Remain within the repository's Flutter/Dart SDK requirements.

No constitution violations or exceptions are required.

## Project Structure

### Documentation (this feature)

```text
specs/010-category-icons-svg-support/
|-- plan.md
|-- research.md
|-- data-model.md
|-- quickstart.md
|-- spec.md
`-- checklists/requirements.md
```

### Source Code (repository root)

```text
assets/
`-- icons/                         # App-supplied SVG category artwork
lib/
|-- models/
|   |-- category.dart              # Category icon reference fields
|   |-- expense_category.dart      # Optional SVG assignments
|   `-- income_category.dart       # Optional SVG assignments
`-- shared/
    `-- widgets/
        |-- category_icon.dart     # Shared native/SVG badge rendering
        `-- transaction_list_item.dart # Dashboard and Ledger badge usage
lib/screens/
`-- category_selection/
    `-- category_selection_screen.dart # Shared badge usage
pubspec.yaml                       # Register assets/icons/
```

**Structure Decision**: Keep the existing single Flutter application structure. The shared badge belongs under `lib/shared/widgets/`; category values remain in the existing static model files; transaction rows continue to share `TransactionListItem`. Category selection is updated to use the same badge. No public external interface or contract directory is needed.

## Phase 0: Research Summary

Decisions and alternatives are documented in [research.md](research.md). The existing package's bundled asset widget supports explicit sizing and error fallback. Use app-bundled SVG files and a native icon fallback; avoid network or user-provided artwork.

## Phase 1: Design Summary

- [data-model.md](data-model.md) defines the static Category icon reference and rendering precedence.
- No external API or inter-system contract exists; no `contracts/` artifact is needed.
- [quickstart.md](quickstart.md) defines formatter, analyzer, and manual runtime validation without automated tests.

## Constitution Check (Post-Design)

- The model extension preserves current required native icons while allowing optional local SVG artwork: **Pass**.
- Rendering stays centralized in a reusable widget and uses the existing dependency: **Pass**.
- The three user-visible surfaces share consistent, theme-aware badge behavior: **Pass**.
- Adaptive layout, accessibility, and manual verification are included: **Pass**.
- No automated tests or dependency/version changes are planned: **Pass**.

No unresolved technical clarifications remain.

## Complexity Tracking

No constitution violations; no complexity exception is required.