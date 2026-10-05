SHELL := /bin/bash
SCRIPTS := ./scripts

bootstrap:
	@$(SCRIPTS)/sdd-bootstrap

spec-check:
	@$(SCRIPTS)/sdd-validate --spec-only

traceability:
	@$(SCRIPTS)/sdd-trace

execution-check:
	@$(SCRIPTS)/sdd-execution-check $(if $(FEATURE),--feature $(FEATURE),)

validate:
	@$(SCRIPTS)/sdd-validate
	@$(SCRIPTS)/sdd-trace
	@$(SCRIPTS)/sdd-execution-check

report:
	@$(SCRIPTS)/sdd-report

package-sync-check:
	@$(SCRIPTS)/package-sync-check

feature:
	@echo 'Usage: ./scripts/sdd-feature-create FTR-### "Feature Name"'

plan-change:
	@$(SCRIPTS)/sdd-plan-change-check --feature $(FEATURE) --mode $(or $(MODE),ask)

mcp-recommend:
	@$(SCRIPTS)/sdd-mcp-recommend $(if $(FEATURE),--feature $(FEATURE),)
