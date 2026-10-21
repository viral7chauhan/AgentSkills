import SwiftUI

@main
struct SubscriptionRestoreApp: App {
    var body: some Scene {
        WindowGroup {
            RestorePurchasesView(
                model: SubscriptionViewModel(
                    repository: SubscriptionRepository(restorer: StoreKitRestoreAdapter())
                )
            )
        }
    }
}
