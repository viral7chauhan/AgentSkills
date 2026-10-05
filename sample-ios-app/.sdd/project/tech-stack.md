# Technology Stack

## Platform

- iOS 17 and later
- tvOS: not supported in this sample

## Language / Toolchain

- Swift 5.9
- Xcode 16 or later
- Swift Package Manager for domain unit tests
- Xcode project for the iOS app target

## UI

- Primary: SwiftUI
- Legacy / interoperability: none

## Architecture

- Style: Presentation → Domain, with a StoreKit adapter at the edge
- Dependency injection: constructor injection of `SubscriptionRestoring`

## Concurrency

- Preferred model: async/await
- View model isolated to the main actor

## Networking

- HTTP / transport: none directly. StoreKit performs the store sync.
- Client libraries: StoreKit 2

## Persistence

- Local storage: none. Entitlement state is read from StoreKit at restore time.
- Secure storage: none. Receipts are not stored by the app.

## Third-party SDKs

| Technology | Version | Purpose | Status | Constraint |
|---|---|---|---|---|
| None | — | — | — | Do not add a package without an ADR |

## Testing

- Unit: Swift Testing, via `swift test` and the app test target
- Integration: StoreKit adapter is compiled, not exercised against a live store in unit tests
- UI: SwiftUI view renders view-model state. No XCUITest in this sample.

## Quality

- Lint: not configured
- Format: not configured
- Static analysis: compiler warnings as errors are not enabled

## CI/CD

- Provider: not configured
- Distribution: local simulator build only

## Observability

- Crash/error monitoring: none
- Analytics: local result state only, no SDK
- Performance: none

## Remote Configuration / Feature Flags

- System: none

## Media / Playback

- Not applicable
