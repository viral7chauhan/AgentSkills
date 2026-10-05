# Subscription Restore sample

iOS 17 app used to show one feature carried through spec-driven development.

Open `SubscriptionRestore.xcodeproj` in Xcode. The SDD documents are in `.sdd/`.

## Feature

`FTR-023` Subscription Restore. Spec, clarifications, plan, tasks, and test plan are under `.sdd/features/FTR-023-subscription-restore/`.

Current status is `BLOCKED`, not `CONVERGED`. See `status.yaml`.

## What ran on 2026-10-05

| Command | Result |
| --- | --- |
| `swift test` | Passed. 10 Swift Testing tests in 3 suites |
| `xcodebuild` | Not installed, so the app target is not built yet |

Unit tests use Swift Testing (`import Testing`), not XCTest. Run them with:

```bash
swift test
```

A full Xcode install is still required to build `SubscriptionRestore.xcodeproj`.

Signing is off in the project so a simulator build does not need a team. Turn signing on before installing on a device.
