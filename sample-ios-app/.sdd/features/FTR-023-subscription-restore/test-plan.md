# Test Plan

| Test ID | Requirement | Acceptance | Type | Target Test | Expected Evidence | Status |
|---|---|---|---|---|---|---|
| TC-023-001 | FR-023-001, NFR-023-001 | AC-023-001 | Unit | `SubscriptionRepositoryTests/activeEntitlementUnlocksWithoutStartingAPurchase` | Pass | Pass |
| TC-023-002 | FR-023-002 | AC-023-002 | Unit | `EntitlementMappingTests/unfinishedTransactionWithoutActiveEntitlementIsPending` | Pass | Pass |
| TC-023-003 | FR-023-003 | AC-023-003 | Unit | `SubscriptionViewModelTests/networkFailureStaysLockedAndShowsOfflineCopy` | Pass | Pass |
| TC-023-004 | FR-023-001 | AC-023-001 | Unit | `EntitlementMappingTests/activeEntitlementWinsOverUnfinishedTransaction` | Pass | Pass |
| TC-023-005 | FR-023-001, FR-023-002 | AC-023-001, AC-023-002 | Unit | `SubscriptionViewModelTests/activeRestoreShowsSubscriberAndUnlocks` | Pass | Pass |

UI: `RestorePurchasesView` renders `statusMessage` and disables the button while `.restoring`. There is no XCUITest in this sample. Sandbox confirmation of `StoreKitRestoreAdapter` is still outstanding.

Tests use Swift Testing (`@Test`, `#expect`), not XCTest.
