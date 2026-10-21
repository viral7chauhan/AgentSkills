import Foundation

public protocol SubscriptionRestoring: Sendable {
    func restorePurchases() async throws -> SubscriptionAccess
}
