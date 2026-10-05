SDD_SCRIPTS := ../enterprise-ios-sdd_v2/scripts
FEATURE ?= FTR-023

.PHONY: test build spec-check traceability execution-check validate report plan-change

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

spec-check:
	@python3 $(SDD_SCRIPTS)/sdd-validate --spec-only

traceability:
	@python3 $(SDD_SCRIPTS)/sdd-trace

execution-check:
	@python3 $(SDD_SCRIPTS)/sdd-execution-check

validate:
	@python3 $(SDD_SCRIPTS)/sdd-validate
	@python3 $(SDD_SCRIPTS)/sdd-trace
	@python3 $(SDD_SCRIPTS)/sdd-execution-check

report:
	@python3 $(SDD_SCRIPTS)/sdd-report

plan-change:
	@python3 $(SDD_SCRIPTS)/sdd-plan-change-check --feature $(FEATURE)
