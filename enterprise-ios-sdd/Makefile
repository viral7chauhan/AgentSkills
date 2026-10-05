.PHONY: sdd-feature sdd-execution-check sdd-report sdd-trace sdd-validate

sdd-feature:
	@./scripts/sdd-feature-create "$(NAME)"

sdd-execution-check:
	@./scripts/sdd-execution-check "$(FEATURE)"

sdd-report:
	@./scripts/sdd-report

sdd-trace:
	@echo "Run project-specific traceability generator here."

sdd-validate:
	@echo "Run project-specific build/test/lint/architecture/security/traceability adapters here."
	@./scripts/sdd-report
