# Test Plan

| Test ID | Requirement | Acceptance | Type | Target Test | Expected Evidence | Status |
|---|---|---|---|---|---|---|
| TC-###-001 | FR-###-001 | AC-###-001 | Unit | TBD | Pass | Planned |

`Target Test` is the real test as `Suite/testName` (an XCTest class or Swift Testing suite, then the test function). `make ci-gate` matches it against the CI run's results; a feature is cleared only when every row's target test passed there. Set `Status` to `Pass` only after that.
