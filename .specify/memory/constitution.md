<!--
Sync Impact Report
- Version change: unratified scaffold -> 1.0.0
- Modified principles: placeholder principles -> Clean Code; Simple UX;
  Responsive Design; Minimal Dependencies; No Automated Testing
- Added sections: Technology Constraints; Development Workflow
- Removed sections: none
- Follow-up TODOs: none.
-->

# money_logger Constitution

## Core Principles

### I. Clean Code
Production code MUST be readable, focused, and maintainable. Names MUST communicate
intent, functions and widgets MUST have one clear responsibility, and duplication MUST
be removed when it obscures behavior. Changes MUST preserve type safety and follow the
existing Dart and Flutter conventions. This keeps the codebase understandable as the
application grows.

### II. Simple UX
User flows MUST minimize cognitive load and expose only the controls needed for the
current task. UI copy, navigation, feedback, and error states MUST be clear and
consistent. Features MUST avoid speculative options and unnecessary interaction steps.
This keeps money logging fast and predictable.

### III. Responsive Design
Every user-facing screen MUST remain usable across supported Flutter form factors,
orientations, and text scale settings. Layouts MUST use adaptive constraints rather
than fixed dimensions that can cause clipping or overflow. Interactive elements MUST
remain accessible and usable at different viewport sizes. This protects the core
experience across devices.

### IV. Minimal Dependencies
The project MUST use the smallest dependency set that satisfies a documented need.
New packages MUST be justified by meaningful capability, compatibility with the
declared Flutter/Dart toolchain, and lower long-term maintenance cost than an
in-project implementation. Unused dependencies MUST be removed. This reduces supply
chain, build, and maintenance risk.

### V. No Automated Testing
The project MUST NOT add or maintain unit tests, integration tests, or end-to-end
tests. Development validation MUST use static analysis, formatting, manual review,
and manual runtime verification instead. This project policy supersedes generic
testing guidance and keeps the delivery workflow aligned with the product decision
to avoid automated test suites.

## Technology Constraints

The application MUST use Flutter and Dart. The effective Flutter and Dart versions
MUST be those required by the repository's `pubspec.yaml`; contributors MUST NOT
introduce an independent version source or silently widen the declared SDK
constraint. Application code MUST remain compatible with the Flutter SDK dependency
declared there.

## Development Workflow

Every change MUST be scoped to a clear user or maintenance outcome and MUST preserve
the principles above. Before review, contributors MUST run the repository's
configured formatter and static analysis where applicable, inspect the resulting
diff, and perform manual runtime verification for user-facing behavior. Reviewers
MUST reject unnecessary dependencies, non-responsive layouts, unclear UX, and any
unit, integration, or end-to-end test additions.

## Governance

This constitution supersedes conflicting project practices and is the authoritative
source for the principles listed here. Amendments MUST be proposed as a documented
change to this file, state their rationale and impact, and receive project-owner
approval before adoption. Any amendment MUST update the Sync Impact Report and the
version metadata.

Constitution versions follow semantic versioning: MAJOR for backward-incompatible
principle removals or redefinitions, MINOR for new principles or materially expanded
governance, and PATCH for clarifications and non-semantic wording changes. Every
implementation review MUST check compliance with this constitution. Exceptions MUST
be explicitly documented in the change description and approved by the project
owner; temporary exceptions MUST include an expiration or replacement plan.

**Version**: 1.0.0 | **Ratified**: 2026-10-31 | **Last Amended**: 2026-10-31
