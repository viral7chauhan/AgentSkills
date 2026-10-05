# Project Constitution

Non-negotiable rules for the Subscription Restore sample.

## Architecture

- Presentation depends on domain. Domain does not import SwiftUI, UIKit, or StoreKit.
- StoreKit is allowed only in `App/StoreKitRestoreAdapter.swift`.
- New business behavior is reached through a protocol so tests can substitute a fake.
- Do not bypass that boundary to call StoreKit from a view or view model.

## Product intent

- Do not invent product behavior.
- Ambiguous requirements stay in the feature `clarify.md` until a human decides them.
- Restore Purchases must never start a new purchase.

## Testing

- New business behavior requires an automated unit test.
- A regression requires a regression test.
- UI copy that gates unlock behavior is asserted through the view model.

## Dependencies

- Dependencies are Apple SDK frameworks already on the platform: SwiftUI, Observation, StoreKit, and the Swift Testing library shipped with the toolchain.
- A new package dependency requires an ADR before it is added.

## Security

- Never commit secrets.
- Never put customer identifiers, receipts, or Apple IDs into SDD artifacts or logs.

## AI development

- `.sdd/` is the source of truth.
- Agents produce evidence for completion.
- A changed feature plan invalidates prior verification.
