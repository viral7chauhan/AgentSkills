# Quality Gates

Gates for this sample:

- Domain unit tests pass via `swift test`
- The iOS app target builds with `xcodebuild`
- Feature artifacts exist for FTR-023 and requirement IDs trace to tests
- Execution evidence matches the last local test run
- No new package dependencies

Not gated yet:

- GitHub Actions or Xcode Cloud
- SwiftLint or SwiftFormat
- XCUITest
