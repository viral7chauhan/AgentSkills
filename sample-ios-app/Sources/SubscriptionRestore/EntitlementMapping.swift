import Foundation

public struct EntitlementSnapshot: Equatable, Sendable {
    public var hasActiveAutoRenewable: Bool
    public var expiresAt: Date?
    public var hasUnfinishedAutoRenewable: Bool

    public init(
        hasActiveAutoRenewable: Bool,
        expiresAt: Date? = nil,
        hasUnfinishedAutoRenewable: Bool = false
    ) {
        self.hasActiveAutoRenewable = hasActiveAutoRenewable
        self.expiresAt = expiresAt
        self.hasUnfinishedAutoRenewable = hasUnfinishedAutoRenewable
    }
}

public enum EntitlementMapping {
    /// Active auto-renewable entitlement wins over an unfinished transaction.
    /// Unfinished with no active entitlement is pending and must not unlock.
    public static func access(from snapshot: EntitlementSnapshot) -> SubscriptionAccess {
        if snapshot.hasActiveAutoRenewable {
            return .active(expiresAt: snapshot.expiresAt)
        }
        if snapshot.hasUnfinishedAutoRenewable {
            return .pending
        }
        return .inactive
    }
}
