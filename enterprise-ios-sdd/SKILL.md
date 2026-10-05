---
name: enterprise-ios-sdd
description: Run an agent-agnostic, specification-driven development workflow for enterprise iOS/tvOS projects. Use when bootstrapping a project SDD structure, creating or updating feature specifications, clarifying requirements, producing technical plans and tasks, implementing against approved specifications, validating code and tests, checking traceability, or running convergence and CI quality gates.
---

# Enterprise iOS Spec-Driven Development (SDD) Skill

## Purpose

This skill defines an agent-agnostic, specification-driven development workflow for enterprise iOS/tvOS applications.

The skill makes the repository specification, architecture rules, acceptance criteria, tests, CI, and traceability the source of truth. The coding agent is an execution layer and may be replaced by another agent or development tool without changing the project process.

Use this skill to:

- bootstrap a reusable SDD project structure
- define project-wide engineering constraints
- create and evolve feature specifications
- clarify ambiguous requirements before implementation
- produce technical implementation plans
- decompose plans into traceable tasks
- implement code against approved specifications
- create and update automated tests
- validate changes against requirements and architecture
- detect gaps between specification, implementation, and tests
- run project quality gates and CI validation
- produce convergence and traceability reports
- maintain ADRs for significant architectural decisions

---

## Core Principles

1. Specification is the source of intent.
2. Constitution and architecture rules are non-negotiable project constraints unless explicitly changed.
3. Requirements must be traceable to acceptance criteria, implementation, tests, and CI evidence.
4. Do not invent product requirements.
5. Do not change architecture silently.
6. Do not mark a requirement complete without evidence.
7. Prefer the smallest change that satisfies the specification.
8. New behavior requires appropriate automated validation.
9. Significant architectural decisions require an ADR.
10. CI is the authoritative execution evidence for build and test quality gates.
11. Keep agent-specific instructions thin; project knowledge belongs in `.sdd/`.
12. Never bypass a failing quality gate merely to make a task appear complete.

---

## Tech Lead Control Model

The workflow separates three kinds of authority:

1. **Agent judgment:** planning, implementation, review, and convergence analysis.
2. **Deterministic evidence:** builds, tests, linting, architecture/static checks, traceability scripts, and CI results.
3. **Human approval:** product intent and high-impact architecture/security/release exceptions.

Never allow an agent's completion checkbox to substitute for deterministic evidence.

The required execution chain is:

```text
Requirement → Acceptance → Plan → Task → Code → Test → CI Evidence
```

A feature is `CONVERGED` only when the applicable chain is complete and required quality gates pass.

---

## Executable Project Scaffolding

The skill should provide reusable templates plus a stable command for creating feature artifacts.

Recommended command:

```bash
./scripts/sdd-feature-create "Subscription Restore"
```

or with an explicit ID:

```bash
./scripts/sdd-feature-create FTR-023 "Subscription Restore"
```

This command creates:

```text
.sdd/features/FTR-023-subscription-restore/
├── spec.md
├── clarify.md
├── checklist.md
├── plan.md
├── tasks.md
├── test-plan.md
├── execution.yaml
└── status.yaml
```

The templates are stored under `templates/feature/`. The command must not create application code or silently invent product requirements.

Agents should use this scaffolding when starting a feature instead of manually recreating the artifact set.

## Repository Contract

The preferred project structure is:

```text
.sdd/
├── constitution.md
├── project/
│   ├── objective.md
│   ├── tech-stack.md
│   ├── architecture.md
│   ├── engineering-rules.md
│   ├── security.md
│   ├── performance.md
│   ├── quality-gates.md
│   └── release.md
├── features/
│   └── FTR-###-feature-name/
│       ├── spec.md
│       ├── clarify.md
│       ├── checklist.md
│       ├── plan.md
│       ├── tasks.md
│       ├── test-plan.md
│       ├── execution.yaml
│       └── status.yaml
├── adr/
│   ├── ADR-001-*.md
│   └── ADR-002-*.md
├── traceability.yaml
└── quality/
    ├── definition-of-ready.md
    ├── definition-of-done.md
    ├── execution-rules.md
    └── release-readiness.md

agent/
├── workflow.md
└── review-rules.md

templates/
├── feature/
│   ├── spec.md
│   ├── clarify.md
│   ├── checklist.md
│   ├── plan.md
│   ├── tasks.md
│   ├── test-plan.md
│   ├── execution.yaml
│   └── status.yaml
├── project/
│   └── traceability.yaml
└── quality/
    ├── definition-of-ready.md
    ├── definition-of-done.md
    ├── execution-rules.md
    └── release-readiness.md

scripts/
├── sdd-feature-create
├── sdd-validate
├── sdd-trace
├── sdd-execution-check
└── sdd-report

AGENTS.md
Makefile
github-workflows/
├── sdd-validation.yml
└── release-readiness.yml

# When adopted into a real repository, copy/merge these into .github/workflows/.
```

