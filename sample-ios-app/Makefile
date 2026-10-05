SDD_SCRIPTS := ../enterprise-ios-sdd_v2/scripts
FEATURE ?=

.PHONY: test unit-test ci-gate ci build spec-check traceability execution-check validate report status status-check readme readme-check plan-change

test:
	@python3 $(SDD_SCRIPTS)/sdd-test

unit-test:
	swift test

ci-gate:
	@python3 $(SDD_SCRIPTS)/sdd-ci-gate

ci: validate status-check readme-check test ci-gate

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
	@python3 $(SDD_SCRIPTS)/sdd-execution-check $(if $(FEATURE),--feature $(FEATURE),)

validate:
	@python3 $(SDD_SCRIPTS)/sdd-validate
	@python3 $(SDD_SCRIPTS)/sdd-trace
	@python3 $(SDD_SCRIPTS)/sdd-execution-check

report:
	@python3 $(SDD_SCRIPTS)/sdd-report

status:
	@python3 $(SDD_SCRIPTS)/sdd-status

status-check:
	@python3 $(SDD_SCRIPTS)/sdd-status --check

readme: status
	@python3 $(SDD_SCRIPTS)/sdd-report --update-readme README.md

readme-check:
	@python3 $(SDD_SCRIPTS)/sdd-report --check-readme README.md

plan-change:
	@if [ -n "$(FEATURE)" ]; then \
		python3 $(SDD_SCRIPTS)/sdd-plan-change-check --feature $(FEATURE); \
	else \
		for dir in .sdd/features/FTR-*; do \
			python3 $(SDD_SCRIPTS)/sdd-plan-change-check --feature $$(basename $$dir | cut -d- -f1-2) || exit 1; \
		done; \
	fi
