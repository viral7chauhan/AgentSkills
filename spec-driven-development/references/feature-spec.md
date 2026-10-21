# Feature spec for the next roadmap phase

## 1. Find the phase
Open `specs/roadmap.md`. The next phase is the first one not marked complete. Note its number and name.

## 2. Branch
`git checkout -b phase-<N>-<kebab-name>` (or the team's branch convention).

## 3. Read guidance
Read `specs/mission.md`, `specs/tech-stack.md`, and any earlier feature specs for patterns to reuse.

## 4. Interview (required, before writing)
Ask exactly three grouped questions:

| Group | Ask about |
|---|---|
| Scope | What the feature does or exposes: behavior, data shape, screens, endpoints |
| Decisions | Key choices: storage, validation, UX pattern, error handling, anything with trade-offs |
| Context | Constraints, tone, stakeholders, open questions, links to existing patterns |

Offer a sensible default option in each question where you can. Do not write files until all three are answered.

## 5. Create `specs/YYYY-MM-DD-<feature>/` (today's date)

### requirements.md
- **Scope**: what is included (a field/data table if useful)
- **Out of scope**: what is explicitly deferred, with the phase it belongs to if known
- **Decisions**: each choice and why, drawn from the interview
- **Context**: stack pointers, existing patterns to follow, stakeholder notes

### plan.md
- Numbered **task groups** (e.g. Data, Components, Route/Page, Navigation, Tests, Verify), each with numbered sub-tasks that are concrete enough to execute without further questions.
- Groups are independently implementable and ordered by dependency.
- Last group is always a **Verify** group that runs the checks from `validation.md`.

### validation.md
- **Definition of done**: everything that must be true before merging
- **Automated**: exact commands (build, typecheck, test, lint) and specific assertions required
- **Manual**: walkthrough steps and edge cases a person checks
- **Not required**: things intentionally skipped for this phase
- Any user-facing copy gets a tone check against `mission.md`

## 6. Review with the user
Summarize the three files in a few lines and ask for changes. Edit the spec files in place and keep all three consistent (e.g. adding a task group means updating requirements scope and validation too). Do not start implementing until the user approves.

## Constraints
- No new dependencies without approval; follow established patterns.
- Keep scope focused and independently shippable.
