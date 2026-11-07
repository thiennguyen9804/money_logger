# Data Model: Initial Layout and Theme Setup

This feature has no persisted business data. The following in-memory entities model
the application shell during the current session.

## NavigationDestination

Represents one primary destination in the application shell.

| Field | Type | Rules |
|---|---|---|
| key | stable identifier | Required; unique across the five destinations |
| label | user-facing text | Required; exactly one of Dashboard, Transactions, Add Transaction, Budgets, or Profile |
| semantic purpose | description | Matches the destination purpose in the feature specification |
| display order | integer | Required; values 1 through 5 with no duplicates |
| active state | boolean | Exactly one destination is active at a time |

Required ordered values:

1. Dashboard
2. Transactions
3. Add Transaction
4. Budgets
5. Profile

## DestinationViewState

Represents the session-only state retained for one destination while the user visits
other destinations.

| Field | Type | Rules |
|---|---|---|
| destination key | stable identifier | Required; references one NavigationDestination |
| scroll position | session view value | Retained when leaving and restored when returning |
| active view state | session view value | Retained when leaving and restored when returning |

The state is created for each destination as it becomes available and is discarded
when the application session ends. It is not persisted between launches.

## ThemeState

Immutable state emitted by `ThemeBloc`.

| Field | Type | Rules |
|---|---|---|
| mode | Light or Dark | Required; one mode is active at a time |
| selected destination | destination key | Theme changes MUST not alter the active destination |

## ThemeEvent

An explicit input accepted by `ThemeBloc`.

| Event | Meaning | Result |
|---|---|---|
| SetLight | Select light theme | Emits light `ThemeState` |
| SetDark | Select dark theme | Emits dark `ThemeState` |
| Toggle | Invert current mode | Emits the opposite `ThemeState` |

## Relationships and Invariants

- Each `NavigationDestination` has at most one `DestinationViewState`.
- The shell contains exactly five `NavigationDestination` records.
- Exactly one `NavigationDestination` is active.
- `ThemeBloc` has one current `ThemeState` and is shared by the shell and profile
  theme controls.
- Theme events MUST NOT reset the active destination or any destination view state.
- Destination order and labels are stable for the duration of a session.
