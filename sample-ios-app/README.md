# Subscription Restore sample

iOS 17 SwiftUI app that carries one feature through spec-driven development. The SDD documents in `.sdd/` are the source of truth. This page summarizes them for review.

Last updated: 2026-10-05

## Status at a glance

| Feature | Status | CI | Release ready |
| --- | --- | --- | --- |
| FTR-023 Subscription Restore | `CONVERGED` | [Passing](https://github.com/viral7chauhan/AgentSkills/actions/runs/37344194740) | No |

`CONVERGED` means every requirement traces to a plan item, a task, a passing test, and a green CI run. It does not mean the feature can ship. The open items are listed under [Before release](#before-release).

| Measure | Done |
| --- | --- |
| Requirements verified | 4 of 4 |
| Plan items verified | 5 of 5 |
| Tasks verified | 8 of 8 |
| Test cases passing | 5 of 5 |
| Open clarifications | 0 of 4 |

Branch: `sample/subscription-restore`. It is not merged to `main`, and no pull request is open yet.

## What the feature does

After a reinstall, a subscriber taps Restore Purchases and gets access back without paying again. Restore never starts a purchase.

| Requirement | Rule | Test | Result |
| --- | --- | --- | --- |
| FR-023-001 | An active subscription unlocks content and does not start a purchase | TC-023-001, TC-023-004, TC-023-005 | Pass |
| FR-023-002 | A pending transaction with no active subscription shows "Purchase pending" and stays locked | TC-023-002, TC-023-005 | Pass |
| FR-023-003 | No network shows the offline message, stays locked, and does not retry | TC-023-003 | Pass |
| NFR-023-001 | Restore rules are testable without a live App Store | TC-023-001 | Pass |

Out of scope: a paywall or new purchase, Family Sharing, offers, and translation.

## Decisions already made

| ID | Question | Decision |
| --- | --- | --- |
| Q-001 | Pending with no active subscription | Show "Purchase pending". Keep content locked. |
| Q-002 | Network down during restore | Fail now. No retry queue. Keep content locked. |
| Q-003 | Restore finds nothing | Show "No active subscription found." Do not start a purchase. |
| Q-004 | Active subscription and pending transaction both exist | Active wins. Content unlocks. |
| ADR-001 | Where StoreKit is allowed | Only in `App/StoreKitRestoreAdapter.swift`, behind the `SubscriptionRestoring` protocol |

## Plan progress

Plan version 2 is approved. Version 2 moved the tests from XCTest to Swift Testing.

| Plan item | Work | Status |
| --- | --- | --- |
| P-023-001 | Restore protocol and repository | Verified |
| P-023-002 | Map store state to inactive, pending, or active | Verified |
| P-023-003 | View model copy and unlock rules | Verified |
| P-023-004 | StoreKit adapter | Verified by build and mapping tests. Not run against a live store |
| P-023-005 | Restore Purchases screen | Verified by build and view-model tests. No UI test |

## Evidence

| Check | Result |
| --- | --- |
| `swift test` | 10 Swift Testing tests in 3 suites passed |
| Xcode Run and Test | Passed on a simulator, run manually |
| GitHub Actions [run 37343683468](https://github.com/viral7chauhan/AgentSkills/actions/runs/37343683468) | Passed: artifact check, `swift test`, `xcodebuild test` |
| GitHub Actions [run 37344194740](https://github.com/viral7chauhan/AgentSkills/actions/runs/37344194740) | Passed on the latest commit |
| Plan fingerprint check | Unchanged since version 2 was approved |

## Before release

| Item | Owner | Status |
| --- | --- | --- |
| Restore against a StoreKit sandbox account | iOS team | Not started |
| UI test for the Restore Purchases screen | iOS team | Not planned in this sample |
| SwiftLint or SwiftFormat in CI | iOS team | Not configured |
| Code review and merge to `main` | Team lead | No pull request yet |
| Release notes and rollout plan | Team lead | Not started |

## How to check progress yourself

| Question | Where to look |
| --- | --- |
| Is the feature done? | `.sdd/features/FTR-023-subscription-restore/status.yaml` |
| What proves each plan item? | `.sdd/features/FTR-023-subscription-restore/execution.yaml` |
| Does every requirement have a test? | `.sdd/traceability.yaml` |
| What is the agreed behavior? | `.sdd/features/FTR-023-subscription-restore/spec.md` and `clarify.md` |
| Did someone change the plan without review? | Run the plan check below |
| Is CI green? | [Sample iOS app workflow](https://github.com/viral7chauhan/AgentSkills/actions/workflows/sample-ios-app.yml) |

From `sample-ios-app/`:

```bash
python3 ../enterprise-ios-sdd_v2/scripts/sdd-validate --spec-only
python3 ../enterprise-ios-sdd_v2/scripts/sdd-plan-change-check --feature FTR-023
swift test
```

If the plan check prints `PLAN_CHANGED`, the earlier evidence is stale. Choose implement, validate, or review before treating the feature as converged again.

## Run the app

Open `SubscriptionRestore.xcodeproj` in Xcode and use Run or Test. Signing is off, so a simulator build does not need a team. Turn signing on before installing on a device.

CI is defined in `.github/workflows/sample-ios-app.yml`. It runs on pushes and pull requests that touch `sample-ios-app/`.
