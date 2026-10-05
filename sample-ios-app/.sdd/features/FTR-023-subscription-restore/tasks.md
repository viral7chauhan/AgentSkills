# Tasks

| Task ID | Plan Item | Description | State | Evidence |
|---|---|---|---|---|
| T-023-001 | P-023-001 | Add `SubscriptionRestoring` and `SubscriptionRepository` | IMPLEMENTED | `SubscriptionRepository.swift` |
| T-023-002 | P-023-002 | Add `EntitlementMapping` and `SubscriptionAccess` | IMPLEMENTED | `EntitlementMapping.swift` |
| T-023-003 | P-023-003 | Add `SubscriptionViewModel` outcome mapping | IMPLEMENTED | `SubscriptionViewModel.swift` |
| T-023-004 | P-023-004 | Add `StoreKitRestoreAdapter` in the app target | IMPLEMENTED | `App/StoreKitRestoreAdapter.swift` |
| T-023-005 | P-023-005 | Add Restore Purchases screen and app entry | IMPLEMENTED | `App/RestorePurchasesView.swift` |
| T-023-006 | P-023-001 | Unit tests for active restore without a new purchase | IMPLEMENTED | TC-023-001 |
| T-023-007 | P-023-002 | Unit tests for pending and active-wins mapping | IMPLEMENTED | TC-023-002, TC-023-004 |
| T-023-008 | P-023-003 | Unit tests for offline and subscriber view state | IMPLEMENTED | TC-023-003, TC-023-005 |

Task state stays `IMPLEMENTED`. On 2026-10-05 `swift test` passed the Swift Testing suites. Tasks are not `VERIFIED` because CI has not run. See `execution.yaml`.
