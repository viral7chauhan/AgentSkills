import Testing
@testable import SubscriptionRestore

@MainActor
@Suite
struct SubscriptionViewModelTests {
    @Test
    func activeRestoreShowsSubscriberAndUnlocks() async {
        let model = SubscriptionViewModel(
            repository: SubscriptionRepository(
                restorer: FakeRestorer(result: .success(.active(expiresAt: nil)))
            )
        )

        await model.restorePurchases()

        #expect(model.state == .subscriber)
        #expect(model.statusMessage == "Subscription restored.")
        #expect(model.contentUnlocked)
    }

    @Test
    func pendingShowsPurchasePendingAndStaysLocked() async {
        let model = SubscriptionViewModel(
            repository: SubscriptionRepository(
                restorer: FakeRestorer(result: .success(.pending))
            )
        )

        await model.restorePurchases()

        #expect(model.state == .pending)
        #expect(model.statusMessage == "Purchase pending")
        #expect(model.contentUnlocked == false)
    }

    @Test
    func networkFailureStaysLockedAndShowsOfflineCopy() async {
        let model = SubscriptionViewModel(
            repository: SubscriptionRepository(
                restorer: FakeRestorer(result: .failure(.networkUnavailable))
            )
        )

        await model.restorePurchases()

        #expect(model.state == .offline)
        #expect(
            model.statusMessage == "No connection. Try again when you're back online."
        )
        #expect(model.contentUnlocked == false)
    }

    @Test
    func emptyEntitlementStaysLocked() async {
        let model = SubscriptionViewModel(
            repository: SubscriptionRepository(
                restorer: FakeRestorer(result: .success(.inactive))
            )
        )

        await model.restorePurchases()

        #expect(model.state == .noSubscription)
        #expect(model.statusMessage == "No active subscription found.")
        #expect(model.contentUnlocked == false)
    }
}

private struct FakeRestorer: SubscriptionRestoring {
    var result: Result<SubscriptionAccess, RestoreError>

    func restorePurchases() async throws -> SubscriptionAccess {
        try result.get()
    }
}
