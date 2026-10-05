# AGENTS.md

This repository follows Enterprise iOS SDD.

Read `.sdd/constitution.md` and the relevant `.sdd/project/*` files before making changes.

For a feature, read its `spec.md`, `clarify.md`, `plan.md`, `tasks.md`, `test-plan.md`, `execution.yaml`, and `status.yaml`.

If `plan.md` is newly added or changed, run:

```bash
./scripts/sdd-plan-change-check --feature FTR-###
```

Do not silently continue after a plan change. Ask whether the user wants:

1. full implementation/reconciliation
2. validation only
3. review/impact analysis only

Use deterministic commands for evidence. Do not claim CI or test success without actual execution results.
