# Tasks

| Task ID | Plan Item | Description | State | Evidence |
|---|---|---|---|---|
| T-023-001 | P-023-001 | Add `SubscriptionRestoring` and `SubscriptionRepository` | VERIFIED | `SubscriptionRepository.swift` |
| T-023-002 | P-023-002 | Add `EntitlementMapping` and `SubscriptionAccess` | VERIFIED | `EntitlementMapping.swift` |
| T-023-003 | P-023-003 | Add `SubscriptionViewModel` outcome mapping | VERIFIED | `SubscriptionViewModel.swift` |
| T-023-004 | P-023-004 | Add `StoreKitRestoreAdapter` in the app target | VERIFIED | `App/StoreKitRestoreAdapter.swift` |
| T-023-005 | P-023-005 | Add Restore Purchases screen and app entry | VERIFIED | `App/RestorePurchasesView.swift` |
| T-023-006 | P-023-001 | Unit tests for active restore without a new purchase | VERIFIED | TC-023-001 |
| T-023-007 | P-023-002 | Unit tests for pending and active-wins mapping | VERIFIED | TC-023-002, TC-023-004 |
| T-023-008 | P-023-003 | Unit tests for offline and subscriber view state | VERIFIED | TC-023-003, TC-023-005 |

Tasks are `VERIFIED` from `swift test` plus GitHub Actions run 37343683468. `release_ready` stays false: there is no live StoreKit sandbox pass and no release rollout.
