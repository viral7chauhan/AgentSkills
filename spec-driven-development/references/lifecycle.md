# Lifecycle: implement, validate, merge, replan, legacy, own workflow

## Implement
1. Re-read the feature's three spec files and `specs/tech-stack.md`.
2. Work through `plan.md` task group by group; commit in small steps on the phase branch.
3. If you hit an ambiguity the spec doesn't answer, stop and ask; then record the answer in `requirements.md` Decisions.
4. If the user changes scope mid-way, update `plan.md`, `requirements.md`, and `validation.md` first or together with the code, never after.
5. Run the checks in the Verify group before saying you are done.

## Validate
1. Execute every item in `validation.md`; report each as pass or fail with command output summarized.
2. Fix failures; do not edit validation to match broken behavior.
3. Review the diff for scope creep and for conflicts with `tech-stack.md`.
4. For larger changes, run an independent review: split the branch's changes across several reviewers (subagents if the harness supports them, otherwise sequential passes) each with a different lens, for example correctness and edge cases, consistency with the specs and conventions, and maintainability or test coverage. Triage findings with the user.
5. When validation reveals a missing standard (a test framework, responsive design, brand colors), put it in `tech-stack.md` or `mission.md`, then update existing specs and code to match.

## Merge
1. Update `CHANGELOG.md`: newest date first, one bullet per notable change (`git log --date=short --pretty='%ad %s'` is a good source; clean up wording).
2. Mark the phase complete in `specs/roadmap.md`.
3. Commit, switch to the main branch, merge, delete the phase branch. Ask before pushing or opening a PR if the team uses reviews.

## Replan
Do this after a phase, or when something changed:
- Re-read the roadmap against what was learned; combine tiny phases, split large ones, reorder, add missing phases.
- After an MVP-sized chunk, ask: "Did anything in the specs need clarification?" and fold the answers back into the constitution.
- Cross-cutting changes follow ground rule 4 in SKILL.md.
- Keep `TODO.md` as Now / Next lists if the user wants a lightweight inbox feeding the roadmap.

## Legacy: adopt SDD on an existing codebase
1. Read the code layout, README, build files, and TODO/issues to learn what exists.
2. Interview with the same three groups as the constitution (mission, audience, tech stack gaps), presenting what you inferred so the user corrects rather than invents.
3. Write `mission.md`, `tech-stack.md` (as-is, plus decisions the user wants), and `roadmap.md` derived from TODO/issues, in small phases. Mark already-built areas as complete.
4. Optionally write one retrospective spec for important existing behavior, only if the user wants it.
5. From here on, use the normal feature-spec flow.

## Own workflow
- When the user repeats a prompt (feature spec kickoff, changelog update, deep review), offer to save it as a reusable skill or command, and write it with the exact steps and required questions.
- Put unscheduled research (options, comparisons, links) in `backlog/YYYY-MM-DD-<topic>.md` and reference it from the roadmap when scheduled.
- Because specs are plain markdown in the repo, a different agent or tool can continue the work: keep project rules in the specs (and the agent's brief file, if any) rather than in chat history.
- Ask what in the codebase needs more tests as a periodic check, then add it as a roadmap phase.
