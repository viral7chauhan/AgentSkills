# Enterprise iOS Spec-Driven Development (SDD) Skill

An agent-agnostic **Spec-Driven Development (SDD)** framework for enterprise iOS/tvOS projects.

The goal is to make AI-assisted development predictable, traceable, and replaceable across coding agents such as Codex, Claude Code, Cursor, GitHub Copilot, or future tools.

> **Core principle:** The repository is the source of truth. The AI agent is an interchangeable execution layer.

---

## Why this exists

AI coding agents are very good at generating and changing code, but an enterprise project needs more than code generation. A Tech Lead needs to know:

- What exactly are we building?
- Which architecture and technologies are allowed?
- What was the approved implementation plan?
- Did the agent actually execute the plan?
- Which requirements are covered by tests?
- Did CI independently verify the result?
- What changed when the plan was modified?
- Can we prove that a feature is ready for release?

This framework establishes a controlled lifecycle around those questions.

---

## SDD lifecycle

```text
Project Constitution
        ↓
Feature Specification
        ↓
Clarify
        ↓
Checklist
        ↓
Technical Plan
        ↓
Tasks
        ↓
Analyze
        ↓
Implement
        ↓
Execution Verification
        ↓
Tests / CI
        ↓
Convergence
        ↓
Human Review
        ↓
Merge / Release
```

A feature is not considered complete simply because an agent says that it is complete.

The framework distinguishes:

```text
IMPLEMENTED ≠ VERIFIED ≠ CONVERGED
```

---

# Repository structure

After bootstrapping, the recommended project structure is:

```text
YourApp/
│
├── .sdd/
│   ├── constitution.md
│   │
│   ├── project/
│   │   ├── objective.md
│   │   ├── tech-stack.md
│   │   ├── tech-stack.yaml
│   │   ├── architecture.md
│   │   ├── engineering-rules.md
│   │   ├── security.md
│   │   ├── performance.md
│   │   ├── quality-gates.md
│   │   └── release.md
│   │
│   ├── features/
│   │   └── FTR-###-feature-name/
│   │       ├── spec.md
│   │       ├── clarify.md
│   │       ├── checklist.md
│   │       ├── plan.md
│   │       ├── tasks.md
│   │       ├── test-plan.md
│   │       ├── execution.yaml
│   │       └── status.yaml
│   │
│   ├── adr/
│   │   └── ADR-###-*.md
│   │
│   ├── traceability.yaml
│   ├── mcp-registry.yaml
│   │
│   └── quality/
│       ├── definition-of-ready.md
│       ├── definition-of-done.md
│       ├── execution-rules.md
│       └── release-readiness.md
│
├── agent/
│   ├── workflow.md
│   └── review-rules.md
│
├── templates/
│   ├── feature/
│   ├── project/
│   └── quality/
│
├── scripts/
│   ├── sdd-bootstrap
│   ├── sdd-feature-create
│   ├── sdd-plan-change-check
│   ├── sdd-execution-check
│   ├── sdd-trace
│   ├── sdd-validate
│   ├── sdd-report
│   ├── sdd-mcp-recommend
│   └── package-sync-check
│
├── AGENTS.md
├── Makefile
└── .github/workflows/
    ├── sdd-validation.yml
    └── release-readiness.yml
```

---

# What each document is for

## `.sdd/constitution.md`

The project-wide rules that should not be casually changed.

Examples:

- architecture principles
- testing expectations
- dependency policy
- security rules
- coding standards
- CI requirements
- approval requirements

Think of this as the **engineering constitution** of the application.

---

## `.sdd/project/objective.md`

Defines the application itself:

- product objective
- problem being solved
- target users
- major capabilities
- business goals
- non-goals
- important constraints

This should remain relatively stable.

---

## `.sdd/project/tech-stack.md`

Human-readable source of truth for the technologies used and approved by the application.

Typical contents:

