# Quality Gates

Gates for this sample:

- Domain unit tests pass via `swift test`
- The iOS app target builds and its test action passes on a simulator via GitHub Actions
- Feature artifacts exist for FTR-023 and requirement IDs trace to tests
- Execution evidence matches the last local test run
- No new package dependencies

Workflow: `.github/workflows/sample-ios-app.yml`

Not gated yet:

- SwiftLint or SwiftFormat
- XCUITest
- A live StoreKit sandbox pass for `StoreKitRestoreAdapter`
