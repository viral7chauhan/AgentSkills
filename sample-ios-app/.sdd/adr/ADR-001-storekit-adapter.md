# ADR-001: StoreKit stays behind SubscriptionRestoring

## Status

Accepted

## Context

Restore must be unit tested without a sandbox Apple ID. Calling StoreKit from the view model would force every test through the store.

## Decision

`SubscriptionRepository` depends on `SubscriptionRestoring`. `StoreKitRestoreAdapter` is the only type that imports StoreKit, and it lives in the app target. Entitlement decisions use `EntitlementMapping` on a snapshot the adapter builds.

## Alternatives Considered

1. Call `AppStore.sync()` from the view model.
2. Add a third-party StoreKit wrapper package.

## Consequences

### Positive

- Unit tests use a fake restorer.
- The pending versus active rules are pure functions.

### Negative / Trade-offs

- The adapter's StoreKit calls are not covered by unit tests. Mapping tests cover the decision table the adapter feeds.

## Related

- Feature/spec: FTR-023
