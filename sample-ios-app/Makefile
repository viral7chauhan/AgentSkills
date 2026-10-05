.PHONY: test build

test:
	swift test

build:
	xcodebuild \
		-project SubscriptionRestore.xcodeproj \
		-scheme SubscriptionRestore \
		-destination 'generic/platform=iOS Simulator' \
		-quiet \
		CODE_SIGNING_ALLOWED=NO \
		build
