# Engineering Rules

## General

- No speculative product behavior. If the spec is silent, add a clarification instead of choosing a behavior in code.
- Keep changes inside the feature `allowed_paths`.
- Prefer the existing repository and mapping types before adding a new one.

## Swift

- Swift 5.9, iOS 17.
- New asynchronous work uses async/await.
- The view model is `@MainActor`.

## Testing

- Business rules in `EntitlementMapping`, `SubscriptionRepository`, and `SubscriptionViewModel` require Swift Testing coverage.
- StoreKit is not mocked through a live store in unit tests. Mapping is tested with snapshots.

## Dependencies

- Do not add a package dependency for this feature.
