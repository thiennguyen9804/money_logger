# Implementation Plan: Transaction Item Formatting

**Branch**: `004-transaction-item-formatting` | **Date**: 2026-11-07 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from [spec.md](./spec.md)

**Note**: This template is filled in by the `/speckit-plan` command; its definition describes the execution workflow.

## Summary

Standardize transaction-row amount presentation across the dashboard preview and
transaction ledger. Reuse one shared row widget so absolute, signless amounts,
right-side alignment, semantic colors, and non-color type cues remain identical
across both surfaces. Preserve existing transaction details and theme behavior
without adding dependencies or automated tests.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart `^3.13.7` as declared in `pubspec.yaml`

**Primary Dependencies**: Flutter SDK and existing `cupertino_icons`; no new dependencies

**Storage**: Existing in-memory `DashboardSessionData`; no storage changes

**Testing**: No automated tests; formatter, analyzer, manual runtime and responsive review

**Target Platform**: Existing Flutter-supported mobile emulator/form factors

**Project Type**: Flutter mobile application

**Performance Goals**: Preserve smooth scrolling and immediate rendering for existing transaction lists

**Constraints**: Responsive narrow layouts and increased text scale; no clipping or overflow; no new packages; no automated tests

**Scale/Scope**: Two transaction-list surfaces in `lib/main.dart`; existing transaction model and session data

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Clean code: PASS — extract one shared transaction-row presentation path and keep formatting helpers focused.
- Simple UX: PASS — preserve existing details while making amount meaning consistent and scannable.
- Responsive design: PASS — use flexible row constraints, ellipsis/wrapping, and manual narrow/text-scale review.
- Minimal dependencies: PASS — no dependency changes.
- No automated testing: PASS — validation uses formatting, static analysis, diff review, and manual runtime inspection only.
- Flutter/Dart governance: PASS — use the versions and SDK declared by `pubspec.yaml`.

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit-plan command output)
├── research.md          # Phase 0 output (/speckit-plan command)
├── data-model.md        # Phase 1 output (/speckit-plan command)
├── quickstart.md        # Phase 1 output (/speckit-plan command)
├── contracts/           # Phase 1 output (/speckit-plan command)
└── tasks.md             # Phase 2 output (/speckit-tasks command - NOT created by /speckit-plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
lib/
└── main.dart

specs/004-transaction-item-formatting/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── contracts/
    └── ui-contract.md
```

**Structure Decision**: Use the existing single-file Flutter application structure. The implementation
is limited to `lib/main.dart`; feature design and validation artifacts remain
under this feature directory. No test directory is created because automated
testing is prohibited by the constitution.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | Not applicable | The feature fits the existing application and requires no constitutional exception. |
