---
name: enterprise-ios-sdd
description: Run an agent-agnostic, specification-driven development workflow for enterprise iOS/tvOS projects. Use when bootstrapping project SDD, creating or changing feature specifications or plans, detecting plan changes, generating tasks, implementing code, validating execution evidence, checking traceability, running convergence, CI quality gates, release readiness, and recommending MCP integrations from project context and tech stack.
---

# Enterprise iOS Spec-Driven Development (SDD) Skill

## Purpose

This skill turns project intent into a controlled, evidence-based development lifecycle for enterprise iOS/tvOS applications. The repository is the source of truth; an AI coding agent is an interchangeable execution layer.

The skill is designed around:

`constitution → specify → clarify → plan → checklist → tasks → analyze → implement → execution-check → test/CI → converge → human review → merge/release`

It also treats a feature `plan.md` change as an explicit lifecycle event. A plan change MUST trigger impact analysis and MUST NOT be silently ignored.

## Core Principles

1. Specification is the source of intent.
2. Constitution and architecture rules are binding unless explicitly changed.
3. Requirements must trace to acceptance criteria, plan items, tasks, code, tests, and CI evidence.
4. `IMPLEMENTED` is not the same as `VERIFIED`.
5. A checkbox is not evidence; evidence must come from code inspection, tests, static checks, or CI.
6. Do not invent product requirements.
7. Do not change architecture silently.
8. New behavior requires appropriate automated validation.
9. Significant architectural decisions require an ADR.
10. CI and deterministic tooling are the authority for build/test quality gates.
11. Keep agent-specific instructions thin; project knowledge belongs in `.sdd/`.
12. Prefer the smallest change that satisfies the approved specification.
13. Scope expansion must be explicit and traceable.
14. A feature is `CONVERGED` only when applicable requirements, plan items, tasks, tests, and quality gates are satisfied.
15. When project context or tech-stack changes, MCP recommendations must be re-evaluated rather than assumed unchanged.

## Authority Model

### Agent authority

The agent may:
- inspect the repository
- draft specifications and plans
- generate implementation tasks
- implement approved work
- run deterministic validation commands
- produce review and convergence reports

The agent MUST NOT silently:
- invent requirements
- weaken quality gates
- bypass CI
- introduce prohibited dependencies
- change architecture without the defined approval path
- mark a feature converged without evidence

### Deterministic authority

Scripts and CI should decide:
- whether required artifacts exist
- whether traceability is complete
- whether scope constraints are violated
- whether required files/tests are present
- whether builds/tests/lint/static checks pass
- whether required execution evidence exists

### Human authority

Human approval is required for:
- product ambiguity that cannot be resolved from existing context
- architecture exceptions
- security/privacy exceptions
- major dependency additions
- breaking API/schema changes
- release exceptions
- plan changes where the user has not chosen the desired lifecycle action

## Executable Project Scaffolding

The skill provides reusable templates and stable commands for bootstrapping a repository and creating feature artifacts.

Project bootstrap:

```bash
./scripts/sdd-bootstrap
```

Feature creation:

```bash
./scripts/sdd-feature-create FTR-023 "Subscription Restore"
```

The bootstrap command creates/merges the project SDD files, agent adapters, validation scripts, Makefile, and CI workflow templates. Existing files are preserved by default.

## MCP Context Recommendation

Use `./scripts/sdd-mcp-recommend` to map `.sdd/project/tech-stack.md` / `.sdd/project/tech-stack.yaml` plus an optional feature `spec.md` / `plan.md` to advisory MCP recommendations. This never installs an MCP automatically.

```bash
./scripts/sdd-mcp-recommend
./scripts/sdd-mcp-recommend --feature FTR-023
```

Prefer official/vendor-maintained MCP servers, least privilege, and read-only access where possible. Keep deterministic build/test/quality decisions in scripts and CI.

## Canonical Repository Structure

```text
.sdd/
├── constitution.md
├── project/
│   ├── objective.md
│   ├── tech-stack.md
│   ├── tech-stack.yaml
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
│   └── ADR-###-*.md
├── traceability.yaml
├── mcp-registry.yaml
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
├── project/
└── quality/

scripts/
├── sdd-bootstrap
├── sdd-feature-create
├── sdd-plan-change-check
├── sdd-execution-check
├── sdd-trace
├── sdd-validate
├── sdd-report
└── sdd-mcp-recommend

AGENTS.md
Makefile
.github/workflows/
├── sdd-validation.yml
└── release-readiness.yml
```

If an equivalent project structure already exists, reuse it instead of creating duplicates.

## Project Technology Stack

`.sdd/project/tech-stack.md` is the human-readable source of truth for the application's approved technologies. It should include:

- platform and minimum OS
- Swift/Xcode versions
- UI frameworks
- architecture style
- concurrency model
- networking
- persistence
- dependency manager and approved third-party SDKs
- testing tools
- lint/format/security tools
- CI/CD
- observability/analytics
- feature flag/remote configuration
- media stack where relevant

