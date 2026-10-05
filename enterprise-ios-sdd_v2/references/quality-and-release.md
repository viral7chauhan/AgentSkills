# Quality gates, ADRs, reporting, and release

## CI quality gates

Expose every gate as a `Makefile` target and have CI call the same targets, so local and CI results agree:

```bash
make validate        # SDD structure, plan fingerprints, traceability, execution evidence
make status-check    # derived status counts and traceability are current
make test            # build and test as declared in .sdd/project/build.yaml
make ci-gate         # every claimed feature's test cases passed in this run
make lint
```

`make ci` runs the first four in order. The package's `.github/workflows/sdd-validation.yml` template runs them on every pull request and push to the default branch, with the gate reporting even when tests fail so the log names the uncleared features.

Choose the gates the project enforces from: build, unit tests, integration tests, UI tests where required, lint/format, architecture and static checks, secrets scan, dependency audit, and coverage thresholds. Record the chosen set in `.sdd/project/quality-gates.md`; a gate listed there is a merge blocker.

## ADRs

Write `.sdd/adr/ADR-###-title.md` from `templates/adr.md` for a decision that constrains future work: architecture boundaries, dependency choices, cross-cutting patterns. Include context, decision, alternatives considered, consequences, status, and related features. Implementation details that constrain nothing stay in `plan.md`.

## Reporting

`make report` prints one line per feature. `scripts/sdd-report --update-readme README.md` writes a status table between `<!-- sdd-report:start -->` and `<!-- sdd-report:end -->`; `--check-readme` fails when that table is stale, so CI can keep a team-lead README honest.

The Tech Lead view should answer: feature status, requirements implemented and verified, plan items verified, test automation status, CI status, scope violations, architecture findings, open remediation tasks, and release readiness.

## Definition of Done

A feature is done when: requirements are complete, acceptance criteria are satisfied, plan items are executed and evidenced, required tests exist and pass, architecture and scope checks pass, traceability is complete, CI passes, convergence reports no blocking gaps, and required human approvals are recorded.

## Release readiness

`RELEASE_READY` additionally needs: every release-scoped feature `CONVERGED`, required tests and CI green, security and dependency checks passed, release notes and known issues reviewed, and a rollout and rollback plan. `.github/workflows/release-readiness.yml` is the CI template for this gate.