If the repository already has an equivalent structure, reuse it instead of creating duplicates. Adapt to existing conventions where possible.

---

# Operating Modes

The agent operates in one of the following modes.

## Mode 1: Bootstrap

Use when `.sdd/` does not exist or the user asks to initialize the SDD framework.

Tasks:

1. Inspect the repository before creating files.
2. Identify platform, package manager, build system, test framework, CI provider, and existing architecture documentation.
3. Create the `.sdd/` structure.
4. Create templates/content with clearly marked project-specific placeholders.
5. Create `agent/workflow.md`, `agent/review-rules.md`, `AGENTS.md`, and validation command stubs where appropriate.
6. Do not invent project decisions. Mark unknown items as `TBD`.
7. Provide a bootstrap summary and list any information that still requires a human decision.

Bootstrap must not rewrite application code unless explicitly requested.

---

## Mode 2: Project Definition

Use when defining or updating project-wide rules.

Read first:

- `.sdd/constitution.md`
- `.sdd/project/objective.md`
- `.sdd/project/tech-stack.md`
- `.sdd/project/architecture.md`
- `.sdd/project/engineering-rules.md`
- `.sdd/project/security.md`
- `.sdd/project/performance.md`
- `.sdd/project/quality-gates.md`
- `.sdd/quality/definition-of-ready.md`
- `.sdd/quality/definition-of-done.md`
- `.sdd/quality/execution-rules.md`
- `.sdd/quality/release-readiness.md`

Update only the relevant project documents.

When a change affects a long-lived architectural choice, create or update an ADR instead of hiding the decision inside general documentation.

---

## Mode 2.5: Create Feature Scaffolding

Use the executable feature scaffold command when starting a new feature.

1. Obtain or establish the feature ID.
2. Create the standard artifact set from `templates/feature/`.
3. Populate only known context.
4. Mark unknown decisions as `TBD` or `OPEN`; do not fabricate requirements.
5. Move to Specify Feature mode.

## Mode 3: Specify Feature

Use when a new feature, enhancement, defect with meaningful behavior change, or epic needs a formal specification.

Create:

```text
.sdd/features/FTR-###-feature-name/
├── spec.md
├── clarify.md
├── checklist.md
├── plan.md
├── tasks.md
├── test-plan.md
└── status.yaml
```

### `spec.md` must describe WHAT and WHY

Required sections:

```text
# Feature

## Problem
## Objective
## Scope
## Out of Scope
## User/System Actors
## User Flows
## Functional Requirements
## Acceptance Criteria
## Edge Cases
## Error Handling
## Analytics / Observability
## Accessibility
## Localization
## Security / Privacy
## Performance / Reliability
## Dependencies
## Rollout / Feature Flag
## Rollback / Failure Strategy
## Open Questions
```

Each requirement must have a stable ID:

```text
FR-###-001
FR-###-002
```

Each acceptance criterion must have a stable ID:

```text
AC-###-001
AC-###-002
```

Acceptance criteria should be behavior-oriented and independently verifiable.

Prefer:

```text
Given ...
When ...
Then ...
```

Avoid vague criteria such as `works correctly`, `fast`, or `properly handles errors` without measurable meaning.

---

## Mode 4: Clarify

Use before planning when the specification contains ambiguity, contradiction, missing behavior, or unresolved decisions.

Record questions and answers in `clarify.md`.

For every unresolved item:

```text
ID: CL-###-001
Question:
Why it matters:
Options:
Decision:
Decision owner:
Status: OPEN | RESOLVED
```

Do not silently guess when the missing information can materially change behavior, architecture, security, data handling, or acceptance criteria.

If the task is low-risk and the repository already establishes an unambiguous convention, follow the convention and document the assumption.

---

## Mode 5: Plan

Use only after the feature specification is sufficiently clear.

Read:

- constitution
- applicable project rules
- applicable ADRs
- feature `spec.md`
- feature `clarify.md`
- relevant existing code
- existing tests

Create `plan.md` containing:

```text
# Implementation Plan

## Summary
## Existing Components Reused
## Components to Change
## New Components
## Data / State Flow
## API / Dependency Changes
## Architecture Impact
## Error Handling Strategy
## Concurrency / Thread Safety
## Performance Considerations
## Security Considerations
## Testing Strategy
## Observability / Analytics
## Migration / Compatibility
## Risks
## Alternatives Considered
```

Every proposed technical change must support one or more requirements or necessary engineering constraints.

Do not introduce new libraries, architectural patterns, or persistent data models without justification.

