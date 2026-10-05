# Enterprise iOS SDD Skill

This package provides an agent-agnostic Spec-Driven Development (SDD) workflow for enterprise iOS/tvOS projects.

Start with `docs.html` for the human-readable guide.

## Included

- `SKILL.md` — reusable skill definition and workflow rules
- `docs.html` — visual reference for every project/feature file and examples
- `README.md` — quick reference

## Recommended repository shape

```text
.sdd/
  constitution.md
  project/
  features/
  adr/
  traceability.yaml
agent/
scripts/
AGENTS.md
Makefile
.github/workflows/
```

## Core workflow

```text
constitution
  → specify
  → clarify
  → plan
  → checklist
  → tasks
  → analyze
  → implement
  → test/CI
  → converge
```

The repository remains the source of truth; the coding agent is replaceable.

## Reference documentation

- GitHub Spec Kit: https://github.com/github/spec-kit
- GitHub Spec Kit Quickstart: https://github.com/github/spec-kit/blob/main/docs/quickstart.md
- GitHub Agentic SDD reference: https://github.com/github/spec-kit/blob/main/docs/reference/agentic-sdd.md
- GitHub convergence command: https://github.com/github/spec-kit/blob/main/templates/commands/converge.md
- GitHub Spec of Specs: https://github.com/github/spec-kit/blob/main/docs/concepts/spec-of-specs.md
- OpenAI Agent Skills: https://developers.openai.com/api/docs/guides/tools-skills
- OpenAI Build Skills: https://developers.openai.com/plugins/build/skills
- GitHub Copilot Agent Skills: https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills
- GitHub Custom Agents: https://docs.github.com/en/copilot/how-tos/copilot-in-the-ide/use-copilot-agents/use-custom-agents

## Executable feature scaffolding

The package now includes feature templates and a scaffold command:

```bash
./scripts/sdd-feature-create "Subscription Restore"
```

or:

```bash
./scripts/sdd-feature-create FTR-023 "Subscription Restore"
```

This creates the standard seven feature artifacts under `.sdd/features/`. The command is intentionally limited to scaffolding; it does not invent requirements or modify application code.
