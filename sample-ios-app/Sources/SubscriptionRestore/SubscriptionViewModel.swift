import Foundation
import Observation

@MainActor
@Observable
public final class SubscriptionViewModel {
    public enum ViewState: Equatable, Sendable {
        case idle
        case restoring
        case subscriber
        case pending
        case noSubscription
        case offline
        case failed
    }

    public private(set) var state: ViewState = .idle
    private let repository: SubscriptionRepository

    public init(repository: SubscriptionRepository) {
        self.repository = repository
    }

    public func restorePurchases() async {
        state = .restoring
        let result = await repository.restore()
        state = Self.viewState(for: result)
    }

    public static func viewState(for result: RestoreResult) -> ViewState {
        if result.failure == .networkUnavailable {
            return .offline
        }
        if result.failure != nil {
            return .failed
        }
        switch result.access {
        case .active:
            return .subscriber
        case .pending:
            return .pending
        case .inactive:
            return .noSubscription
        }
    }

    public var statusMessage: String {
        switch state {
        case .idle:
            return "Restore purchases to recover an active subscription."
        case .restoring:
            return "Restoring…"
        case .subscriber:
            return "Subscription restored."
        case .pending:
            return "Purchase pending"
        case .noSubscription:
            return "No active subscription found."
        case .offline:
            return "No connection. Try again when you're back online."
        case .failed:
            return "The App Store could not be reached. Try again."
        }
    }

    public var contentUnlocked: Bool {
        state == .subscriber
    }
}