If an important architectural decision is introduced, create an ADR or flag that an ADR is required.

---

## Mode 6: Checklist

Create or update `checklist.md` to validate specification and plan completeness.

At minimum check:

```text
[ ] Objective is clear
[ ] Scope is clear
[ ] Non-goals are explicit
[ ] Requirements have IDs
[ ] Acceptance criteria have IDs
[ ] Edge cases are defined
[ ] Error states are defined
[ ] Security/privacy considered
[ ] Accessibility considered
[ ] Localization considered where applicable
[ ] Analytics/observability considered
[ ] Performance considered
[ ] Rollout/rollback considered
[ ] Architecture impact assessed
[ ] Dependencies identified
[ ] Test strategy covers acceptance criteria
[ ] Traceability can be established
```

The checklist is not a substitute for tests. It verifies planning completeness.

---

## Mode 7: Task Breakdown

Create `tasks.md` from the approved specification and plan.

Every task must have a stable ID and traceability references.

Example:

```text
T-###-001
Description: Add SubscriptionRepository protocol
References: FR-###-001, AC-###-001
Expected files/modules: Subscription/Domain
Validation: Unit tests
Status: TODO
```

Task categories may include:

```text
SPEC
ARCHITECTURE
IMPLEMENTATION
TEST
UI
ANALYTICS
SECURITY
DOCUMENTATION
CI
MIGRATION
```

Do not create implementation tasks that have no relationship to the specification, plan, or required engineering constraints.

---

## Mode 8: Test Planning

Create `test-plan.md` before or during implementation.

Tests should cover:

- happy paths
- edge cases
- invalid inputs
- error conditions
- state transitions
- concurrency behavior where applicable
- persistence/migration behavior where applicable
- networking behavior using mocks/stubs
- analytics/observability where testable
- UI behavior where user-visible behavior requires it
- accessibility/localization where applicable

Each test case must map to a requirement or acceptance criterion.

Preferred format:

```text
TC-###-001
Requirement: FR-###-001
Acceptance: AC-###-001
Type: Unit | Integration | UI | Snapshot | Performance | Contract
Scenario:
Expected result:
Automation reference:
Status:
```

---

## Mode 9: Implement

Before changing code:

1. Read the feature specification.
2. Read the plan.
3. Read the applicable task(s).
4. Inspect existing implementation and tests.
5. Confirm the change fits existing architecture.

During implementation:

- follow the constitution and project rules
- follow applicable ADRs
- avoid unrelated refactoring
- preserve public behavior unless the specification explicitly changes it
- use dependency injection and existing abstractions where the architecture requires them
- add or update tests for changed behavior
- keep changes focused
- update documentation or traceability when required

Do not claim success until validation has actually been executed.

---

## Mode 10: Execution Verification

Use `execution.yaml` to track whether each meaningful plan item was actually executed and whether the required evidence exists. This is the Tech Lead control that distinguishes implementation claims from verified execution.

For every plan item, record:

```yaml
- id: P-###-001
  description: Add SubscriptionRepository abstraction
  references:
    requirements: [FR-###-001]
    acceptance_criteria: [AC-###-001]
    tasks: [T-###-001]
  expected_files:
    - Sources/Subscription/SubscriptionRepository.swift
  evidence:
    code_exists: true
    behavior_verified: true
    tests_exist: true
    tests_passed: true
    ci_passed: true
    architecture_checked: true
    scope_checked: true
  status: VERIFIED
```

Use these statuses:

```text
NOT_STARTED | IN_PROGRESS | IMPLEMENTED | VERIFIED | BLOCKED | NOT_APPLICABLE
```

`IMPLEMENTED` is an agent progress claim. `VERIFIED` requires evidence. Never infer missing evidence.

Run:

```bash
make sdd-execution-check FEATURE=.sdd/features/FTR-###-feature-name
```

The execution checker should validate the feature artifact set, detect missing evidence for required plan items, and report blockers.

## Mode 11: Review

Review the implementation independently against:

```text
Specification
Plan
Tasks
Architecture
ADR constraints
Tests
Security rules
Performance requirements
```

The review must identify:

```text
COMPLIANT
NON-COMPLIANT
MISSING
UNCLEAR
OUT-OF-SCOPE
```

For each issue include:

```text
Issue ID
Severity: BLOCKER | HIGH | MEDIUM | LOW
Requirement/Acceptance reference
Evidence
Recommended remediation
```

Do not use subjective statements such as `looks good` as validation evidence.

---

## Mode 12: Converge

Convergence verifies that the current repository state satisfies the specification.

Compare:

```text
Specification
      ↕
Acceptance Criteria
      ↕
Plan
      ↕
Tasks
      ↕
Implementation
      ↕
Tests
      ↕
CI Evidence
```

