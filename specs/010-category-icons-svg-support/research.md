# Research: Category Icons and SVG Support

## Decision 1: Keep SVG artwork bundled with the application

**Decision**: Store category SVG artwork under `assets/icons/` and register the directory with Flutter's asset bundle.

**Rationale**: The clarified scope limits artwork to app-supplied icons, and categories are static constants. Bundling keeps paths local and available offline, avoids runtime service dependencies, and matches the specified asset directory.

**Alternatives considered**: Network-hosted SVGs and user-selected files were excluded because the clarified scope does not include external or user-provided artwork.

## Decision 2: Reuse the declared SVG package and handle asset failures in the icon widget

**Decision**: Use the existing `flutter_svg: ^2.3.3` package's `SvgPicture.asset` for local SVG display, with explicit dimensions and an error fallback to the category's native icon.

**Rationale**: The dependency is already present in `pubspec.yaml`, so no package addition or version change is necessary. The official `SvgPicture` API supports asset rendering, sizing, and an error builder, allowing a missing or invalid asset to leave the category row usable.

**Alternatives considered**: Adding a second SVG package or implementing a custom parser would add maintenance cost without a demonstrated need. Rendering without an error fallback would not meet FR-005.

**Sources**: [flutter_svg package guide](https://pub.dev/packages/flutter_svg), [SvgPicture API](https://pub.dev/documentation/flutter_svg/latest/svg/SvgPicture-class.html).

## Decision 3: Keep a native icon as the guaranteed fallback

**Decision**: Preserve the required native `IconData` on every category and add an optional SVG asset path. Prefer SVG when the path is set; otherwise use the native icon. If SVG loading fails, display the native icon.

**Rationale**: Existing categories and call sites already use native icons. This avoids making current categories invalid during migration and gives the error state a predictable recognizable fallback.

**Alternatives considered**: Replacing the native icon with a mutually exclusive union/reference would require more disruptive model and call-site changes and would not provide a reliable fallback for failed SVG assets.

## Decision 4: Centralize badge presentation in a shared widget

**Decision**: Add a focused shared category icon widget and use it from the common transaction item and category selection list.

**Rationale**: Dashboard recent transactions and Ledger rows already reuse `TransactionListItem`, while category selection renders a separate leading icon. A shared widget enforces consistent dimensions, padding, alignment, and theme-aware colors across all specified surfaces.

**Alternatives considered**: Duplicating badge styles in each screen risks visual drift and inconsistent error handling.

## Decision 5: Validate manually, without adding automated tests

**Decision**: Use formatting, static analysis, and manual runtime review across the listed surfaces, both themes, and representative layout/text-scale conditions.

**Rationale**: The project constitution explicitly prohibits unit, integration, and end-to-end tests and requires manual validation.

**Alternatives considered**: Adding Flutter test cases conflicts with the project constitution and is out of scope.