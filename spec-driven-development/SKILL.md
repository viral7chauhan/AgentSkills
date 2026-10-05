---
name: spec-driven-development
description: >-
  Lightweight roadmap-driven SDD for repos that keep specs in `specs/` (mission.md, tech-stack.md, roadmap.md, dated `specs/YYYY-MM-DD-feature/` folders with requirements.md, plan.md, validation.md). Use when starting a `specs/` constitution, writing the spec for the next roadmap phase, implementing and validating a phase, replanning the roadmap, or adopting this layout on an existing codebase. Repos with `.sdd/` or FTR-### features use enterprise-ios-sdd.
---

# Spec-Driven Development (SDD)

The human owns intent and approval; the agent writes code. Intent lives in markdown specs inside the repo, so any agent or teammate can pick up the work and nothing depends on one chat session.

## Repo layout

```
specs/
  mission.md        # why the product exists, who it serves, what success is
  tech-stack.md     # chosen technologies, rationale, and what is NOT used
  roadmap.md        # ordered, very small phases (the constitution = these 3 files)
  YYYY-MM-DD-<feature>/
    requirements.md # scope, out of scope, decisions, context
    plan.md         # numbered task groups to implement
    validation.md   # how to know it works and can merge
TODO.md             # optional: Now / Next
backlog/            # optional: dated research notes not yet scheduled
CHANGELOG.md        # optional: dated bullets, updated before each merge
```

## Where is the user?

| Situation | Do this | Read |
|---|---|---|
| New project, no `specs/` | Build the constitution | `references/constitution.md` |
| Constitution exists, next phase unstarted | Write a feature spec | `references/feature-spec.md` |
| Feature spec approved | Implement, then validate and merge | `references/lifecycle.md` (Implement, Validate, Merge) |
| Scope or priorities changed, or an MVP just shipped | Replan | `references/lifecycle.md` (Replan) |
| Existing codebase with no specs | Adopt SDD | `references/lifecycle.md` (Legacy) |
| User repeats the same prompt | Turn it into a skill or command | `references/lifecycle.md` (Own workflow) |

If unclear, read `specs/roadmap.md` and `git status`/branch first, then state which stage you think the project is in and proceed.

## Ground rules

1. **Interview before writing.** Before creating any spec file, ask the user grouped questions (see the reference for the groups) and wait for answers. Use the harness's structured-question tool if it has one; otherwise ask all questions in one message. Never guess answers to skip this.
2. **Spec first, code second.** No implementation without an approved spec for that phase.
3. **Small phases.** Each roadmap phase is a slice that can be built, reviewed, tested, and shipped on its own.
4. **Specs and code stay in sync.** When a requirement changes mid-work, update the affected spec files and the code together. Cross-cutting changes (testing framework, responsive design, branding) go into `tech-stack.md`/`mission.md` first, then into every existing spec they touch, then into code.
5. **Validation is checkable.** Every item in `validation.md` is a command to run, an observable result, or a named manual check. "Looks good" is not a criterion.
6. **Respect the stack.** Add no dependency that `tech-stack.md` doesn't already allow without the user's approval. Pin versions where the spec says so.
7. **One phase, one branch.** Branch per phase, merge only when validation passes, delete the branch after merging.
8. **Don't weaken checks to pass.** Never delete or loosen a test or validation item to get green; surface the conflict and ask.

## Quick flow

1. Constitution → 2. Feature spec for next phase (branch + interview + 3 files) → 3. Implement task groups → 4. Validate (run checks, review) → 5. Update changelog, tick the roadmap phase, commit, merge, delete branch → 6. Replan when needed → repeat from 2.

At each step, report what changed in the specs and what is left, in a few lines.
