# FTR-023: Subscription Restore

## Problem

A subscriber who reinstalls the app, or moves to a new device, has already paid. They need a way to recover access without buying the subscription again.

## Objective

Restore Purchases reattaches an active auto-renewable subscription on the current Apple ID and unlocks subscriber content. It never starts a purchase.

## Scope

### In scope

- A Restore Purchases action.
- Reading the current Apple ID's auto-renewable entitlement after a StoreKit sync.
- Subscriber, pending, empty, and offline outcomes.
- Keeping content locked unless the entitlement is active.

### Out of scope

- Starting a new purchase or presenting a paywall.
- Family Sharing, introductory offers, promotional offers, and consumables.
- Non-renewing subscriptions.
- Localized copy beyond English.
- Server-side receipt validation.

## User Flows

1. The subscriber opens the app after reinstall and taps Restore Purchases.
2. The app syncs with the App Store and reads current entitlements.
3. An active auto-renewable entitlement unlocks content and shows "Subscription restored."
4. An unfinished auto-renewable transaction, with no active entitlement, shows "Purchase pending" and stays locked.
5. No entitlement shows "No active subscription found." and stays locked.
6. A network failure during sync shows "No connection. Try again when you're back online." and stays locked.

## Functional Requirements

### FR-023-001

When the current Apple ID has an active auto-renewable subscription, Restore Purchases sets subscriber state and does not start a purchase.

### FR-023-002

When StoreKit reports an unfinished auto-renewable transaction and no active entitlement, the app shows a pending state and does not unlock content.

### FR-023-003

When the store sync fails because the network is unavailable, the app shows an offline message, does not unlock content, and does not queue the restore.

## Non-Functional Requirements

### NFR-023-001

The entitlement decision and the view-model outcome are unit-testable without a sandbox Apple ID or a live App Store.

## Acceptance Criteria

### AC-023-001

Given: the Apple ID has an active auto-renewable subscription  
When: the user taps Restore Purchases  
Then: the app shows the subscriber state, unlocks content, and does not start a purchase

### AC-023-002

Given: StoreKit has an unfinished auto-renewable transaction and no active entitlement  
When: the user taps Restore Purchases  
Then: the app shows "Purchase pending" and content stays locked

### AC-023-003

Given: the device cannot reach the App Store  
When: the user taps Restore Purchases  
Then: the app shows "No connection. Try again when you're back online." and content stays locked

## Edge Cases

- Active entitlement and an unfinished transaction both exist: active wins, content unlocks.
- The store returns no auto-renewable entitlement: content stays locked and no purchase sheet is presented.
- A second tap while restore is in flight does nothing. The button is disabled until the call finishes.

## Error Handling

- `RestoreError.networkUnavailable` maps to the offline message.
- Any other store failure maps to "The App Store could not be reached. Try again."
- Store error text is not shown to the user.

## Analytics

No analytics SDK. The view model exposes a `ViewState` the screen renders. A future event may record that enum only, never an Apple ID or transaction id.

## Accessibility / Localization

- The button label is "Restore Purchases".
- The status message is plain text, so VoiceOver reads it.
- Copy is English. Moving strings into a String Catalog is out of scope.

## Security / Privacy

- The app does not persist receipts or transaction identifiers.
- Status copy does not include store payloads.

## Dependencies / Constraints

- StoreKit 2 on iOS 17.
- No new Swift packages. See ADR-001.
