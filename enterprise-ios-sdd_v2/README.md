# Enterprise iOS SDD Skill

Agent-agnostic Spec-Driven Development framework for enterprise iOS/tvOS projects.

## Core idea

The repository is the source of truth:

```text
Constitution
  ↓
Feature Spec
  ↓
Clarify
  ↓
Plan
  ↓
Tasks
  ↓
Implementation
  ↓
Execution Evidence
  ↓
Tests / CI
  ↓
Convergence
  ↓
Human Review
```

## Plan changes are lifecycle events

Editing a feature `plan.md` does not silently modify the implementation state.

Use:

```bash
./scripts/sdd-plan-change-check --feature FTR-023
```

The default behavior is to block and ask the user to choose:

- `implement` — reconcile the updated plan and run the full feature SDLC
- `validate` — validate the existing implementation against the updated plan
- `review` — analyze impact and update SDD artifacts without coding

## Project bootstrap

From a repository root, run the Skill bootstrap command to create/merge the canonical SDD structure:

```bash
/path/to/enterprise-ios-sdd/scripts/sdd-bootstrap
```

Then complete the project-level files, especially `tech-stack.md`, `tech-stack.yaml`, `constitution.md`, and `architecture.md`.

## Feature scaffold

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

## Tech stack

`.sdd/project/tech-stack.md` is the explanatory project stack document. `.sdd/project/tech-stack.yaml` is the optional machine-readable policy used by automation and MCP recommendations.

## MCP recommendations

`.sdd/mcp-registry.yaml` maps project capabilities and technologies to MCP integrations. Prefer vendor/official servers and least-privilege access.

## Main commands

```bash
make spec-check
make traceability
make execution-check
make validate
make status          # regenerate status counts and traceability
make test            # build and test as declared in .sdd/project/build.yaml
make ci-gate         # clear features only if all their test cases passed in that run
make ci              # validate, status-check, test, ci-gate
make report
```

Each project declares its own build in `.sdd/project/build.yaml` (`spm`, `xcodeproj`, or `xcworkspace`; scheme; iOS, tvOS, visionOS, watchOS simulator or macOS), so the same scripts work for any iOS project type.

## MCP recommendation

Use the project stack and feature plan to get advisory MCP recommendations:

```bash
./scripts/sdd-mcp-recommend
./scripts/sdd-mcp-recommend --feature FTR-023
```

The Skill never installs an MCP automatically. It recommends integrations and permission scopes based on the repository context.

## Package synchronization

Before distributing an updated version of this Skill, run:

```bash
./scripts/package-sync-check
```

This verifies the shipped templates, scripts, Skill contract, and HTML documentation cover the same canonical concepts.

## Recommended project automation order

```text
bootstrap → project context → feature spec → plan → tasks → implement → execution-check → test/CI → converge
```
