# Clarifications

| ID | Question | Impact | Decision | Status |
|---|---|---|---|---|
| Q-001 | What happens when StoreKit reports an unfinished auto-renewable transaction and no active entitlement? | Unlock rules | Show "Purchase pending". Do not unlock content. | DECIDED |
| Q-002 | What happens when the network is unavailable during sync? | Error handling | Fail immediately. Do not queue a retry. Do not unlock. | DECIDED |
| Q-003 | What happens when sync succeeds and there is no auto-renewable entitlement? | Empty state | Show "No active subscription found." Do not start a purchase. | DECIDED |
| Q-004 | If an active entitlement and an unfinished transaction both exist, which wins? | Unlock rules | Active wins. Content unlocks. | DECIDED |
