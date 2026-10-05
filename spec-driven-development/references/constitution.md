# Constitution: mission, tech stack, roadmap

Create these three files in `specs/` before any feature work.

## 1. Gather input
Read whatever the user points to: README, stakeholder notes, TODO.md, existing docs. Summarize in 3-5 lines what you understood.

## 2. Interview (required, before writing)
Ask exactly these three groups, together:

| Group | Ask about |
|---|---|
| Mission | What the product is for, what problem it solves, what success looks like |
| Audience | Who uses it, who maintains it, who decides, and what each needs |
| Tech stack | Language, framework, data store, testing, hosting/tooling; gaps or hard constraints. If the user has no preference, recommend one choice with a one-line reason |

Do not write files until all three are answered. Apply follow-up instructions ("add this audience", "we use X") by editing the files, not by rewriting from scratch.

## 3. Write the files

**mission.md**: Purpose; What we do; Who we serve; Target audience; What success looks like. Plain language, a page or less.

**tech-stack.md**: A table (Layer | Choice | Rationale) covering language, runtime/platform, framework, UI approach, data, testing, tooling. Then "What we are not using" (explicit exclusions prevent surprise dependencies). Record chosen versions or pinning rules here.

**roadmap.md**: Numbered phases, each a few bullets, ordered so every phase builds on the previous and ships something checkable. Keep phases small: if a phase needs more than one feature spec's worth of work, split it. Mark finished phases with a check (e.g. `✅`) or `[x]`. End with a short "later, not yet planned" list.

## 4. Confirm
Show the roadmap's phase list to the user and ask whether the order and size feel right before moving on.

## Adapting the tech-stack to the project type
- Web service: framework, templating, DB, test runner, formatter.
- Native iOS: Swift version and minimum iOS, UI framework (SwiftUI/UIKit), architecture (e.g. MVVM with Clean layers), DI approach, networking, persistence, test targets, build and test commands (`xcodebuild ... test`), linter.
- Include the exact commands that build, test, and lint; validation files will reuse them.
