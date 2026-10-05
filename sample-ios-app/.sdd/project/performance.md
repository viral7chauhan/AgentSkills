# Performance

This sample has one network-backed action: StoreKit account sync during restore.

- The Restore Purchases button is disabled while a restore is in flight.
- There is no retry loop. A failed sync surfaces one message and waits for another tap.
- Cold start, scrolling, and media budgets are out of scope.
