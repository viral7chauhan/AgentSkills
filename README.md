# AgentSkills

Agent skills for **Spec-Driven Development (SDD)** on enterprise iOS/tvOS projects.

The repository is the source of truth. Coding agents are interchangeable execution layers — they draft, implement, and validate against specs, constitution, tests, and CI evidence, without inventing product requirements or silently changing architecture.

## What's in this repo

| Package | Status | Description |
| --- | --- | --- |
| [`enterprise-ios-sdd_v2/`](enterprise-ios-sdd_v2/) | **Recommended** | Full SDD skill: project bootstrap, feature lifecycle, plan-change handling, MCP recommendations, validation scripts, and CI workflows |
| [`enterprise-ios-sdd/`](enterprise-ios-sdd/) | Earlier package | Core SDD skill, feature scaffolding, templates, and docs |

Prefer **v2** for new work. It extends the original package with bootstrap, execution evidence, plan-change checks, package sync, MCP registry recommendations, and GitHub Actions workflows.

For a full walkthrough of the lifecycle, repository layout, feature artifacts, traceability, MCP recommendations, and Tech Lead workflow, see **[GUIDE.md](GUIDE.md)**.

## Core workflow

```text
Constitution
  → Feature Spec
  → Clarify
  → Plan
  → Tasks
  → Implementation
  → Execution Evidence
  → Tests / CI
  → Convergence
  → Human Review
```

A feature is **converged** only when requirements, plan items, tasks, tests, and quality gates are satisfied with real evidence — not agent checkboxes alone.

## Quick start (v2)

1. Point an agent (or yourself) at `enterprise-ios-sdd_v2/SKILL.md`.
2. Bootstrap SDD structure into a target iOS/tvOS repo:

```bash
/path/to/enterprise-ios-sdd_v2/scripts/sdd-bootstrap
```

3. Fill in project context — especially `tech-stack.md`, `tech-stack.yaml`, `constitution.md`, and `architecture.md`.
4. Scaffold a feature:

```bash
./scripts/sdd-feature-create FTR-023 "Subscription Restore"
```

5. Run validation as you work:

```bash
make validate
make execution-check
make report
```

Human-readable guide: [`enterprise-ios-sdd_v2/docs.html`](enterprise-ios-sdd_v2/docs.html)

## Package layout (v2)

```text
enterprise-ios-sdd_v2/
├── SKILL.md              # Agent skill contract and workflow rules
├── README.md             # Package quick reference
├── docs.html             # Detailed human-readable guide
├── AGENTS.md             # Thin agent adapter
├── Makefile              # Canonical command entry points
├── mcp-registry.yaml     # MCP capability / risk mapping
├── scripts/              # Bootstrap, validate, trace, report, …
├── templates/            # Project, feature, quality, and ADR templates
├── examples/             # Sample .sdd/ project and feature
└── .github/workflows/    # SDD validation and release-readiness CI
```

## Principles

1. Specification is the source of intent.
2. Constitution and architecture rules are binding unless explicitly changed.
3. Requirements must trace to acceptance criteria, plan, tasks, code, tests, and CI.
4. `IMPLEMENTED` is not the same as `VERIFIED`.
5. Do not invent product requirements or change architecture silently.
6. Plan changes are lifecycle events — they must not be applied silently.

## Documentation

- [GUIDE.md](GUIDE.md) — detailed SDD framework guide
- [enterprise-ios-sdd_v2/docs.html](enterprise-ios-sdd_v2/docs.html) — visual reference for files and workflow stages
- [enterprise-ios-sdd_v2/SKILL.md](enterprise-ios-sdd_v2/SKILL.md) — agent skill contract

## References

- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Agentic SDD reference](https://github.com/github/spec-kit/blob/main/docs/reference/agentic-sdd.md)
- [OpenAI Agent Skills](https://developers.openai.com/api/docs/guides/tools-skills)
- [GitHub Copilot Agent Skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
