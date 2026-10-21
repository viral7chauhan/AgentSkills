import Foundation

public struct SubscriptionRepository: Sendable {
    private let restorer: any SubscriptionRestoring

    public init(restorer: any SubscriptionRestoring) {
        self.restorer = restorer
    }

    /// Restore never starts a purchase. Callers unlock only when the result says so.
    public func restore() async -> RestoreResult {
        do {
            let access = try await restorer.restorePurchases()
            return RestoreResult(access: access, startedNewPurchase: false)
        } catch let error as RestoreError {
            return RestoreResult(access: .inactive, startedNewPurchase: false, failure: error)
        } catch {
            return RestoreResult(access: .inactive, startedNewPurchase: false, failure: .storeUnavailable)
        }
    }
}
