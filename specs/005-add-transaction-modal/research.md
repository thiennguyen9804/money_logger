# Research: Add Transaction Modal

## Decision: Use a modal bottom sheet with a scrollable, keyboard-safe form

**Rationale**: The requested flow is explicitly a slide-up modal and must
support keyboard input, progressive disclosure, narrow screens, and increased
text scale. A scrollable sheet that accounts for keyboard insets keeps the
amount field and save control reachable without changing navigation structure.

**Alternatives considered**:

- Navigate to a full-screen form: rejected because it adds navigation overhead
  to the high-speed entry flow.
- Use a fixed-height sheet: rejected because keyboard and text scale can cause
  clipping.

## Decision: Keep draft state local to the modal and commit only on valid save

**Rationale**: A local draft prevents dismissal or reopening from leaking
partial values into the session. The shell receives a completed transaction
only after positive amount validation succeeds.

**Alternatives considered**:

- Mutate session state on every field change: rejected because incomplete
  drafts could appear in dashboard or ledger.
- Persist drafts globally: rejected because persistence is out of scope.

## Decision: Default to Expense and the first available category

**Rationale**: This matches the clarified product decision and minimizes taps for
the common quick-entry path while keeping category selection explicit.

**Alternatives considered**:

- Require an unselected category: rejected because it slows the primary flow.
- Restore the previous selection: rejected because each newly opened modal must
  start clean and deterministic.

## Decision: Return to the previously active destination after save

**Rationale**: The clarified behavior preserves navigation context while making
the new transaction immediately visible through the existing session state.

**Alternatives considered**:

- Always navigate to Transactions: rejected because it disrupts the user's
  current context.
- Keep the modal open for confirmation: rejected because it adds an unnecessary
  interaction to a quick-entry flow.

## Decision: Use existing Flutter primitives and no automated tests

**Rationale**: Text input, focus management, date/time selection, bottom sheets,
semantics, and theme adaptation are available in the existing SDK. The
constitution prohibits unit, integration, and end-to-end tests.

**Alternatives considered**:

- Add a form or modal package: rejected because it increases dependencies
  without providing required capability.
- Add automated widget tests: rejected by project governance.
