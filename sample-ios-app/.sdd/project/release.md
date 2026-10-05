# Release

## Release branches / tags

This sample is not distributed. There is no release branch.

## Readiness

Shipping would require FTR-023 to reach `CONVERGED`. That needs a green run of `.github/workflows/sample-ios-app.yml`. A local `swift test` or a manual Xcode run is not that run.

## Rollback

There is no remote config. Removing the feature means reverting the app target.
