# UI Contract: Initial Layout and Theme Setup

## Application Shell

The application exposes one primary shell containing exactly five destinations in
this order:

| Position | Label | Route intent | Purpose |
|---:|---|---|---|
| 1 | Dashboard | `/dashboard` | Financial summary and recent activity |
| 2 | Transactions | `/transactions` | Monthly income and expense history |
| 3 | Add Transaction | `/add-transaction` | Primary income or expense entry point |
| 4 | Budgets | `/budgets` | Spending limits and category budgets |
| 5 | Profile | `/profile` | Account, preferences, security, and theme settings |

The active destination MUST be visibly selected. The primary navigation MUST remain
available from every destination.

## Navigation Behavior

- Selecting a destination changes the visible destination in one user action.
- Navigation uses Flutter's default route and navigation primitives.
- Returning to a destination restores its in-session scroll position and active view
  state.
- The destination order and labels are identical on mobile and web viewports.
- The visual arrangement MAY adapt to available width, but all five destinations
  MUST remain reachable and unambiguous.

## Theme Behavior

- The shell supports light and dark modes.
- Profile theme controls dispatch explicit events to the global `ThemeBloc`.
- A theme event updates navigation, destination content, controls, backgrounds, and
  text without changing the active destination.
- The selected theme remains active while navigating during the current session.

## Responsive and Accessibility Behavior

- Narrow layouts MUST avoid clipped, overlapping, or unreachable navigation controls.
- Wide layouts MUST preserve the same destination order and labels.
- Increased text scale MUST not hide required labels or make controls inaccessible.
- Empty destination views MUST still expose a clear heading and the primary navigation.
