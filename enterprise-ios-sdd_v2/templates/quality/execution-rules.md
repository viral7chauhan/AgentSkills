# Execution Rules

1. `IMPLEMENTED` is not completion evidence.
2. A task becomes `VERIFIED` only after required evidence exists.
3. A changed plan must invalidate prior convergence assumptions.
4. Plan changes require `implement`, `validate`, or `review` intent.
5. CI results must be real execution evidence.
6. Scope expansion must be explicit.
7. A feature is verified only when `make ci-gate` reports it `CLEARED` in CI: every test case's target test passed in that run.
