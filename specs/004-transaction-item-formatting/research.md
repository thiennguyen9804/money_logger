# Research: Transaction Item Formatting

## Decision: Reuse one shared transaction-row presentation

**Rationale**: The dashboard and ledger currently have separate row widgets
with duplicated amount formatting, colors, and layout. A shared widget or
shared presentation helper is the simplest way to guarantee parity and prevent
future drift while preserving each screen's available date/context details.

**Alternatives considered**:

- Keep two independent widgets: rejected because visual parity would depend on
  duplicated code remaining synchronized.
- Add a UI component package: rejected because existing Flutter primitives are
  sufficient and the constitution favors minimal dependencies.

## Decision: Format amounts from absolute minor units without signs

**Rationale**: Transaction amounts are already stored as absolute integer minor
  units, and the existing currency formatter supports currency symbols, grouping,
  and decimal precision. Rows should use that formatter directly and avoid
  mathematical signs in the visual amount.

**Alternatives considered**:

- Display signed values: rejected by the feature specification.
- Add locale/currency formatting dependency: rejected because it is outside scope.

## Decision: Use theme-aware semantic colors plus explicit text cues

**Rationale**: Existing theme color roles provide readable contrast in light and
dark themes. Amount color maps to income or expense, while explicit `Income` or
`Expense` text preserves comprehension without relying on color alone. Zero
values receive a neutral color treatment.

**Alternatives considered**:

- Hard-code pastel colors: rejected because fixed colors may fail contrast in dark mode.
- Use color only: rejected because the requirements include a non-color cue.

## Decision: Use flexible trailing amount layout

**Rationale**: An expanded detail region and flexible trailing amount region keep
the amount at the right edge while allowing long descriptions, large values, and
increased text scale to adapt without horizontal overflow.

**Alternatives considered**:

- Fixed-width columns: rejected because narrow screens and text scaling can clip content.
- Unconstrained wrapping: rejected because amounts can lose a common right boundary.

## Decision: Validate manually, without automated tests

**Rationale**: The project constitution explicitly prohibits unit, integration,
and end-to-end tests. Validation uses formatting, static analysis, runtime
inspection, and the feature quickstart scenarios.

**Alternatives considered**:

- Add widget or integration tests: rejected by project governance.
