# Research: Initial Layout and Theme Setup

## Decision: Use a focused in-project ThemeBloc

**Rationale**:

- The feature has one small global state concern: the current light/dark theme.
- `pubspec.yaml` contains Flutter and `cupertino_icons`, so adding a state package
  would expand the dependency surface for a narrowly scoped requirement.
- A focused BLoC can expose immutable `ThemeState`, accept explicit theme events,
  notify the application shell, and dispose its stream/controller cleanly.
- This satisfies the constitution's minimal-dependency rule while retaining a clear
  separation between theme events, state, and presentation.

**Alternatives considered**:

- `flutter_bloc`: standard provider and builder APIs, but adds a dependency and
  transitive maintenance surface that is disproportionate to one synchronous setting.
- Direct `setState`: simpler initially, but does not provide a global event/state
  boundary for theme changes.
- `ChangeNotifier`: available in Flutter, but less aligned with the requested BLoC
  architecture and event-driven state separation.

## Decision: Use Flutter default navigation

**Rationale**:

- `MaterialApp`, `Navigator`, and route names provide navigation without an external
  routing package.
- The shell can keep the five primary destination widgets in an indexed container,
  switching the visible index while retaining each destination's session state.
- This supports mobile and web behavior consistently while preserving the existing
  dependency constraints.

**Alternatives considered**:

- A third-party routing package: unnecessary for five fixed destinations and adds
  dependency and configuration overhead.
- Rebuilding a destination on every selection: simpler, but loses scroll position and
  active view state required by FR-012.

## Decision: Keep state in memory for the session

**Rationale**:

- The specification explicitly excludes persistence between launches.
- In-memory destination state is sufficient for preserving scroll position, active
  view state, and the selected theme during navigation.

**Alternatives considered**:

- Local or remote persistence: outside the feature scope and would introduce data
  modeling, failure states, and dependencies not needed by the initial shell.

## Decision: Validate manually, not with automated tests

**Rationale**:

- The project constitution explicitly prohibits unit, integration, and end-to-end
  tests.
- Formatter, analyzer, manual runtime checks, responsive review, and theme review
  provide the required validation within project governance.

**Alternatives considered**:

- Widget or integration tests: prohibited by the project constitution.
