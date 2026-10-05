import Testing
@testable import SubscriptionRestore

@Suite
struct SubscriptionRepositoryTests {
    @Test
    func activeEntitlementUnlocksWithoutStartingAPurchase() async {
        let repository = SubscriptionRepository(
            restorer: FakeRestorer(result: .success(.active(expiresAt: nil)))
        )

        let result = await repository.restore()

        #expect(result.access == .active(expiresAt: nil))
        #expect(result.startedNewPurchase == false)
        #expect(result.failure == nil)
        #expect(result.unlocksContent)
    }

    @Test
    func pendingDoesNotUnlockOrStartAPurchase() async {
        let repository = SubscriptionRepository(
            restorer: FakeRestorer(result: .success(.pending))
        )

        let result = await repository.restore()

        #expect(result.access == .pending)
        #expect(result.startedNewPurchase == false)
        #expect(result.unlocksContent == false)
    }

    @Test
    func networkErrorDoesNotUnlockOrStartAPurchase() async {
        let repository = SubscriptionRepository(
            restorer: FakeRestorer(result: .failure(.networkUnavailable))
        )

        let result = await repository.restore()

        #expect(result.failure == .networkUnavailable)
        #expect(result.access == .inactive)
        #expect(result.startedNewPurchase == false)
        #expect(result.unlocksContent == false)
    }
}

private struct FakeRestorer: SubscriptionRestoring {
    var result: Result<SubscriptionAccess, RestoreError>

    func restorePurchases() async throws -> SubscriptionAccess {
        try result.get()
    }
}
