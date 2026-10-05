import Foundation
import Testing
@testable import SubscriptionRestore

@Suite
struct EntitlementMappingTests {
    @Test
    func unfinishedTransactionWithoutActiveEntitlementIsPending() {
        let access = EntitlementMapping.access(
            from: EntitlementSnapshot(
                hasActiveAutoRenewable: false,
                hasUnfinishedAutoRenewable: true
            )
        )

        #expect(access == .pending)
        #expect(
            RestoreResult(access: access, startedNewPurchase: false).unlocksContent == false
        )
    }

    @Test
    func activeEntitlementWinsOverUnfinishedTransaction() {
        let expiry = Date(timeIntervalSince1970: 1_700_000_000)
        let access = EntitlementMapping.access(
            from: EntitlementSnapshot(
                hasActiveAutoRenewable: true,
                expiresAt: expiry,
                hasUnfinishedAutoRenewable: true
            )
        )

        #expect(access == .active(expiresAt: expiry))
    }

    @Test
    func noEntitlementIsInactive() {
        let access = EntitlementMapping.access(
            from: EntitlementSnapshot(hasActiveAutoRenewable: false)
        )

        #expect(access == .inactive)
    }
}
