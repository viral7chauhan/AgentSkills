# Architecture

## Architecture Style

A thin SwiftUI screen calls a main-actor view model. The view model calls `SubscriptionRepository`. The repository talks only to `SubscriptionRestoring`. The app supplies `StoreKitRestoreAdapter` as that dependency.

```text
RestorePurchasesView
        ↓
SubscriptionViewModel
        ↓
SubscriptionRepository
        ↓
SubscriptionRestoring
        ↓
StoreKitRestoreAdapter   (app target only)
        ↓
StoreKit 2
```

## Layers / Modules

```text
Presentation (App/) → Domain (Sources/SubscriptionRestore/) → StoreKit adapter (App/)
```

`Sources/SubscriptionRestore/` is the domain library used by unit tests. It must not import SwiftUI or StoreKit.

## Dependency Rules

- Views do not call StoreKit.
- The view model does not call StoreKit.
- Entitlement decisions go through `EntitlementMapping`, which takes a snapshot and returns `SubscriptionAccess`.
- Tests substitute `SubscriptionRestoring`. They do not subclass the adapter.

## Exception Process

An exception to the StoreKit boundary requires an ADR. This sample's decision is `ADR-001`.
