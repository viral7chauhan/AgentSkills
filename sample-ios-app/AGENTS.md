# AGENTS.md

This app follows Enterprise iOS Spec-Driven Development.

Before changing code, read:

1. `.sdd/constitution.md`
2. `.sdd/project/architecture.md`
3. `.sdd/project/tech-stack.md`
4. The feature folder under `.sdd/features/`

For Subscription Restore, read `spec.md`, `clarify.md`, `plan.md`, `tasks.md`, `test-plan.md`, `execution.yaml`, and `status.yaml`.

Do not invent product behavior. Open questions belong in `clarify.md` until a human marks them `DECIDED`.

Stay inside the feature plan `allowed_paths`. A plan change is a lifecycle event: stop and ask whether to implement, validate, or review.

`IMPLEMENTED` is not `VERIFIED`. Record evidence from `make unit-test` or `make test`. A feature is verified only when CI's `make ci-gate` reports it `CLEARED`; set `ci_passed: true` only from such a run.

Edit only source facts: task states, test results, and `execution.yaml` evidence. Then run `make readme`, which regenerates the `status.yaml` counts, `.sdd/traceability.yaml`, and the README status table.
