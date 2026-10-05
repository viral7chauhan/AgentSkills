# Skill Manifest

## Package root

- `SKILL.md` — reusable agent-agnostic SDD skill
- `README.md` — quick start
- `docs.html` — detailed human-readable reference
- `mcp-registry.yaml` — MCP capability/risk mapping and official source URLs
- `skill-manifest.md` — package synchronization contract
- `Makefile` — canonical command entry points
- `AGENTS.md` — thin agent adapter

## Templates

### Project

- `templates/project/constitution.md`
- `templates/project/objective.md`
- `templates/project/tech-stack.md`
- `templates/project/tech-stack.yaml`
- `templates/project/architecture.md`
- `templates/project/engineering-rules.md`
- `templates/project/security.md`
- `templates/project/performance.md`
- `templates/project/quality-gates.md`
- `templates/project/release.md`
- `templates/project/traceability.yaml`
- `templates/project/mcp-registry.yaml`

### Feature

- `templates/feature/spec.md`
- `templates/feature/clarify.md`
- `templates/feature/checklist.md`
- `templates/feature/plan.md`
- `templates/feature/tasks.md`
- `templates/feature/test-plan.md`
- `templates/feature/execution.yaml`
- `templates/feature/status.yaml`

### Quality / ADR

- `templates/quality/definition-of-ready.md`
- `templates/quality/definition-of-done.md`
- `templates/quality/execution-rules.md`
- `templates/quality/release-readiness.md`
- `templates/adr.md`

## Scripts

- `scripts/sdd-feature-create` — create a feature artifact set
- `scripts/sdd-plan-change-check` — detect plan changes and require lifecycle intent
- `scripts/sdd-execution-check` — validate plan execution evidence
- `scripts/sdd-trace` — inspect requirement/acceptance/plan/test linkage
- `scripts/sdd-validate` — validate project SDD structure and plan fingerprints
- `scripts/sdd-report` — produce a Tech Lead summary
- `scripts/sdd-mcp-recommend` — recommend MCPs from project tech-stack/feature context

## Agent adapters

- `agent/workflow.md`
- `agent/review-rules.md`

## CI templates

- `.github/workflows/sdd-validation.yml`
- `.github/workflows/release-readiness.yml`

## Examples

- `examples/project/.sdd/project/*` — sample project context
- `examples/project/.sdd/features/FTR-023-subscription-restore/*` — complete example feature
- `examples/project/.sdd/adr/ADR-001-example.md` — sample ADR
- `examples/project/.sdd/quality/*` — sample quality policy

## Synchronization contract

The following must stay synchronized:

1. `SKILL.md` describes every canonical workflow and artifact.
2. `docs.html` documents the same artifacts and workflow.
3. `templates/` contains every generated artifact shape.
4. `scripts/` references only shipped templates/paths.
5. `Makefile` references only shipped scripts.
6. `examples/` exercises the canonical artifact set.

When a canonical file is added or renamed, update all six areas before release. The plan-change lifecycle is part of the canonical workflow and must not be removed from one artifact while remaining in another.
