---
name: enterprise-ios-sdd
description: Evidence-gated spec-driven workflow for any Apple-platform app repo (iOS, iPadOS, tvOS, visionOS, watchOS, macOS; SwiftPM, Xcode project, or workspace) that keeps specs in `.sdd/` (constitution, `.sdd/features/FTR-###`, `execution.yaml`). Use when bootstrapping `.sdd/`, writing or changing a feature spec or `plan.md`, implementing against an FTR feature, recording execution evidence, checking traceability or convergence, or wiring SDD test gates into CI.
---

# Enterprise iOS Spec-Driven Development

The repository is the source of truth; the agent is an interchangeable execution layer. Project rules live in `.sdd/`, feature intent in `.sdd/features/FTR-###-name/`, and deterministic scripts plus CI decide whether work is done.

`IMPLEMENTED ≠ VERIFIED ≠ CONVERGED`. A checkbox is a claim; evidence comes from code, tests, static checks, and CI.

**Project isolation.** Every project fact lives in that repo: rules and features in `.sdd/`, and how it builds and tests in `.sdd/project/build.yaml`. `sdd-bootstrap` copies the scripts into the repo, so each project runs its own pinned copy and this skill carries no project-specific knowledge. When a fact about the app is needed, read it from the repo's `.sdd/`; when it is missing, ask and record it there.

## Before any change

1. Read `.sdd/constitution.md` and the `.sdd/project/*` files the change touches.
2. For feature work, read the feature's `spec.md`, `clarify.md`, `plan.md`, `tasks.md`, `test-plan.md`, `execution.yaml`, and `status.yaml`.
3. Run `./scripts/sdd-plan-change-check --feature FTR-###`. On `PLAN_CHANGED`, follow the Plan Change Trigger below before anything else.

## Authority

- **Agent**: drafts specs and plans, implements approved tasks, runs checks, records evidence, prepares review packages.
- **Scripts and CI**: decide artifact presence, traceability, execution evidence, build, tests, lint.
- **Human**: product ambiguity, architecture/security/dependency exceptions, breaking changes, release exceptions, and the lifecycle action after a plan change.

Requirements, architecture, quality gates, and status move only through that path: invented requirements, silent architecture changes, weakened gates, and self-declared convergence are out of bounds. Secrets and customer data never go into SDD artifacts.

## Feature lifecycle

Create a feature with `./scripts/sdd-feature-create FTR-### "Name"`, then fill each template in order. Each step is done when its criterion holds.

| Step | File | Done when |
| --- | --- | --- |
| Specify | `spec.md` | Problem, scope, non-goals, `FR-*`/`NFR-*`, testable `AC-*`, edge cases filled |
| Clarify | `clarify.md` | No blocking question is `OPEN` (`OPEN \| DECIDED \| REJECTED \| NOT_APPLICABLE`) |
| Ready | `checklist.md` | Every readiness item checked |
| Plan | `plan.md` | Every `P-*` lists its `FR`/`NFR` IDs; `allowed_paths`/`forbidden_paths` declared |
| Tasks | `tasks.md` | Every `T-*` names its `P-*` |
| Test plan | `test-plan.md` | Every `FR`/`NFR` has a `TC-*` whose `Target Test` names a real test as `Suite/testName` |
| Analyze | — | Spec ↔ plan ↔ tasks ↔ tests ↔ scope ↔ tech stack agree; gaps fixed or recorded |
| Implement | code + tests | Only approved tasks, inside `allowed_paths`, with tests |
| Evidence | `execution.yaml` | Each plan item's evidence flags set from real command or CI output |
| CI clearance | CI run | `make test` passes and `make ci-gate` reports the feature `CLEARED` |
| Converge | `status.yaml` | `make validate` and `make status-check` pass on that same green CI run |
| Review | — | A human approves; the agent never self-approves this gate |

## Plan Change Trigger — mandatory