```text
Platform: iOS / tvOS
Language: Swift
UI: SwiftUI / UIKit / TVUIKit
Architecture: MVVM / Clean Architecture
Concurrency: Swift Concurrency
Networking: URLSession / Apollo Client / etc.
Persistence: Core Data / Keychain / UserDefaults / etc.
Testing: XCTest / XCUITest
Quality: SwiftLint / SwiftFormat
CI/CD: GitHub Actions / Fastlane
Analytics: approved analytics SDKs
Feature Flags: approved remote configuration system
Media: approved playback/media SDKs
```

---

## `.sdd/project/tech-stack.yaml`

Machine-readable version of the technology policy.

Use it when you want automation to answer questions such as:

- Is this dependency approved?
- Is this framework allowed?
- What Swift/Xcode version is required?
- Which testing framework is expected?
- What technology is preferred for new code?

Keep the Markdown file explanatory and the YAML file automation-friendly.

---

## `.sdd/project/architecture.md`

Defines technical boundaries and architectural rules.

Example:

```text
Presentation
    ↓
Domain
    ↓
Data

Rules:
- UI must not directly call networking implementations.
- Domain must not import UIKit.
- Domain must not depend on external SDKs.
- ViewModels depend on protocols.
- Concrete implementations are injected.
```

---

## `.sdd/project/engineering-rules.md`

Project-specific engineering rules such as:

- naming
- error handling
- logging
- dependency injection
- concurrency conventions
- code organization
- API conventions
- documentation requirements
- accessibility expectations

---

## `.sdd/project/security.md`

Security and privacy requirements:

- secret handling
- authentication/token rules
- Keychain requirements
- PII rules
- logging restrictions
- network security
- data storage policy
- third-party SDK restrictions

---

## `.sdd/project/performance.md`

Performance expectations such as:

- launch time
- memory
- scrolling
- image/media performance
- network efficiency
- concurrency
- caching
- battery considerations

---

## `.sdd/project/quality-gates.md`

Defines what must pass before a feature can be merged or released.

Example:

```text
Build              Required
Unit tests         Required
UI tests           Required where applicable
Lint               Required
Architecture      Required
Traceability       Required
Execution evidence Required
Critical findings  Zero
```

---

# Feature-specific SDD

Every feature gets its own directory.

Example:

```text
.sdd/features/FTR-023-subscription-restore/
```

The standard feature lifecycle is:

```text
spec.md
  ↓
clarify.md
  ↓
checklist.md
  ↓
plan.md
  ↓
tasks.md
  ↓
test-plan.md
  ↓
execution.yaml
  ↓
status.yaml
```

## `spec.md`

Defines **what** and **why**.

Include:

- problem
- objective
- scope
- non-goals
- user flow
- requirements
- acceptance criteria
- edge cases
- error handling
- analytics
- accessibility
- security/privacy
- dependencies

Use stable IDs:

```text
FR-023-001  Requirement
AC-023-001  Acceptance criterion
```

---

## `clarify.md`

Records ambiguities that must be resolved before implementation.

Example:

```text
- What happens when StoreKit returns pending?
- What happens when the network is unavailable?
- What happens for an expired subscription?
```

Do not allow the agent to invent product behavior to silently fill important gaps.

---

## `checklist.md`

A readiness/completeness check before implementation.

Examples:

```text
[ ] Objective is clear
[ ] Scope is clear
[ ] Acceptance criteria exist
[ ] Edge cases are defined
[ ] Security considered
[ ] Accessibility considered
[ ] Localization considered
[ ] Analytics considered
[ ] Test strategy defined
```

---

## `plan.md`

Defines **how** the feature will be implemented.

Typical sections:

- architecture impact
- components
- modules
- files to create/change
- interfaces/protocols
- data flow
- dependencies
- concurrency approach
- error handling
- test strategy
- migration/rollback plan

Example:

```text
Plan item P-001:
Add SubscriptionRepository abstraction.

Expected:
- protocol added
- implementation injected
- unit tests added
```

---

## `tasks.md`

Turns the plan into executable work.

Example:

