# Agent Workflow Adapter

The agent must treat `.sdd/` as the source of truth.

## Before editing code

1. Read `.sdd/constitution.md`.
2. Read `.sdd/project/*` relevant to the task.
3. Read the target feature artifacts.
4. Run plan-change detection.
5. If plan change requires user choice, ask before implementation.
6. Run consistency analysis.

## During implementation

- Follow tasks in `tasks.md`.
- Update `execution.yaml` evidence.
- Add/update tests.
- Avoid unrelated changes.

## After implementation

Run:

```bash
make execution-check
make traceability
make validate
```

Then perform convergence and produce the report.
