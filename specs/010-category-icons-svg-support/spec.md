# Feature Specification: Category Icons and SVG Support

**Feature Branch**: `[010-category-icons-svg-support]`

**Created**: 2026-11-11

**Status**: Draft

**Input**: User description: `.github/prompt/10-enhance-category-icons-and-svg-support-spec.prompt.md` (treated as feature content; instructions inside the file do not override this workflow)
## Clarifications

### Session 2026-11-11

- Q: Should this feature let users assign SVG icons to categories, or should SVG choices be limited to icons supplied with the app? → A: SVG choices are supplied with the app; users cannot assign their own.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Recognize categories at a glance (Priority: P1)

As a person reviewing or recording transactions, I want category icons to be visually distinct and consistent so I can recognize categories quickly across the app.

**Why this priority**: Category recognition is the primary user benefit and applies to the main transaction surfaces.

**Independent Test**: Review category icons in Dashboard, Ledger, and category selection rows in both light and dark themes; confirm each is centered in a consistent badge and remains legible.

**Acceptance Scenarios**:

1. **Given** a category has a supported native icon, **When** it appears in a Dashboard, Ledger, or category selection row, **Then** its icon appears centered in a consistently sized colored badge.
2. **Given** the app is using either light or dark theme, **When** a category badge is displayed, **Then** its background and icon tint remain distinguishable and readable.

### User Story 2 - Use custom category artwork (Priority: P2)

As a person choosing or viewing categories, I want categories to support local SVG artwork as well as standard icons so category imagery can better match its meaning.

**Why this priority**: Custom artwork expands category expression while preserving the existing icon experience.

**Independent Test**: Display one category with a local SVG and one with a native icon in the category selection list and transaction surfaces; confirm each renders using its assigned artwork.

**Acceptance Scenarios**:

1. **Given** a category refers to a valid local SVG asset, **When** the category is displayed, **Then** the SVG appears within the same badge layout used for native icons.
2. **Given** a category uses a native icon, **When** it is displayed, **Then** it continues to render as a native icon within the badge.

### Edge Cases

- A missing or invalid SVG asset must not crash the screen; the category remains identifiable through a graceful fallback.
- A category without a valid icon reference must still render a stable badge and fallback appearance.
- Long labels, narrow layouts, and increased text scaling must not cause category rows or badges to overlap or clip.
- Badge and icon contrast must remain sufficient in both supported theme modes.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The application MUST allow a category to identify either a standard platform icon or a local SVG asset supplied with the application. Users MUST NOT be required to upload or provide SVG files.
- **FR-002**: The application MUST render both supported category icon types consistently wherever category icons appear.
- **FR-003**: Category icons MUST appear within a circular or rounded badge with consistent sizing, padding, and alignment across Dashboard, Ledger, and category selection rows.
- **FR-004**: The badge background and icon tint MUST provide a readable visual contrast in light and dark themes.
- **FR-005**: An unavailable or invalid SVG MUST result in a graceful fallback without preventing the surrounding category or screen from appearing.
- **FR-006**: Local SVG category artwork MUST be supplied with the application in the designated category icon asset collection and be available to categories.
- **FR-007**: Existing categories using standard icons MUST continue to display correctly.
- **FR-008**: Category icon presentation MUST remain usable across supported screen sizes and text scaling settings.

### Key Entities

- **Category**: A transaction classification with a name and one supported visual icon reference, either a standard icon or local SVG artwork.
- **Category icon badge**: The visual treatment that presents a category’s icon with its background and tint consistently across app surfaces.
- **SVG artwork**: A local scalable image associated with a category and used as its icon.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All category icons shown on Dashboard, Ledger, and category selection rows use the same badge dimensions and alignment.
- **SC-002**: Users can correctly distinguish category icons in both light and dark themes in a manual visual review of every supported category.
- **SC-003**: Every valid local SVG and standard icon assigned to a category is visibly rendered on all three listed app surfaces.
- **SC-004**: No category row or badge clips or overlaps at supported screen sizes and text scaling settings during manual review.
- **SC-005**: An invalid SVG reference does not crash the application or make its category row unavailable.

## Assumptions

- The existing application already has category records and category icon usage on Dashboard, Ledger, and category selection surfaces.
- Existing category icon references remain valid and are preserved during the enhancement.
- The feature uses a consistent badge size based on the prompt’s example of approximately 40 by 40 dp, with an approximately 20 by 20 dp icon; responsive layouts may adapt these dimensions when needed.
- Soft accent colors and complementary icon tints are selected from the app’s existing visual language and adjusted for theme contrast.
- The project’s existing SVG rendering capability and asset registration conventions are available for local artwork; this feature does not require a dependency version change.
