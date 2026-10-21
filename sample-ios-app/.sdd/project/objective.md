# Project Objective

## Purpose

Show one iOS feature carried through spec-driven development: a subscriber can restore an existing App Store subscription after reinstall without being charged again.

## Users

People who already paid for a subscription on this Apple ID and need access back on a new install.

## Product Objectives

- [x] Restore an active auto-renewable subscription from the device's App Store account.
- [x] Keep content locked when the store returns pending, empty, or a network failure.
- [x] Make the decision table testable without a live App Store.

## Success Metrics

- Restore of an active entitlement ends in the subscriber state.
- No restore path sets `startedNewPurchase`.

## Non-goals

- Family Sharing, promotional offers, win-back offers, and consumables.
- A paywall or a new purchase flow.
- Account systems other than the App Store.

## Constraints

- Platform: iOS 17.
- StoreKit 2 is the only store integration.
- English copy only in this sample.
