import Foundation
import StoreKit

struct StoreKitRestoreAdapter: SubscriptionRestoring {
    func restorePurchases() async throws -> SubscriptionAccess {
        do {
            try await AppStore.sync()
        } catch is URLError {
            throw RestoreError.networkUnavailable
        } catch {
            throw RestoreError.storeUnavailable
        }

        let snapshot = await Self.snapshotFromStore()
        return EntitlementMapping.access(from: snapshot)
    }

    static func snapshotFromStore() async -> EntitlementSnapshot {
        var hasActive = false
        var expiresAt: Date?
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            guard transaction.productType == .autoRenewable else { continue }
            guard transaction.revocationDate == nil else { continue }
            hasActive = true
            expiresAt = transaction.expirationDate
            break
        }

        var hasUnfinished = false
        for await result in Transaction.unfinished {
            guard case .verified(let transaction) = result else { continue }
            guard transaction.productType == .autoRenewable else { continue }
            hasUnfinished = true
            break
        }

        return EntitlementSnapshot(
            hasActiveAutoRenewable: hasActive,
            expiresAt: expiresAt,
            hasUnfinishedAutoRenewable: hasUnfinished
        )
    }
}
