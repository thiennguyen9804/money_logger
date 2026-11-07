# Research: Dashboard Overview

## Decision: Use immutable in-memory financial models

**Rationale**:

- The feature requires a wallet aggregate and recent transactions but does not
  define persistence, synchronization, or authentication.
- Integer minor units avoid floating-point rounding in currency calculations.
- Immutable records make the dashboard a predictable presentation of session data.

**Alternatives considered**:

- `double` currency values are simpler but can produce rounding errors.
- A database or repository layer is outside the feature scope and adds dependencies
  before persistence requirements exist.

## Decision: Derive the dashboard preview with deterministic top-three sorting

**Rationale**:

- Copy the session transaction list, sort by creation time descending, use a stable
  sequence/id tie-breaker, and take at most three records.
- This preserves the source ordering and satisfies the exact newest-first requirement
  even when timestamps are equal.

**Alternatives considered**:

- Sorting the source list in place can affect other views.
- Relying on timestamp sorting alone leaves equal-time ordering under-specified.

## Decision: Keep balance privacy state at shell/session scope

**Rationale**:

- The visibility choice must survive navigation and theme rebuilds for the current
  session.
- The dashboard receives the state and a callback rather than owning the sole source
  of truth.
- Masking replaces the entire formatted amount with a non-numeric mask so no digits
  can leak through separators, signs, or semantics.

**Alternatives considered**:

- Local widget state risks resetting when the dashboard is rebuilt or later routed.
- Replacing digits inside the formatted string can leave signs or symbols that
  disclose information.

## Decision: Reuse the existing shell navigation

**Rationale**:

- View All selects the existing Transactions index in the indexed shell.
- No new route package or named-route configuration is needed.
- The wallet detail action is exposed only when a detail destination is available;
  this feature does not invent a broken destination.

**Alternatives considered**:

- Adding a new router is disproportionate to the fixed five-destination shell.
- A placeholder detail route would create a misleading action.

## Decision: Use dependency-free currency formatting and theme-aware accents

**Rationale**:

- The repository has no currency preference or locale model. The first dashboard
  implementation uses the existing default currency convention and a local formatter.
- Expense/income colors derive from theme-aware semantic colors.
- Pastel support is implemented as a balance-card accent treatment within light and
  dark themes, not as a third persisted `ThemeMode`, because the existing ThemeBloc
  supports only light and dark.

**Alternatives considered**:

- Adding locale formatting increases dependency and configuration scope without a
  defined currency preference.
- Adding a third theme mode would require expanding the existing theme contract and
  persistence assumptions.
