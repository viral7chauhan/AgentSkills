# Subscription Restore sample

iOS 17 app used to show one feature carried through spec-driven development.

Open `SubscriptionRestore.xcodeproj` in Xcode. The SDD documents are in `.sdd/`.

## Feature

`FTR-023` Subscription Restore. Spec, clarifications, plan, tasks, and test plan are under `.sdd/features/FTR-023-subscription-restore/`.

Current status is `CONVERGED`. It is not release-ready. See `status.yaml`.

CI is [Sample iOS app](https://github.com/viral7chauhan/AgentSkills/actions/runs/37343683468). The workflow validates the feature artifacts, runs `swift test`, and runs the Xcode test action on an iPhone simulator.

## What ran on 2026-10-05

| Command | Result |
| --- | --- |
| `swift test` | Passed. 10 Swift Testing tests in 3 suites |
| Xcode Run and Test | Passed, confirmed manually in Xcode |

Unit tests use Swift Testing (`import Testing`), not XCTest. Run them with:

```bash
swift test
```

Open `SubscriptionRestore.xcodeproj` and use Run or Test. Signing is off so a simulator build does not need a team. Turn signing on before installing on a device.
