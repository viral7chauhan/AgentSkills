import SwiftUI

struct RestorePurchasesView: View {
    @State private var model: SubscriptionViewModel

    init(model: SubscriptionViewModel) {
        _model = State(initialValue: model)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(model.statusMessage)
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("restore.status")

            if model.contentUnlocked {
                Text("Subscriber")
                    .font(.headline)
                    .accessibilityIdentifier("restore.subscriber")
            }

            Button("Restore Purchases") {
                Task { await model.restorePurchases() }
            }
            .buttonStyle(.borderedProminent)
            .disabled(model.state == .restoring)
            .accessibilityIdentifier("restore.button")
        }
        .padding()
    }
}