For machine validation, keep `.sdd/project/tech-stack.yaml` when the project needs versioned, structured rules. The Markdown file remains the explanatory reference; YAML is the automation-friendly contract.

Example fields:

```yaml
platform:
  ios: true
  tvos: true
  min_ios: "TBD"

language:
  swift: "TBD"
  xcode: "TBD"

ui:
  primary: "SwiftUI"
  legacy: ["UIKit"]

architecture:
  style: "TBD"

concurrency:
  preferred: ["async-await", "actors"]

dependencies:
  manager: "Swift Package Manager"
  approved: []
  prohibited: []

testing:
  unit: "XCTest"
  ui: "XCUITest"

ci:
  provider: "TBD"
```

## Feature Lifecycle

### 1. Specify

Create a feature folder using:

```bash
./scripts/sdd-feature-create FTR-023 "Subscription Restore"
```

Then complete `spec.md` with WHAT and WHY:

- objective
- scope/non-goals
- user flows
- functional requirements (`FR-*`)
- non-functional requirements
- acceptance criteria (`AC-*`)
- edge cases
- analytics
- security/privacy
- accessibility/localization
- dependencies and constraints

Do not create an implementation plan yet if requirements are materially ambiguous.

### 2. Clarify

Record unresolved questions in `clarify.md`. Each clarification should have a status:

`OPEN | DECIDED | REJECTED | NOT_APPLICABLE`

A feature with unresolved blocking questions is not ready for implementation.

### 3. Checklist / Definition of Ready

Use `checklist.md` to confirm the feature is sufficiently defined before implementation.

### 4. Plan

`plan.md` describes HOW. It should reference exact requirement IDs and cover:

- architecture impact
- modules/components affected
- files likely to change
- interfaces and data flow
- dependency changes
- concurrency considerations
- error handling
- observability
- performance
- migration/rollback
- testing strategy
- security/accessibility/localization considerations
- scope constraints
- plan item IDs (`P-*`)

Every meaningful plan item should map back to one or more `FR-*`/`NFR-*` IDs.

### 5. Tasks

`tasks.md` breaks plan items into executable tasks (`T-*`). Every task must reference the source plan item.

Task states:

`NOT_STARTED | IN_PROGRESS | IMPLEMENTED | VERIFIED | BLOCKED | CANCELLED`

Only `VERIFIED` can satisfy the execution chain.

### 6. Test plan

`test-plan.md` defines test cases (`TC-*`) mapped to acceptance criteria and requirements. Include automated test names/files when known.

### 7. Analyze

Before implementation and after major changes, perform consistency analysis:

```text
Spec ↔ Plan
Spec ↔ Tasks
Plan ↔ Tasks
Requirements ↔ Tests
Scope ↔ Code Changes
Tech Stack ↔ Implementation Choices
```

### 8. Implement

Implement only against the approved feature artifacts. The agent should:

- read project rules first
- read the feature spec and plan
- complete tasks in traceable order
- add/update tests
- avoid unrelated changes
- update execution evidence
- run deterministic validation commands

### 9. Execution Check

`scripts/sdd-execution-check` verifies that implemented plan items have evidence.

Minimum evidence should include, where applicable:

- expected code exists
- expected behavior is observable in the implementation
- associated tests exist
- tests pass
- architecture constraints pass
- scope is respected
- CI evidence exists

A plan item becomes `VERIFIED` only when required evidence exists.

### 10. Converge

Compare:

`spec → plan → tasks → code → tests → CI`

Record gaps as remediation tasks. Never hide mismatches by changing status manually.

### 11. Human Review

The Tech Lead reviews the generated evidence, architectural impact, risk, and exceptions. The agent may prepare the review package but should not self-approve a human-only gate.

## Plan Change Trigger — Mandatory

A change to `.sdd/features/**/plan.md` is a lifecycle event.

The following are considered plan changes:

- `plan.md` added
- `plan.md` modified
- a plan item added/removed
- expected files/modules changed
- architecture/dependency approach changed
- scope constraints changed

When a plan change is detected, the agent MUST:

1. stop treating the feature as fully converged
2. run impact analysis
3. compare old and new plan (when git history is available)
4. update affected tasks/test plan/execution/status artifacts
5. determine whether implementation is required
6. ask the user which lifecycle action to perform unless project policy explicitly pre-authorizes a mode

### User decision options

The agent should ask a single focused question such as:

> `Plan changed for FTR-023. How should I proceed?`
>
> `1. Implement/ reconcile the updated plan and run the full feature SDLC`
> `2. Validate the existing implementation against the updated plan only`
> `3. Review impact and update tasks/spec artifacts, but do not change code`

The deterministic helper supports the same explicit modes:

```bash
./scripts/sdd-plan-change-check --feature FTR-023
./scripts/sdd-plan-change-check --feature FTR-023 --mode implement
./scripts/sdd-plan-change-check --feature FTR-023 --mode validate
./scripts/sdd-plan-change-check --feature FTR-023 --mode review
```