For every requirement, determine:

```text
Implemented: YES | NO | UNCLEAR
Validated: YES | NO | UNCLEAR
Evidence: file/test/CI reference
```

Example:

```text
FR-023-001
Implemented: YES
Validated: YES
Evidence:
- SubscriptionRepository.swift
- testRestoreActiveSubscription()
- CI run 8921

FR-023-002
Implemented: YES
Validated: NO
Evidence:
- implementation exists
Gap:
- no automated validation for pending state
Remediation:
- T-023-014
```

A feature is **CONVERGED** only when all required acceptance criteria are satisfied and required quality gates pass.

If gaps remain:

1. create remediation tasks
2. link them to the affected requirement/acceptance criterion
3. return the feature to implementation
4. re-run convergence after remediation

Never silently change the acceptance criteria merely to make implementation pass.

---

## Mode 13: CI / Quality Validation

Prefer project-provided commands over agent-specific commands.

Expected command interface:

```text
make build
make test
make lint
make format-check
make validate
make traceability
make report
```

A project may map these to `xcodebuild`, SwiftLint, SwiftFormat, coverage tooling, security scanners, or other approved tools.

The agent must report the actual command results and distinguish:

```text
PASS
FAIL
NOT RUN
BLOCKED
NOT APPLICABLE
```

Never infer CI success from code inspection alone.

---

## Mode 14: Traceability

Maintain `.sdd/traceability.yaml` or equivalent machine-readable output.

Minimum relationship:

```text
Requirement
  → Acceptance Criterion
  → Task
  → Implementation reference
  → Test case
  → CI evidence
```

Example:

```yaml
- requirement: FR-023-001
  acceptance:
    - AC-023-001
  tasks:
    - T-023-001
    - T-023-004
  implementation:
    - SubscriptionRepository.swift
  tests:
    - TC-023-001
  ci:
    - run: 8921
      status: passed
```

Missing links should be reported as validation gaps.

---

## Mode 15: ADR

Create an Architecture Decision Record when a decision is long-lived, cross-cutting, difficult to reverse, or materially changes architecture, dependencies, data, concurrency, security, or platform strategy.

Use:

```text
.sdd/adr/ADR-###-short-title.md
```

Required sections:

```text
# ADR-###: Decision Title

## Status
Proposed | Accepted | Superseded | Deprecated

## Context

## Decision

## Alternatives Considered

## Consequences

## Related Specifications
```

Do not create an ADR for routine implementation details.

---

## Mode 16: Bug Fix

For production defects:

1. Reproduce or establish the observed symptom.
2. Identify the expected behavior from existing specification or create a missing specification/acceptance criterion.
3. Assess the root cause.
4. Implement the smallest safe fix.
5. Add a regression test.
6. Run relevant CI gates.
7. Converge against the original expected behavior.

Do not rewrite the product specification merely to rationalize an existing bug.

---

## Mode 17: Reporting

Generate an evidence-oriented project report with:

- per-feature status
- verified versus total plan items
- blockers
- requirement/test coverage where available
- CI state
- traceability state

Run:

```bash
make sdd-report
```

The report must reflect repository evidence, not an agent's prose claim.

## Mode 18: Release Readiness

A release candidate must not be considered ready until release-scoped features are converged, required execution evidence and CI gates exist, traceability is complete, and blocking findings are resolved or explicitly approved.

Use `.sdd/quality/release-readiness.md` as the release checklist.

## Agent Independence

The SDD artifacts and scripts must not depend on the identity of the coding agent.

Agent-specific adapters may contain only:

- how to discover the skill
- how to invoke the workflow
- tool permissions
- concise repository instructions

Project behavior, architecture, specifications, test requirements, and quality gates belong in `.sdd/` and repository scripts.

Examples of compatible invocation styles include slash commands, skill commands, or agent-specific workflows. The underlying repository process remains the same.

---

## Human Approval Gates

Human review is required when a change:

- changes product behavior not already covered by the specification
- changes a constitution MUST rule
- introduces a significant architecture decision
- adds a dependency with meaningful security/licensing/runtime impact
- changes data storage or migration strategy
- changes authentication/authorization/security behavior
- changes release/rollout strategy materially

The agent may prepare the change, but must not pretend approval has happened.

---

## Completion Contract

Before declaring a feature complete, report:

```text
Feature: FTR-###
Status: CONVERGED | BLOCKED

Requirements: X/Y implemented
Acceptance criteria: X/Y satisfied
Automated tests: X/Y passing
Architecture checks: PASS/FAIL
CI: PASS/FAIL/NOT RUN
Traceability: COMPLETE/INCOMPLETE
Open blockers: ...
Evidence: ...
```

A feature cannot be marked `CONVERGED` when required evidence is missing.
