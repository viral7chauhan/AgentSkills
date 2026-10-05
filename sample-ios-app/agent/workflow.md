# Agent workflow

1. Read `.sdd/constitution.md` and the project files the change touches.
2. Read the feature artifacts for the task.
3. If `plan.md` changed, stop and ask: implement, validate, or review.
4. Implement only the tasks in `tasks.md`, inside `allowed_paths`.
5. Update `execution.yaml` from real test output.
6. Run `make unit-test`, then `make test` and `make ci-gate`.