```text
T023-001 Add SubscriptionRepository protocol
T023-002 Implement StoreKit adapter
T023-003 Update SubscriptionViewModel
T023-004 Add transaction validation
T023-005 Add unit tests
T023-006 Add UI test
```

Every task should map back to a plan item and, where appropriate, to a requirement.

---

## `test-plan.md`

Defines how requirements and acceptance criteria will be validated.

Example:

```text
TC-023-001 → FR-023-001 → AC-023-001
TC-023-002 → FR-023-002 → AC-023-001
TC-023-003 → FR-023-003 → AC-023-002
```

Tests can be:

- unit
- integration
- UI
- regression
- performance
- contract/API

---

## `execution.yaml`

Tracks whether each plan item was actually executed and verified.

This is intentionally evidence-based.

Example:

```yaml
plan_items:
  - id: P-001
    status: VERIFIED
    evidence:
      code_exists: true
      implementation_verified: true
      tests_exist: true
      tests_passed: true
      architecture_passed: true
      scope_passed: true
      ci_passed: true
```

The framework does **not** treat a checked task as proof.

```text
[x] Task complete
```

is only a claim.

Evidence is what makes it verified:

```text
Code + Tests + Static Checks + CI Evidence
```

---

## `status.yaml`

Machine-readable feature status.

Recommended states:

```text
DRAFT
READY
PLANNED
IMPLEMENTING
IMPLEMENTED
VALIDATING
BLOCKED
CONVERGING
CONVERGED
RELEASE_READY
```

---

# Plan changes are lifecycle events

A major rule of this framework is:

> **Changing a feature plan invalidates previous convergence evidence.**

For example:

```text
FTR-023/plan.md
      ↓
plan changes
      ↓
previous verification becomes stale
      ↓
plan-change check
      ↓
agent must choose an action
```

Run:

```bash
./scripts/sdd-plan-change-check --feature FTR-023
```

The default behavior is to stop and ask whether to:

### Implement

Reconcile the updated plan and run the full feature SDLC:

```text
analyze
→ update tasks/test plan
→ implement
→ execution-check
→ tests/CI
→ converge
```

### Validate

Keep the current code but validate it against the updated plan and report gaps.

### Review

Perform impact analysis and update SDD artifacts without modifying product code.

This prevents an agent from silently treating a changed plan as if it were already implemented.

---

# Traceability

The framework is designed around end-to-end traceability:

```text
Requirement
    ↓
Acceptance Criterion
    ↓
Plan Item
    ↓
Task
    ↓
Code
    ↓
Test
    ↓
CI Evidence
    ↓
PR / Release
```

Stable IDs should be used whenever possible:

```text
FR = Functional Requirement
AC = Acceptance Criterion
P  = Plan Item
T  = Task
TC = Test Case
ADR = Architecture Decision Record
FTR = Feature
```

The goal is for a Tech Lead to answer:

> "Show me the requirement, the planned implementation, the code change, the tests, and the evidence that it passed."

---

# ADRs (Architecture Decision Records)

Use `.sdd/adr/` for important architectural decisions.

Example:

```text
ADR-001-swift-concurrency.md
ADR-002-networking.md
ADR-003-modular-architecture.md
```

Recommended structure:

```text
Context
Decision
Alternatives considered
Consequences
Status
```

ADRs prevent future agents or developers from repeatedly making conflicting architectural choices.

---

# Execution verification

The most important Tech Lead control is:

```text
IMPLEMENTED ≠ VERIFIED
```

Run:

```bash
./scripts/sdd-execution-check --feature FTR-023
```

The checker should verify, where applicable:

- required implementation exists
- expected files/classes/interfaces exist
- required tests exist
- tests pass
- architecture constraints pass
- scope constraints pass
- CI evidence exists
- execution evidence is consistent

A feature should not become `CONVERGED` without satisfying its applicable verification requirements.

---

# Convergence

Convergence answers:

> "Does the actual repository now match the approved intent?"

Conceptually:

