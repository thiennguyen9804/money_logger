# UI Contract: BLoC and SegmentedButton Architecture Refactor

## Type Selector (Add Transaction screen)

- Selector renders as a Material 3 `SegmentedButton<TransactionType>`.
- Segment highlight colors derive from `ThemeData.colorScheme`
  (`ColorScheme.primary`, `ColorScheme.secondaryContainer`) — no hard-coded
  `Colors.red` / `Colors.green` backgrounds.
- Selecting a segment dispatches `TypeChanged(type)` to `AddTransactionBloc`.
- Category-type compatibility and save gating behave identically to the
  pre-refactor build.

## Theme Switching

- Theme mode changes are dispatched as `ThemeModeChanged(mode)` events to
  `ThemeBloc`.
- All depending widgets rebuild exclusively via bloc state emission — no
  `setState`-driven theme propagation remains.
- Light and dark modes repaint with the same visual parity as the
  pre-refactor build.

## Navigation

- Routing and widget composition are unchanged.
- Draft state survives screen changes (route push/pop) — no in-progress draft
  content may be lost.
- No file under `lib/` may import `main.dart`; shared code resolves from
  `lib/shared/…`, blocs from `lib/blocs/…`.

## Edge Cases

- No partial-migration states in the final deliverable: no orphaned imports or
  references to the deleted custom segment widget.
- No state lost during migration: draft amount, selected category, selected
  type, selected date/time survive navigation.
- No visual regression at narrow widths, large text scales, or in dark theme.
