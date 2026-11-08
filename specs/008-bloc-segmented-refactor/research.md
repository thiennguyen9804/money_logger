# Research: BLoC and SegmentedButton Architecture Refactor

**Feature**: 008-bloc-segmented-refactor

## R1 — Bloc-per-feature vs. one global bloc

**Decision**: One bloc per feature area: `AddTransactionBloc` (draft),
`ThemeBloc` (mode), `CategorySelectionBloc` (type/category sync),
`LedgerBloc` (month filtering + visible transactions).

**Rationale**: A single global bloc forces unrelated events (theme, draft, category)
through one state machine, producing union states that break Equatable value
semantics — two unrelated changes would compare "equal" only if every union member
coincided. Bloc-per-feature keeps each state family minimal and props lists short.

**Alternatives considered**:
- Single global `AppBloc`: rejected — union state explosion, violates FR-003 intent.
- Screen-scoped blocs only (no composition-root providers): rejected — draft state
  would be recreated on navigation, violating the no-state-loss edge case.

## R2 — Draft state ownership during navigation

**Decision**: Keep the status quo — the in-progress `TransactionDraft` remains
local widget state in `_AddTransactionPageState`, and the category-selection
route continues to communicate via typed route results (`Navigator.pop`).

**Rationale**: The draft is ephemeral, single-screen composition state. Flutter
guidance puts ephemeral state in the widget; a bloc would add an event/state
family plus `BlocBuilder` plumbing for state that never outlives its screen.
Bloc state survives navigation, but nothing needs the draft after the
add-transaction route pops — the committed `Transaction` already flows back
through the route result.

**Alternatives considered**:
- `AddTransactionBloc` owning the draft: rejected — the draft never outlives
  its screen, so bloc lifecycle and `BlocBuilder` plumbing would only add
  indirection with no state-survival benefit.
- InheritedWidget bag: implicit, untestable, and Bloc already provides it.

## R3 — Theme switching via Bloc with events, not Cubit

**Decision**: `ThemeBloc` handling `ThemeModeChanged` events; state extends
`Equatable`.

**Rationale**: Per FR-001/FR-002, business logic lives in `on<Event>` handlers
and every event/state extends `Equatable`. A `Cubit` would emit directly and
skip the event layer, leaving the theme bloc inconsistent with the rest of the
migration and forfeiting event history/debuggability (`BlocObserver` sees
events, not cubit invocations, uniformly).

**Alternatives considered**:
- Existing handwritten `ThemeBloc` (StreamController + manual diffs): rejected —
  the entire point of the refactor is removing this boilerplate (SC-001).

## R4 — Bloc placement and provider wiring

**Decision**: Long-lived blocs (theme, dashboard session/ledger) are created at
the composition root in `main.dart` and exposed via `MultiBlocProvider`.
Navigation-scoped blocs (add-transaction draft, category selection) are created
at route push via `BlocProvider` with `lazy: false` where immediate emission is
required, and closed automatically when the route pops.

**Rationale**: Composition-root lifecycle matches the data lifecycle — theme and
session must outlive any single screen. Draft/selection blocs are tied to a
route's lifetime, so route-scoped providers match and avoid leaks.

**Alternatives considered**:
- Repository + get_it service locator (status quo alt): rejected — adds a
  dependency and indirection the constitution doesn't require; bloc providers
  alone satisfy FR-001.

## R5 — Rebuild discipline (how value equality removes overdraw)

**Decision**: All bloc states override `==`/`hashCode` (via `Equatable` `props`),
so `BlocBuilder` rebuilds only when meaningful fields change.

**Rationale**: The current implementation rebuilds whole screens via `setState`.
With Equatable states, `BlocBuilder` calls `==` against the previous state; equal
states short-circuit rebuilds. Widgets that read only one slice (e.g. balance
text) can use `BlocBuilder` with `buildWhen` to narrow further if needed — but
buildWhen is a last resort, not default, to keep rebuild reasoning simple.

## R6 — SegmentedButton migration

**Decision**: Replace `_TypeSegmentedControl`/`_TypeSegment` with a native
`SegmentedButton<TransactionType>`. Selection callbacks dispatch
`TypeChanged(type)` events; no manual color overrides — all colors come from
`ThemeData.colorScheme` (FR-004, FR-005).

**Rationale**: The custom widget duplicates built-in M3 behavior (accessibility,
ripple, selected-state theming) and carries the hard-coded
`Colors.red`/`Colors.green` backgrounds that FR-005 eliminates. The native
widget is already themed by the app's `ColorScheme`.

**Alternatives considered**: Keeping the custom widget with theme-derived
colors — rejected as it maintains duplicate accessory code the native widget
replaces for free.

## R7 — No main.dart imports

**Decision**: No file under `lib/` may import `main.dart` (FR-007); models,
blocs, and shared widgets each live in their own files, imported by feature
paths. `main.dart` is the only file that wires providers to screens.

**Rationale**: Prevents cycles through the composition root, which would break
tree shaking and confuse tooling.
