# Implementation Plan

## Plan Metadata

- Feature: FTR-023
- Version: 2
- Status: Approved

## Technical Approach

Keep StoreKit at the edge. The domain maps an `EntitlementSnapshot` to `SubscriptionAccess`, and the view model maps a `RestoreResult` to copy and an unlock flag. Restore always returns `startedNewPurchase: false`.

## Architecture Impact

Adds a domain library and one app screen. No change to a paywall, because this sample has no purchase flow. See ADR-001.

## Modules / Components

- `Sources/SubscriptionRestore/` domain types, repository, mapping, view model
- `App/StoreKitRestoreAdapter.swift` StoreKit 2 sync and snapshot
- `App/RestorePurchasesView.swift` screen
- `Tests/SubscriptionRestoreTests/` unit tests

## Plan Items

### P-023-001

- Requirements: FR-023-001, NFR-023-001
- Description: Add `SubscriptionRestoring` and `SubscriptionRepository`. Restore delegates to the restorer and never starts a purchase.
- Expected implementation areas: `Sources/SubscriptionRestore/SubscriptionRestoring.swift`, `Sources/SubscriptionRestore/SubscriptionRepository.swift`
- Expected validation: TC-023-001

### P-023-002

- Requirements: FR-023-001, FR-023-002
- Description: Map an entitlement snapshot to inactive, pending, or active. An active auto-renewable entitlement wins over an unfinished transaction.
- Expected implementation areas: `Sources/SubscriptionRestore/EntitlementMapping.swift`, `Sources/SubscriptionRestore/SubscriptionAccess.swift`
- Expected validation: TC-023-002, TC-023-004

### P-023-003

- Requirements: FR-023-001, FR-023-002, FR-023-003
- Description: Map restore results to subscriber, pending, empty, and offline view state. Unlock content only for subscriber.
- Expected implementation areas: `Sources/SubscriptionRestore/SubscriptionViewModel.swift`
- Expected validation: TC-023-003, TC-023-005

### P-023-004

- Requirements: FR-023-001, FR-023-003
- Description: Add `StoreKitRestoreAdapter`. Sync the App Store, build an `EntitlementSnapshot` from current auto-renewable entitlements and unfinished transactions, and map network failures to `RestoreError.networkUnavailable`.
- Expected implementation areas: `App/StoreKitRestoreAdapter.swift`
- Expected validation: decision table covered by TC-023-002 and TC-023-004. The adapter is not called against a live store in unit tests.

### P-023-005

- Requirements: FR-023-001
- Description: Add a SwiftUI screen with a Restore Purchases button that calls the view model and renders `statusMessage`. Disable the button while restoring.
- Expected implementation areas: `App/RestorePurchasesView.swift`, `App/SubscriptionRestoreApp.swift`
- Expected validation: the view has no branching beyond the view model. Copy and unlock behavior are asserted by TC-023-005.

## Scope

```yaml
allowed_paths:
  - "App/**"
  - "Sources/SubscriptionRestore/**"
  - "Tests/SubscriptionRestoreTests/**"
forbidden_paths: []
allowed_dependencies: []
```

## Data / Control Flow

```text
Button tap
  → SubscriptionViewModel.restorePurchases()
  → SubscriptionRepository.restore()
  → SubscriptionRestoring.restorePurchases()
  → EntitlementMapping.access(from:)
  → ViewState
```

The adapter path replaces the fake restorer only in the app target.

## Error Handling

`URLError` from `AppStore.sync()` becomes `RestoreError.networkUnavailable`. Other thrown errors become `RestoreError.storeUnavailable`. The repository catches both and returns a failed `RestoreResult` with `access: inactive`.

## Concurrency

`restorePurchases()` is async. The view model is `@MainActor`. The button is disabled while state is `.restoring`.

## Dependencies

StoreKit, already on the iOS SDK. No package additions.

## Testing Strategy

Swift Testing (`import Testing`, `@Test`, `#expect`) with a fake `SubscriptionRestoring` and hand-built `EntitlementSnapshot` values. No StoreKit configuration file in this sample. `Package.swift` uses tools version 6.0 so `swift test` runs Swift Testing.

## Observability

No analytics SDK. `ViewState` is the only outcome surface.

## Migration / Rollback

No stored data to migrate. Reverting the feature removes the screen and the domain types.

## Risks

- `Transaction.unfinished` is the sample's signal for pending. A real paywall's `.pending` purchase result is out of scope because this feature does not purchase.
- The adapter is compiled but not unit tested against StoreKit. A sandbox UI pass is still required before release.