Default behavior is `ask/block`, which exits non-zero so CI or automation cannot silently continue with stale execution assumptions.

If `--mode implement` is selected, run the feature lifecycle from analysis through implementation, execution-check, tests, CI, and convergence.

If `--mode validate` is selected, do not change code unless the validation process itself requires test-only support; validate the current implementation against the updated plan and produce gaps.

If `--mode review` is selected, produce impact findings and reconcile SDD artifacts, but do not implement code.

## Scope Control

Feature plans should declare allowed and forbidden change areas where practical.

Example:

```yaml
scope:
  allowed_paths:
    - "Sources/Subscription/**"
    - "Tests/Subscription/**"
  forbidden_paths:
    - "Sources/Payments/**"
    - "Package.swift"
  allowed_dependencies: []
```

The agent must flag scope expansion. Scope changes require updating the plan and execution evidence before convergence.

## Traceability

Maintain a central `.sdd/traceability.yaml` plus per-feature execution evidence.

Canonical chain:

`FR/NFR → AC → P → T → Code → TC → CI → PR/Release`

No feature should be considered release-ready if required links are missing.

## Architecture and ADRs

Use ADRs for decisions that will constrain future work. An ADR should contain:

- Context
- Decision
- Alternatives considered
- Consequences
- Status
- Related specs/features

Do not create an ADR for trivial implementation details.

## CI / Quality Gates

Expose deterministic commands through `Makefile`, for example:

```bash
make spec-check
make traceability
make execution-check
make build
make test
make lint
make validate
make report
```

`make validate` should combine repository-specific deterministic checks. CI should call the same commands so local and CI validation are aligned.

Suggested gates:

- SDD artifact consistency
- requirement/acceptance/task/test traceability
- execution evidence
- build
- unit tests
- integration tests
- UI tests where required
- lint/format
- architecture/static checks
- security/secrets scan
- dependency audit
- coverage thresholds where defined

## MCP Recommendation Workflow

MCP is an integration layer, not a replacement for deterministic scripts or CI.

When asked to recommend MCP servers:

1. read `.sdd/project/tech-stack.md` and/or `.sdd/project/tech-stack.yaml`
2. read the feature `spec.md` and `plan.md`
3. identify required external context/actions
4. consult `.sdd/mcp-registry.yaml`
5. prefer official/vendor-maintained servers where available
6. minimize permissions and use read-only mode for discovery/review where possible
7. do not add an MCP merely because it exists; map it to a real project capability

Typical mappings:

- GitHub → repository, issues, PRs, Actions, code security, releases
- Figma → design systems, components, variables, design-to-code context
- Linear → product/project/issue context if the team uses Linear
- Firebase → Firestore/backend debugging and project context when Firebase is in use
- Playwright → browser automation for web/admin portals; not a substitute for XCUITest
- Internal iOS build/simulator MCP → only when a trusted internal server is provided; otherwise prefer scripts such as `xcodebuild`, `xcrun simctl`, and CI

MCP recommendations must be recorded with rationale and permission scope, not embedded as hard dependencies in the core SDD workflow.

## Status Model

Project/feature status should use a controlled state machine.

Recommended feature states:

`DRAFT → READY → PLANNED → IN_PROGRESS → VALIDATING → CONVERGED → RELEASE_READY → RELEASED`

Exceptional states:

`BLOCKED | CANCELLED | SUPERSEDED`

A plan change on a `CONVERGED` or `RELEASE_READY` feature moves it back to `PLANNED` or `VALIDATING` based on the selected action.

## Reporting

`scripts/sdd-report` should produce a concise Tech Lead view:

- feature status
- requirements implemented/verified
- plan items verified
- test coverage/automation status
- CI status
- scope violations
- architecture findings
- open remediation tasks
- release readiness

## Safety / Security

Never place credentials, secrets, production tokens, or private customer data into SDD artifacts. MCP servers and agents must receive the minimum permissions needed. Prefer read-only integration during discovery and review.

## Definition of Done

A feature is done only when:

- requirements are complete
- acceptance criteria are satisfied
- plan items are executed and evidenced
- required tests exist and pass
- architecture rules pass
- scope is respected
- traceability is complete
- CI passes
- convergence reports no blocking gaps
- required human approvals are complete

## Agent Behavior Summary

Before coding:

```text
Read constitution
→ Read project context/tech stack
→ Read feature spec
→ Check plan change state
→ Clarify blockers
→ Analyze consistency
→ Build/refresh plan and tasks
```

During coding:

```text
Implement task
→ add/update tests
→ record evidence
→ run deterministic checks
→ update status
```

After coding:

```text
Execution-check
→ traceability
→ tests/CI
→ converge
→ report
→ human review
```

If `plan.md` changed:

```text
DETECT
→ IMPACT ANALYSIS
→ ASK IMPLEMENT / VALIDATE / REVIEW
→ execute selected lifecycle
→ converge
```
