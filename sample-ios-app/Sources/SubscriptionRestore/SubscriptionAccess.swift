import Foundation

public enum SubscriptionAccess: Equatable, Sendable {
    case inactive
    case pending
    case active(expiresAt: Date?)
}

public enum RestoreError: Error, Equatable, Sendable {
    case networkUnavailable
    case storeUnavailable
}

public struct RestoreResult: Equatable, Sendable {
    public let access: SubscriptionAccess
    public let startedNewPurchase: Bool
    public let failure: RestoreError?

    public init(
        access: SubscriptionAccess,
        startedNewPurchase: Bool,
        failure: RestoreError? = nil
    ) {
        self.access = access
        self.startedNewPurchase = startedNewPurchase
        self.failure = failure
    }

    public var unlocksContent: Bool {
        if case .active = access, failure == nil {
            return true
        }
        return false
    }
}