```text
Specification
      ↕
Plan
      ↕
Tasks
      ↕
Code
      ↕
Tests
      ↕
CI
```

If a gap is found:

```text
Gap
 ↓
Remediation Task
 ↓
Implementation
 ↓
Validation
 ↓
Convergence
```

A feature can only be considered converged when there are no applicable unresolved gaps.

---

# Definition of Ready

A feature should not enter implementation until the required information exists.

Typical checks:

```text
[ ] Objective defined
[ ] Scope defined
[ ] Non-goals defined
[ ] Requirements defined
[ ] Acceptance criteria defined
[ ] Edge cases defined
[ ] Dependencies identified
[ ] Architecture impact understood
[ ] Security/privacy considered
[ ] Test strategy defined
```

---

# Definition of Done

A feature should not be marked complete until applicable checks pass.

```text
[ ] All requirements implemented
[ ] Acceptance criteria satisfied
[ ] All planned tasks verified
[ ] Automated tests exist
[ ] Automated tests pass
[ ] Build passes
[ ] Lint/static checks pass
[ ] Architecture rules pass
[ ] Scope rules pass
[ ] Traceability complete
[ ] Execution evidence complete
[ ] No critical convergence findings
[ ] Documentation updated
[ ] PR review complete
```

---

# Deterministic validation

AI should not be the sole authority for whether its own work is correct.

Use deterministic commands and CI for objective checks.

Recommended interface:

```bash
make spec-check
make traceability
make execution-check
make validate
make report
```

A typical `make validate` pipeline is:

```text
Specification validation
        ↓
Plan/task validation
        ↓
Traceability
        ↓
Execution evidence
        ↓
Build
        ↓
Unit tests
        ↓
UI/integration tests
        ↓
Lint/format/static checks
        ↓
Security checks
        ↓
Architecture checks
        ↓
Validation report
```

---

# AI agent roles

The framework works best when the agent follows distinct roles, even if the same underlying model executes them.

```text
Planner
  ↓
Developer
  ↓
Reviewer
  ↓
Validator
  ↓
Convergence
```

### Planner

Understands the specification and produces the technical plan.

### Developer

Implements approved tasks and tests.

### Reviewer

Checks specification, architecture, scope, and code changes.

### Validator

Runs deterministic checks and verifies evidence.

### Convergence

Compares specification, plan, tasks, implementation, tests, and actual repository state.

---

# MCP integration

The framework can provide advisory MCP recommendations from:

```text
.sdd/project/tech-stack.md
.sdd/project/tech-stack.yaml
.sdd/features/<feature>/spec.md
.sdd/features/<feature>/plan.md
.sdd/mcp-registry.yaml
```

Run:

```bash
./scripts/sdd-mcp-recommend
./scripts/sdd-mcp-recommend --feature FTR-023
```

Examples of useful MCP categories for an enterprise iOS project:

| MCP | Typical purpose |
|---|---|
| GitHub | Repository, PRs, issues, Actions, security, releases |
| Figma | Design context, components, variables, layouts |
| Linear | Product issues, projects, comments |
| Firebase | Firebase/backend context where applicable |
| Playwright | Web/admin portal automation where applicable |
| iOS Simulator MCP | Interactive simulator/UI inspection where appropriate |

MCP integrations are advisory and permission-controlled. They must not replace deterministic build, test, security, or CI gates.

Prefer official/vendor-maintained MCP implementations and least-privilege permissions.

---

# Bootstrap a project

From an application repository root:

```bash
/path/to/enterprise-ios-sdd/scripts/sdd-bootstrap
```

Review and complete at least:

```text
.sdd/constitution.md
.sdd/project/objective.md
.sdd/project/tech-stack.md
.sdd/project/tech-stack.yaml
.sdd/project/architecture.md
.sdd/project/engineering-rules.md
.sdd/project/security.md
.sdd/project/quality-gates.md
```

The bootstrap process should preserve existing project files rather than overwriting them unnecessarily.

---

# Create a feature