Any edit to `.sdd/features/**/plan.md` (added, modified, plan items or expected files changed, scope or architecture changed) invalidates prior verification. Then:

1. Treat the feature as no longer converged; run impact analysis against the previous plan in git.
2. Ask one question: *Plan changed for FTR-###. Implement (reconcile and run the full lifecycle), Validate (check current code against the new plan, no code changes), or Review (update artifacts only)?*
3. Run `./scripts/sdd-plan-change-check --feature FTR-### --mode implement|validate|review`, record the new fingerprint, and re-run the lifecycle from the matching step.

Default mode is `ask`, which exits non-zero so automation cannot continue on stale evidence. A `review`-only change cannot be `CONVERGED`.

## Evidence and status

A plan item in `execution.yaml` is `VERIFIED` only when all of these are `true`: `code_exists`, `implementation_verified`, `tests_exist`, `tests_passed`, `architecture_passed`, `scope_passed`, `ci_passed`. Local runs may set `tests_passed`; only a CI run sets `ci_passed`.

**Cleared by CI.** In CI, `make test` (`scripts/sdd-test`) runs the build declared in `build.yaml` and records every test result; `make ci-gate` (`scripts/sdd-ci-gate`) then checks each feature. A feature that claims verification (`CONVERGED` or later, any `VERIFIED` plan item, or any `Pass` in its test plan) is `CLEARED` only when every test case's target test passed in that run; a failed, skipped, or missing test fails CI and names the test case. Set `ci_passed: true` and record the run in `traceability.yaml` `ci_runs` only after the gate cleared the feature. Required status checks on the default branch must include this job.

Feature states: `DRAFT → READY → PLANNED → IN_PROGRESS → VALIDATING → CONVERGED → RELEASE_READY → RELEASED`, plus `BLOCKED | CANCELLED | SUPERSEDED`. A plan change moves `CONVERGED` or `RELEASE_READY` back to `PLANNED` or `VALIDATING`.

Edit source facts only: `spec.md`, `plan.md`, `tasks.md` states, `test-plan.md` results, and `execution.yaml` evidence. `./scripts/sdd-status` derives the counts in `status.yaml` and all of `.sdd/traceability.yaml` (canonical chain `FR/NFR → AC → P → T → TC → CI`) except the hand-kept `ci_runs` and `prs`. Run `make status` after changing a source file. The hand-set `status.yaml` fields are `status`, `ci_status`, `release_ready`, `blocking_items`, and the validation dates.

## Scope

Stay inside the plan's `allowed_paths` and `allowed_dependencies`. Touching anything else is a scope change: update `plan.md` first, which fires the Plan Change Trigger.

## Commands

| Command | Purpose |
| --- | --- |
| `make validate` | Structure, plan fingerprints, traceability, execution evidence |
| `make execution-check [FEATURE=FTR-###]` | Every plan item `VERIFIED` with all evidence true |
| `make status` / `make status-check` | Regenerate / verify derived status counts and traceability |
| `make test` | Build and test as declared in `.sdd/project/build.yaml`; writes per-test results |
| `make ci-gate` | Clear each claimed feature only if all its test cases passed in that run |
| `make ci` | `validate`, `status-check`, `test`, `ci-gate` in order: the CI entry point |
| `make report` | One status line per feature |
| `make plan-change FEATURE=FTR-### MODE=…` | Plan-change detection with an explicit lifecycle action |

## References

Read only the one the task needs:

- `references/setup.md` — bootstrapping a repo with `./scripts/sdd-bootstrap`, the canonical `.sdd/` layout, filling `tech-stack.md`/`tech-stack.yaml`, and `build.yaml` for each project type (SwiftPM, Xcode project, workspace/CocoaPods, tvOS, macOS).
- `references/mcp.md` — recommending MCP servers with `./scripts/sdd-mcp-recommend` and `.sdd/mcp-registry.yaml`.
- `references/quality-and-release.md` — CI quality gates, ADRs, reporting, Definition of Done, and release readiness.
