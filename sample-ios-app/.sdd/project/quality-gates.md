# Quality Gates

Gates for this sample:

- Domain unit tests pass via `swift test` (every push)
- SDD structure, traceability, and execution evidence pass via `make validate` (every push)
- Derived status counts, `traceability.yaml`, and the README table are current via `make status-check` and `make readme-check` (every push)
- The iOS app target builds and its test action passes on a simulator (pull requests, `main`, manual runs)
- No new package dependencies

Workflow: `.github/workflows/sample-ios-app.yml`

Not gated yet:

- SwiftLint or SwiftFormat
- XCUITest
- A live StoreKit sandbox pass for `StoreKitRestoreAdapter`