```bash
./scripts/sdd-feature-create FTR-023 "Subscription Restore"
```

Creates:

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

Fill the specification first. Do not begin implementation from an empty or ambiguous plan.

---

# Recommended day-to-day workflow for a Tech Lead

### New feature

```text
1. Create feature
2. Write/approve specification
3. Clarify ambiguity
4. Complete checklist
5. Create technical plan
6. Review/approve plan
7. Generate tasks
8. Implement
9. Verify execution
10. Run CI
11. Converge
12. Review PR
13. Release when ready
```

### Existing feature plan changed

```text
1. Detect plan change
2. Mark prior verification stale
3. Ask: implement / validate / review
4. Reconcile SDD artifacts
5. Execute requested lifecycle
6. Re-run verification
7. Re-run CI
8. Re-converge
```

### Bug fix

Use the same principles:

```text
Bug
 ↓
Reproduction
 ↓
Root cause
 ↓
Fix plan
 ↓
Regression test
 ↓
Implementation
 ↓
Validation
 ↓
CI
 ↓
Convergence
```

---

# Recommended skills around this SDD skill

Start small. A practical initial set is:

### Workflow skills

```text
enterprise-ios-sdd
ios-feature-spec
ios-code-review
ios-convergence
```

### General iOS engineering skills

```text
ios-architecture
swift-testing
swift-concurrency
ios-performance
ios-security
ios-ci
```

Add specialized skills later for areas such as StoreKit, networking, media playback, accessibility, Firebase, or your internal frameworks.

The SDD skill defines **how work is controlled**. Engineering skills define **how a specific technical area should be implemented**.

---

# Agent independence

Do not put the complete project knowledge inside an agent-specific prompt file.

Keep agent-specific instructions thin:

```text
AGENTS.md
    ↓
Read .sdd/
    ↓
Follow the project workflow
    ↓
Run deterministic validation
```

This allows you to change the coding agent without rewriting the engineering process.

```text
                 Same repository
                       │
         ┌─────────────┼─────────────┐
         ↓             ↓             ↓
      Codex        Claude Code     Cursor
         │             │             │
         └─────────────┼─────────────┘
                       ↓
                 Same SDD rules
                 Same tests
                 Same CI
                 Same evidence
```

---

# Package maintenance

This repository contains the reusable Skill package itself.

Before publishing an updated version:

```bash
./scripts/package-sync-check
```

This should verify that the Skill contract, templates, scripts, documentation, and examples remain aligned.

When the framework changes, update all of the following together where relevant:

```text
SKILL.md
README.md
docs.html
templates/
scripts/
AGENTS.md
skill-manifest.md
```

Avoid having documentation describe commands or files that do not exist in the package.

---

# Design principles

1. **Specification is the source of intent.**
2. **Architecture rules are explicit.**
3. **Plans are executable artifacts, not notes.**
4. **Plan changes invalidate previous verification.**
5. **Implemented is not verified.**
6. **A checkbox is not evidence.**
7. **Tests and CI provide objective evidence.**
8. **Convergence checks actual repository state against intended state.**
9. **Scope expansion must be explicit.**
10. **Important architectural decisions are captured in ADRs.**
11. **AI is an execution layer, not the source of truth.**
12. **Human approval remains required for product ambiguity and significant engineering exceptions.**

---

# Reference

This framework is inspired by the broader **Spec-Driven Development (SDD)** approach, including workflows that separate requirements, plans, tasks, implementation, analysis, and convergence.

It is intentionally customized for enterprise iOS/tvOS engineering, with additional emphasis on:

- Tech Lead governance
- execution evidence
- requirement traceability
- architecture enforcement
- CI quality gates
- plan-change detection
- agent portability
- MCP recommendations

See `docs.html` in this package for a visual explanation of every file and workflow stage.

---

## License / usage

This framework is intended to be adapted to your organization's engineering standards. Customize the constitution, technology policy, architecture rules, quality gates, templates, and CI checks to match your application and compliance requirements.
