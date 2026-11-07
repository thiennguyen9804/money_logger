# Research: Transaction Ledger

## Decision: Reuse the existing session transaction model and formatter

**Rationale**:

- The dashboard already defines immutable transaction records, integer minor
  units, income/expense types, stable sequence ordering, and currency formatting.
- Reuse keeps ledger and dashboard amounts consistent without a second financial
  data representation.

**Alternatives considered**:

- A separate ledger model would duplicate fields and create inconsistent rules.
- Persistence is outside scope because the application currently owns session
  data only.

## Decision: Derive available months from transaction records

**Rationale**:

- The selector represents periods users can actually review.
- Year/month identity avoids ambiguity across years and display locales.
- With no records, the current local month provides a useful empty state.

**Alternatives considered**:

- Fixed future and past months add empty choices without user value.
- Formatted labels are unsafe as filter keys.

## Decision: Keep selected month state local to Transactions

**Rationale**:

- The filter affects only the ledger and does not need global sharing.
- Local state avoids expanding the global ThemeBloc or shell session model.
- Indexed destination preservation can retain the selection during navigation.

**Alternatives considered**:

- Global state increases coupling for a screen-specific filter.
- Route arguments are unnecessary for the indexed shell.

## Decision: Use a dependency-free horizontal month selector

**Rationale**:

- Flutter primitives provide the required swipe and tap behavior.
- A scrollable selector remains simple and usable with many months.
- No carousel package is needed for this bounded interaction.

**Alternatives considered**:

- A third-party carousel adds dependency and maintenance cost.
- A fixed row can overflow when many months exist.

## Decision: Group by local calendar date with deterministic ordering

**Rationale**:

- Users interpret ledger dates in their device's local calendar.
- Grouping by local year/month/day and sorting dates descending prevents
  cross-month leakage.
- Creation time, sequence, and ID provide stable ordering within a group.

**Alternatives considered**:

- UTC grouping can display a record under the wrong user-facing date.
- Source-order grouping is unstable.

## Decision: Keep the balance above the scrollable ledger

**Rationale**:

- The balance remains available while users review history.
- A compact non-scrolling header avoids unnecessary sliver complexity.

**Alternatives considered**:

- A pinned sliver header is more complex than needed for the current screen.
- Repeating the balance in every group wastes space.

## Decision: Manual validation only

**Rationale**:

- The project constitution prohibits unit, integration, and end-to-end tests.
- Formatting, static analysis, runtime inspection, and responsive review are
  the permitted validation methods.

**Alternatives considered**:

- Automated widget or integration tests conflict with project governance.
