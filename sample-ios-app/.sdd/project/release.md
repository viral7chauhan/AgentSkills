# Release

## Release branches / tags

This sample is not distributed. There is no release branch.

## Readiness

Shipping would require FTR-023 to reach `CONVERGED`, which needs a real CI run. Local `swift test` is not that run.

## Rollback

There is no remote config. Removing the feature means reverting the app target.
