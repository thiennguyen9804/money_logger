# Feature Enhancement Specification: SVG Icon Support & Dynamic Icon Background Styling

## 1. Executive Summary
Enhance the visual representation of transaction categories across the application by supporting both native Flutter icons (`IconData`) and local SVG assets via the `flutter_svg` package (using the existing version specified in `pubspec.yaml`). Additionally, improve UI aesthetics by embedding icon components inside colored pastel background containers to eliminate visual monotony.

---

## 2. Icon Rendering Architecture

### 2.1 Dual Icon Support Mechanics
* **Flexible Icon Model:** Category entity data models must accommodate either a Material `IconData` reference or an asset path string pointing to a local SVG file (e.g., `assets/icons/fuel.svg`).
* **Rendering Widget:** Create or extend a unified `CategoryIcon` component in `lib/shared/widgets/` that dynamically evaluates the icon type:
  * If an SVG path is provided: Render using `SvgPicture.asset()` from `flutter_svg`.
  * If standard `IconData` is provided: Render using Flutter's native `Icon` widget.

---

## 3. Visual Styling & Background Containers

### 3.1 Colored Background Badges
* **Shape & Elevation:** Icons must be enclosed within a circular or rounded-rectangle (e.g., 12dp border radius) background badge container.
* **Palette:** Background badges must utilize soft, semi-transparent pastel accent colors paired with complementary icon tinting to ensure high contrast and readability across Light and Dark themes.
* **Consistency:** Ensure uniform padding, sizing (e.g., 40x40dp badge with 20x20dp inner icon), and alignment across Dashboard, Ledger, and Category Selection list items.

---

## 4. Asset & Package Constraints
* **Dependency:** Use the existing `flutter_svg` package version already declared in `pubspec.yaml` (do not alter version locks).
* **Asset Pathing:** Ensure all local SVG resources are organized under `assets/icons/` and correctly registered under the `flutter -> assets` section in `pubspec.yaml`.