# Quality Gates

Gates for this sample:

- Domain unit tests pass via `swift test` (every PR, and every push to `main`)
- SDD structure, traceability, and execution evidence pass via `make validate` (every PR, and every push to `main`)
- Derived status counts, `traceability.yaml`, and the README table are current via `make status-check` and `make readme-check` (every PR, and every push to `main`)
- The iOS app target builds and its test action passes on a simulator via `make test` (every PR, and every push to `main`, after the checks above)
- `make ci-gate` reports every claimed feature `CLEARED`: each test case's target test passed in that run
- No new package dependencies

Workflow: `.github/workflows/sample-ios-app.yml`

Not gated yet:

- SwiftLint or SwiftFormat
- XCUITest
- A live StoreKit sandbox pass for `StoreKitRestoreAdapter`
